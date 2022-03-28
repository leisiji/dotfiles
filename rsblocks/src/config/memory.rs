use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Memory {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for Memory {
    fn default() -> Self {
        Memory {
            icon: String::from(""),
            enabled: true,
            delay: 2.0,
        }
    }
}
