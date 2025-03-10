package main

import (
	"bufio"
	"fmt"
	"os"
	"runtime"
	"time"
)

// func countLines(filename string) (int, error) {
// 	data, err := os.ReadFile(filename)
// 	if err != nil {
// 		return 0, err
// 	}
// 	return len(strings.Split(string(data), "\n")), nil
// }

func measure_memory(filename string) int {
	var memBefore, memAfter runtime.MemStats
	runtime.GC()
	runtime.ReadMemStats(&memBefore)

	file, _ := os.Open(filename)
	defer file.Close()

	// Read file line by line
	scanner := bufio.NewScanner(file)

	const maxBufferSize = 1024 * 1024 // 1MB
	buf := make([]byte, maxBufferSize)
	scanner.Buffer(buf, maxBufferSize)

	lines := 0
	for scanner.Scan() {
		_ = scanner.Text()
		lines += 1
		// fmt.Println(line)
	}

	// Measure memory after reading
	runtime.ReadMemStats(&memAfter)

	// Print memory usage
	fmt.Printf("Memory used: %.2f MB\n", float64(memAfter.Alloc-memBefore.Alloc)/1024/1024)
	return lines
}

func main() {
	start := time.Now() // Record start time
	file := "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"
	lines := measure_memory(file)
	// lines, err := countLines(file)
	fmt.Println("Total lines:", lines)
	duration := time.Since(start) // Calculate elapsed time
	fmt.Println("Execution time:", duration)

}
