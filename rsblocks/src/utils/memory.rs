use crate::config::CONFIG;
use crate::types::ThreadsData;
use std::fs::read_to_string;
use std::str::FromStr;

/*
mem_used = (mem_total + shmem - mem_free - mem_buffers - mem_cached - mem_srecl
thanks for htop's developer on stackoverflow for providing this algorithm to
calculate used memory.
*/
pub async fn get_memory() -> ThreadsData {
    let buf = match read_to_string("/proc/meminfo") {
        Ok(data) => data,
        _ => return ThreadsData::Memory(String::from("Error Reading memory!")),
    };

    let mut mem_total: u64 = 0;
    let mut swap_total: u64 = 0;

    let mut mem_free: u64 = 0;
    let mut swap_free: u64 = 0;

    let mut buffers: u64 = 0;
    let mut cache: u64 = 0;
    let mut reclaim: u64 = 0;

    for line in buf.lines() {
        if line.starts_with("MemTotal") {
            assign_val(line, &mut mem_total);
        } else if line.starts_with("MemFree") {
            assign_val(line, &mut mem_free);
        } else if line.starts_with("SwapFree") {
            assign_val(line, &mut swap_free);
        } else if line.starts_with("SwapTotal") {
            assign_val(line, &mut swap_total);
        } else if line.starts_with("Buffers") {
            assign_val(line, &mut buffers);
        } else if line.starts_with("Cached") {
            assign_val(line, &mut cache);
        } else if line.starts_with("SReclaimable") {
            assign_val(line, &mut reclaim);
        }
    }

    let mem_used =
        (mem_total + swap_total - mem_free - swap_free - buffers - cache - reclaim) / 1024;
    let result: String;
    if mem_used > 1000 {
        result = format!(
            "  {}  {:.1}G  {}",
            CONFIG.memory.icon,
            mem_used as f64 / 1000.0,
            CONFIG.seperator
        );
    } else {
        result = format!(
            "  {}  {}M  {}",
            CONFIG.memory.icon, mem_used, CONFIG.seperator
        );
    }
    ThreadsData::Memory(result)
}

/*
this helper function will split the line(first argument) by the character(:)
and then parse the right splited item as u32
then assign that to the "assignable"(2nd argument).
*/
fn assign_val(line: &str, val: &mut u64) {
    let line = line.split_whitespace().collect::<Vec<&str>>();
    *val = u64::from_str(line[1]).unwrap();
}
