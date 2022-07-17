pub enum ThreadsData {
    Memory(String),
    Time(String),
    Battery(String),
    CpuTemp(String),
    LoadAvg(String),
    NetSpeed(String),
}

#[derive(Clone)]
pub struct Config {
    pub seperator: String,
    pub time: Time,
    pub memory: Memory,
    pub battery: Battery,
    pub cpu_temperature: CpuTemp,
    pub uptime: Uptime,
    pub loadavg: LoadAvg,
    pub pub_ip: PubIp,
    pub local_ip: LocalIp,
    pub brightness: Brightness,
}

#[derive(Clone)]
pub struct Time {
    pub format: String,
    pub icon: String,
    pub delay: f64,
}

#[derive(Clone)]
pub struct Memory {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

#[derive(Clone)]
pub struct Volume {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
    pub card: String,
}

#[derive(Clone)]
pub struct Battery {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

#[derive(Clone)]
pub struct CpuTemp {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

#[derive(Clone)]
pub struct Uptime {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

#[derive(Clone)]
pub struct LoadAvg {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

#[derive(Clone)]
pub struct NetSpeed {
    pub transmit_icon: String,
    pub recieve_icon: String,
    pub interface: String,
    pub enabled: bool,
}

#[derive(Clone)]
pub struct PubIp {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

#[derive(Clone)]
pub struct LocalIp {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

#[derive(Clone)]
pub struct Brightness {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
    pub path: String,
}
