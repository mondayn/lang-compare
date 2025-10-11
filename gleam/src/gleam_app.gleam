# gleam run

import gleam/io
import gleam/int
import gleam/float
import gleam/string
import gleam/list
import simplifile

pub fn main() {
  let filename = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"
  
  // Start timing (microseconds)
  let start = erlang_monotonic_time()
  
  // Read file and process lines
  let line_count = case simplifile.read(filename) {
    Ok(content) -> {
      content
      |> string.split("\n")
      |> list.length()
    }
    Error(_) -> {
      io.println("Error: Could not read file")
      0
    }
  }
  
  // End timing
  let end = erlang_monotonic_time()
  let duration_us = end - start
  let duration_ms = int.to_float(duration_us) /. 1000.0
  let duration_s = duration_ms /. 1000.0
  
  // Print results
  io.println("File: " <> filename)
  io.println("Lines read: " <> int.to_string(line_count))
  io.println("Duration: " <> float.to_string(duration_ms) <> " ms")
  io.println("Duration: " <> float.to_string(duration_s) <> " seconds")
  io.println("Duration: " <> int.to_string(duration_us) <> " microseconds")
}

// FFI to call Erlang's monotonic_time
@external(erlang, "erlang", "monotonic_time")
fn erlang_monotonic_time() -> Int