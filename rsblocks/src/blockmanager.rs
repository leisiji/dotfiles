use crate::types::ThreadsData;
use breadx::{display::*, Window};

pub struct BlockManager {
    pub disp: Display<name::NameConnection>,
    blocks: Vec<String>,
    pub root: Window,
}

impl BlockManager {
    pub fn new() -> Self {
        let disp = Display::create(None, None).expect("Failed to create x11 connection");
        let root = disp.default_screen().root;
        Self {
            disp,
            blocks: vec![String::from(""); 16],
            root,
        }
    }
    // TODO let the user control the indexes of the blocks
    pub fn update(&mut self, data: ThreadsData) {
        match data {
            ThreadsData::NetSpeed(x) => self.blocks[4] = x,
            ThreadsData::Memory(x) => self.blocks[9] = x,
            ThreadsData::CpuTemp(x) => self.blocks[10] = x,
            ThreadsData::LoadAvg(x) => self.blocks[11] = x,
            ThreadsData::Battery(x) => self.blocks[13] = x,
            ThreadsData::Time(x) => self.blocks[15] = x,
        }
        let mut x = String::new();
        for i in self.blocks.iter() {
            x.push_str(i.as_str());
        }

        self.root
            .set_title(&mut self.disp, &x)
            .expect("Failed to set title");
    }
}

impl Default for BlockManager {
    fn default() -> Self {
        Self::new()
    }
}
