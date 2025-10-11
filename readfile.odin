/* 737ms without speed build

./odin build readfile.odin -file -o:speed
./readfile

*/

package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:time"

main :: proc() {   
    filename := "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"
 
    // Start timing
    start := time.now()
    
    // Read the entire file
    data, ok := os.read_entire_file(filename)
    if !ok {
        fmt.printf("Failed to read file: %s\n", filename)
        os.exit(1)
    }
    defer delete(data)
    
    // Convert to string
    content := string(data)
    
    // Split into lines
    lines := strings.split_lines(content)
    defer delete(lines)
    
    // Process each line
    line_count := 0
    for line in lines {
        line_count += 1
        // You can process each line here
        // fmt.printf("Line %d: %s\n", line_count, line)
    }
    
    // End timing
    end := time.now()
    duration := time.diff(start, end)
    
    // Print results
    fmt.printf("File: %s\n", filename)
    fmt.printf("Lines read: %d\n", line_count)
    fmt.printf("Duration: %v\n", duration)
    fmt.printf("Duration (ms): %.3f\n", time.duration_milliseconds(duration))
    fmt.printf("Duration (μs): %.0f\n", time.duration_microseconds(duration))
}