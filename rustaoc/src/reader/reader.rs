use std::fs::{File};
use std::io::{self, BufRead, BufReader, Lines};
use std::path::Path;

pub fn read_input_file_lines<P>(input_file_path: P) -> io::Result<Lines<BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(input_file_path)?;
    Ok(BufReader::new(file).lines())
}
