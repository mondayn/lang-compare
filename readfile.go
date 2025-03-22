// go run readfile.go

package main

import (
	"bufio"
	"fmt"
	"os"
	"runtime"
	"time"
)

func readfile() int {

	file_path := "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"
	line_count := 0

	start := time.Now()
	var memBefore, memAfter runtime.MemStats
	runtime.GC()
	runtime.ReadMemStats(&memBefore)

	file, _ := os.Open(file_path)
	defer file.Close()

	scanner := bufio.NewScanner(file)
	const maxBufferSize = 1024 * 1024 // 1MB
	buf := make([]byte, maxBufferSize)
	scanner.Buffer(buf, maxBufferSize)

	for scanner.Scan() {
		_ = scanner.Text() // duration reduces to 35 ms without this
		//_ = strings.Split(line, ",")
		line_count += 1
		// fmt.Println(line)
	}

	runtime.ReadMemStats(&memAfter)
	duration := time.Since(start) // Calculate elapsed time

	fmt.Println("MB used: ", float64(memAfter.Alloc-memBefore.Alloc)/1024/1024)
	fmt.Println("Execution time:", duration)

	return line_count
}

func main() {
	lines := readfile()
	fmt.Println("Total lines:", lines)
}
