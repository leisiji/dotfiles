use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct CpuTemp {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for CpuTemp {
    fn default() -> Self {
        CpuTemp {
            icon: String::from(""),
            enabled: false,
            delay: 120.0,
        }
    }
}
