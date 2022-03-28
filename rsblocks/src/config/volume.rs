use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Volume {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
    pub card: String,
}

impl Default for Volume {
    fn default() -> Self {
        Volume {
            icon: String::from(""),
            enabled: false,
            delay: 0.17,
            card: String::from("ALSA"),
        }
    }
}
