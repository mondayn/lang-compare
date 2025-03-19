package main

import (
	"bufio"
	"fmt"
	"os"
	"runtime"
	"strings"
	"time"
)

// this func measures 35% slower than scanfile
// func countLines(filename string) (int, error) {
// 	data, err := os.ReadFile(filename)
// 	if err != nil {
// 		return 0, err
// 	}
// 	return len(strings.Split(string(data), "\n")), nil
// }

func readfile(approach string) int {

	file_path := "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"
	line_count := 0

	start := time.Now() // Record start time

	var memBefore, memAfter runtime.MemStats
	runtime.GC()
	runtime.ReadMemStats(&memBefore)

	if approach == "scanner" {

		file, _ := os.Open(file_path)
		defer file.Close()

		scanner := bufio.NewScanner(file)
		const maxBufferSize = 1024 * 1024 // 1MB
		buf := make([]byte, maxBufferSize)
		scanner.Buffer(buf, maxBufferSize)

		for scanner.Scan() {
			_ = scanner.Text()
			line_count += 1
			// fmt.Println(line)
		}
	} else {

		data, err := os.ReadFile(file_path)
		if err != nil {
			return 0
		}
		lines := strings.Split(string(data), "\n")
		for range lines {
			line_count += 1
		}
	}

	// Measure memory after reading
	runtime.ReadMemStats(&memAfter)
	duration := time.Since(start) // Calculate elapsed time

	fmt.Println(approach)
	fmt.Println("MB used: ", float64(memAfter.Alloc-memBefore.Alloc)/1024/1024)
	//fmt.Println("Memory used: %.2f MB", float64(memAfter.Alloc-memBefore.Alloc)/1024/1024)
	fmt.Println("Execution time:", duration)

	return line_count
}

func main() {
	lines := readfile("scanner")
	fmt.Println("Total lines:", lines)
	_ = readfile("readfile")
}
