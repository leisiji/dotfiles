use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Time {
    pub format: String,
    pub icon: String,
    pub delay: f64,
}

impl Default for Time {
    fn default() -> Self {
        Time {
            format: String::from("%T"),
            icon: String::from(""),
            delay: 1.0,
        }
    }
}
