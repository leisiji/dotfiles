mod battery;
mod bitcoins;
mod brightness;
mod cputemp;
mod disk;
mod loadavg;
mod local_ip;
mod memory;
mod mpd;
mod netspeed;
mod pub_ip;
mod spotify;
mod time;
mod uptime;
mod weather;

use self::battery::Battery;
use cputemp::CpuTemp;
use disk::Disk;
use loadavg::LoadAvg;
use memory::Memory;
use netspeed::NetSpeed;
use time::Time;
use uptime::Uptime;

use std::default::Default;
use std::fs::File;
use std::io::Read;

use lazy_static::lazy_static;
use serde::{Deserialize, Serialize};

lazy_static! {
    pub static ref CONFIG: Config = {
        let yml_source = std::env::var("HOME").unwrap() + "/.config/rsblocks/rsblocks.yml";
        let mut data = String::new();

        match File::open(&yml_source) {
            Ok(mut file) => {
                file.read_to_string(&mut data)
                    .expect("Failed to read config to string");
                serde_yaml::from_str(&data).unwrap_or_else(move |e| {
                    eprintln!(
                        "Failed to parse config: {}\nloading defaults!",
                        e.to_string()
                    );
                    Config::default()
                })
            }
            Err(_) => Config::default(),
        }
    };
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Config {
    #[serde(default = "default_seperator")]
    pub seperator: String,

    #[serde(default)]
    pub time: Time,

    #[serde(default)]
    pub memory: Memory,

    #[serde(default)]
    pub disk: Disk,

    #[serde(default)]
    pub battery: Battery,

    #[serde(default)]
    pub cpu_temperature: CpuTemp,

    #[serde(default)]
    pub uptime: Uptime,

    #[serde(default)]
    pub loadavg: LoadAvg,

    #[serde(default)]
    pub netspeed: NetSpeed,
}

impl Default for Config {
    fn default() -> Self {
        Self {
            seperator: "|".to_string(),
            time: Default::default(),
            memory: Default::default(),
            disk: Default::default(),
            battery: Default::default(),
            cpu_temperature: Default::default(),
            uptime: Default::default(),
            loadavg: Default::default(),
            netspeed: Default::default(),
        }
    }
}

fn default_seperator() -> String {
    "|".to_string()
}
