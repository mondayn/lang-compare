use std::fs::File;
use std::io::{self, BufRead};
use std::time::Instant;
use std::mem;

fn main() -> io::Result<()> {
    let file_path = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv";
    
    // Measure the start time
    let start = Instant::now();

    // Open the file
    let file = File::open(file_path)?;
    let reader = io::BufReader::new(file);

    let mut total_size = 0; // To track the memory used by each line

    // for line in reader.lines() 
    for line in reader.split(b'\n') {
        let line = line?; // Read each line
        total_size += mem::size_of_val(&line); // Estimate the memory used by the line
    }

    // Measure the duration
    let duration = start.elapsed();
    let duration_ms = duration.as_millis();

    // Output the results
    println!("Time taken: {} milliseconds", duration_ms);
    println!("Memory used: {} mb", total_size /1024 / 1024);

    Ok(())
}
