use serde::{Deserialize, Serialize};
use std::default::Default;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Spotify {
    pub icon: String,
    pub enabled: bool,
    pub delay: f64,
}

impl Default for Spotify {
    fn default() -> Self {
        Spotify {
            icon: String::from(""),
            enabled: false,
            delay: 15.0,
        }
    }
}
