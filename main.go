package main

import (
	"bufio"
	"fmt"
	"os"
	"runtime"
	"strings"
	"time"
)

func countLines(filename string) (int, error) {
	data, err := os.ReadFile(filename)
	if err != nil {
		return 0, err
	}
	return len(strings.Split(string(data), "\n")), nil
}

func measure_memory(filename string) {
	var memBefore, memAfter runtime.MemStats
	runtime.GC()
	runtime.ReadMemStats(&memBefore)

	// Open the file
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	// Read file line by line
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		_ = scanner.Text() // Process each line (optional)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading file:", err)
	}

	// Measure memory after reading
	runtime.ReadMemStats(&memAfter)

	// Print memory usage
	fmt.Printf("Memory used: %.2f MB\n", float64(memAfter.Alloc-memBefore.Alloc)/1024/1024)
}

func main() {
	start := time.Now() // Record start time
	file := "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"
	lines, err := countLines(file)
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	fmt.Println("Total lines:", lines)
	duration := time.Since(start) // Calculate elapsed time
	fmt.Println("Execution time:", duration)

	measure_memory(file)

}
