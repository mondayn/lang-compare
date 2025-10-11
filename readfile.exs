# elixir readfile.exs

defmodule FileReader do
  def main(_args) do
    filename = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"
    read_file_with_timing(filename)
  end

  defp read_file_with_timing(filename) do
    # Start timing
    start_time = System.monotonic_time(:microsecond)
    
    # Read file line by line
    line_count = case File.stream!(filename) do
      stream ->
        stream
        |> Enum.reduce(0, fn _line, count ->
          # Process each line here if needed
          count + 1
        end)
    end
    
    # End timing
    end_time = System.monotonic_time(:microsecond)
    duration_us = end_time - start_time
    duration_ms = duration_us / 1000
    duration_s = duration_ms / 1000
    
    # Print results
    IO.puts("File: #{filename}")
    IO.puts("Lines read: #{line_count}")
    IO.puts("Duration: #{:erlang.float_to_binary(duration_ms, decimals: 3)} ms")
    IO.puts("Duration: #{:erlang.float_to_binary(duration_s, decimals: 6)} seconds")
    IO.puts("Duration: #{duration_us} microseconds")
  end
end

# Run the program
FileReader.main([])