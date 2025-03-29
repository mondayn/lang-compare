package main

import (
	"bufio"
	"database/sql"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	_ "github.com/lib/pq"
)

// Configuration flags

var (
	filePath   = flag.String("file", "/home/nathan/lang-compare/sample.csv", "Path to the CSV file")
	dbHost     = flag.String("host", "localhost", "PostgreSQL host")
	dbPort     = flag.Int("port", 5432, "PostgreSQL port")
	dbUser     = flag.String("user", "test", "PostgreSQL user")
	dbPassword = flag.String("password", "pw", "PostgreSQL password")
	dbName     = flag.String("dbname", "util", "PostgreSQL database name")
	tableName  = flag.String("table", "tract", "PostgreSQL table name")
	batchSize  = flag.Int("batch", 5000, "Batch size for inserts")
	delimiter  = flag.String("delimiter", ",", "CSV delimiter")
)

func main() {
	flag.Parse()

	// Validate required flags
	if *filePath == "" || *dbName == "" || *tableName == "" {
		log.Fatal("Required flags: -file, -dbname, and -table")
	}

	// Start time measurement
	startTime := time.Now()

	// Connect to PostgreSQL
	connStr := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		*dbHost, *dbPort, *dbUser, *dbPassword, *dbName)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	// Verify connection
	if err := db.Ping(); err != nil {
		log.Fatalf("Failed to ping database: %v", err)
	}
	log.Println("Connected to PostgreSQL database")

	// Open file
	file, err := os.Open(*filePath)
	if err != nil {
		log.Fatalf("Failed to open file: %v", err)
	}
	defer file.Close()

	// Create scanner
	scanner := bufio.NewScanner(file)

	// Skip header line
	if scanner.Scan() {
		headerLine := scanner.Text()
		log.Printf("Skipped header: %s", headerLine)

		// Use header to determine column count (for placeholder creation below)
		columns := strings.Split(headerLine, *delimiter)
		log.Printf("Detected %d columns", len(columns))
	}

	// Prepare for batch inserts
	batch := make([]string, 0, *batchSize)
	totalRows := 0

	// Begin transaction
	tx, err := db.Begin()
	if err != nil {
		log.Fatalf("Failed to begin transaction: %v", err)
	}

	// Read file line by line
	for scanner.Scan() {
		line := scanner.Text()
		if strings.TrimSpace(line) == "" {
			continue // Skip empty lines
		}

		// Add to batch
		batch = append(batch, line)

		// If batch is full, insert
		if len(batch) >= *batchSize {
			if err := insertBatch(tx, batch, *tableName, *delimiter); err != nil {
				tx.Rollback()
				log.Fatalf("Failed to insert batch: %v", err)
			}
			totalRows += len(batch)
			// log.Printf("Inserted %d rows so far", totalRows)
			batch = batch[:0] // Clear batch
		}
	}

	// Insert remaining rows
	if len(batch) > 0 {
		if err := insertBatch(tx, batch, *tableName, *delimiter); err != nil {
			tx.Rollback()
			log.Fatalf("Failed to insert remaining batch: %v", err)
		}
		totalRows += len(batch)
	}

	// Commit transaction
	if err := tx.Commit(); err != nil {
		log.Fatalf("Failed to commit transaction: %v", err)
	}

	// Check for scanner errors
	if err := scanner.Err(); err != nil {
		log.Fatalf("Error while scanning file: %v", err)
	}

	// Print stats
	elapsed := time.Since(startTime)
	log.Printf("Successfully inserted %d rows in %v with batch size of %d", totalRows, elapsed, *batchSize)
	if totalRows > 0 {
		log.Printf("Average insertion rate: %.2f rows/second", float64(totalRows)/elapsed.Seconds())
	}
}

// insertBatch inserts a batch of rows into the database
func insertBatch(tx *sql.Tx, rows []string, tableName, delimiter string) error {
	if len(rows) == 0 {
		return nil
	}

	// Get column count from first row to build placeholders
	firstRow := strings.Split(rows[0], delimiter)
	columnCount := len(firstRow)

	// Create placeholders for prepared statement
	placeholders := make([]string, len(rows))
	valueArgs := make([]interface{}, 0, len(rows)*columnCount)

	// For each row, create placeholders and add values to args
	for i, row := range rows {
		values := strings.Split(row, delimiter)

		// Build placeholders for this row
		rowPlaceholders := make([]string, columnCount)
		for j := 0; j < columnCount; j++ {
			paramIndex := i*columnCount + j + 1
			rowPlaceholders[j] = fmt.Sprintf("$%d", paramIndex)

			// Add value to args
			if j < len(values) {
				valueArgs = append(valueArgs, strings.TrimSpace(values[j]))
			} else {
				valueArgs = append(valueArgs, nil) // Missing values become NULL
			}
		}

		placeholders[i] = fmt.Sprintf("(%s)", strings.Join(rowPlaceholders, ", "))
	}

	// Build complete SQL query
	query := fmt.Sprintf("INSERT INTO %s VALUES %s",
		tableName, strings.Join(placeholders, ", "))

	// Execute query
	_, err := tx.Exec(query, valueArgs...)
	return err
}
