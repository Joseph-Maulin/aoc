use crate::reader::read_input_file_lines;

pub fn day1_p1(input_file_path: &str) {
    match read_input_file_lines::<&str>(input_file_path) {
        Ok(lines) => {
            let mut floor = 0;
            for line in lines {
                let line = line.unwrap();
                for char in line.chars() {
                    match char {
                        '(' => floor += 1,
                        ')' => floor -= 1,
                        _ => {},
                    }
                }
            }

            println!("Result floor {floor}");
        }
        Err(e) => eprintln!("Error opening file: {}", e),
    }
}

pub fn day1_p2(input_file_path: &str) {
    match read_input_file_lines::<&str>(input_file_path) {
        Ok(lines) => {
            let mut floor = 0;
            let mut index = 0;
            for line in lines {
                let line = line.unwrap();
                for char in line.chars() {
                    match char {
                        '(' => floor += 1,
                        ')' => floor -= 1,
                        _ => {},
                    }
                    if floor == -1 {
                        println!("First time floor goes below 0: {}", index + 1);
                        return;
                    }
                    index += 1;
                }
            }
        }
        Err(e) => eprintln!("Error opening file: {}", e),
    }
}
