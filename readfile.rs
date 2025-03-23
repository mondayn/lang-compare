// to compile: rustc -C opt-level=3 -C target-cpu=native readfile.rs -o readfile
// to run: ./readfile

use std::fs::File;
use std::io::{self, BufRead};
use std::time::Instant;
// use std::mem;

fn count_lines<T: BufRead>(reader: &mut T) -> usize {
    reader.lines().count()
}

fn _parse_and_count_lines<T: BufRead>(reader: &mut T) -> usize {
    let mut line_count = 0;
    for line in reader.lines() {
        if let Ok(line) = line {
            let _tokens: Vec<&str> = line.split(',').collect();
//            println!("{:?}", tokens); // Print tokens (parsed by comma)
            line_count += 1;
        }
    }
    line_count
}

fn main() -> io::Result<()> {
    let file_path = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv";
    
    // Measure the start time
    let start = Instant::now();

    // Open the file
    let file = File::open(file_path)?;
    let mut reader = io::BufReader::new(file);

    // let line_count = parse_and_count_lines(&mut reader);
    let line_count = count_lines(&mut reader);

//    let mut total_size = 0; // To track the memory used by each line
//    let mut line_count = 0;

    // for line in reader.lines() {
    //     if let Ok(_line) = line {
    //         //let _tokens: Vec<&str> = line.split(',').collect(); // Split by ","
    //         //println!("{:?}", tokens); // Print parsed values
    //         line_count += 1;
    //     }
    // }
   println!("lines are {}", line_count); 


    // for line in reader.lines() 
    // for line in reader.split(b'\n') {
    //     let line = line?; // Read each line
    //     // total_size += mem::size_of_val(&line); // Estimate the memory used by the line
    // }

    // Measure the duration
    let duration = start.elapsed();
    let duration_ms = duration.as_millis();

    // Output the results
    println!("Time taken: {} milliseconds", duration_ms);
    // println!("Memory used: {} mb", total_size /1024 / 1024);

    Ok(())
}
