use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Uptime {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for Uptime {
    fn default() -> Self {
        Uptime {
            icon: String::from(""),
            enabled: false,
            delay: 60.0,
        }
    }
}
