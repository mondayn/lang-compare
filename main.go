package main

import (
	"fmt"
	"os"
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

func main() {
	start := time.Now() // Record start time
	lines, err := countLines("/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv")
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	fmt.Println("Total lines:", lines)
	duration := time.Since(start) // Calculate elapsed time
	fmt.Println("Execution time:", duration)
}
