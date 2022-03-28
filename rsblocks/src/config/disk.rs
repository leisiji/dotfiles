use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Disk {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for Disk {
    fn default() -> Self {
        Disk {
            icon: String::from(""),
            enabled: false,
            delay: 60.0,
        }
    }
}
