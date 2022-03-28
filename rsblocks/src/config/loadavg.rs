use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct LoadAvg {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for LoadAvg {
    fn default() -> Self {
        LoadAvg {
            icon: String::from(""),
            enabled: false,
            delay: 60.0,
        }
    }
}
