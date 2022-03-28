use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Weather {
    pub city: String,
    pub format: String,
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for Weather {
    fn default() -> Self {
        Weather {
            city: String::from(""),
            format: String::from("+%t"),
            icon: String::from(""),
            enabled: false,
            delay: 7200.0, //7200 seconds = 2 hours
        }
    }
}
