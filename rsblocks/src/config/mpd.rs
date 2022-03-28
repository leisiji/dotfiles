use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Mpd {
    pub icon: String,
    pub host: String,
    pub port: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for Mpd {
    fn default() -> Self {
        Mpd {
            icon: String::from(""),
            host: String::from("127.0.0.1"),
            port: String::from("6600"),
            enabled: false,
            delay: 15.0,
        }
    }
}
