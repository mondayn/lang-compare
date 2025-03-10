// to compile gcc readfile.c -o readfile
// to run: ./readfile

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Function to get memory usage from /proc/self/status
size_t get_memory_usage()
{
    FILE *file = fopen("/proc/self/status", "r");
    if (!file)
        return 0;

    char line[256];
    size_t memory = 0;

    while (fgets(line, sizeof(line), file))
    {
        if (strncmp(line, "VmRSS:", 6) == 0)
        {                                        // Find memory usage line
            sscanf(line, "VmRSS: %zu", &memory); // Extract value
            break;
        }
    }
    fclose(file);
    return memory; // Memory in KB
}

int main()
{
    const char *filename = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv";

    FILE *file = fopen(filename, "r");
    if (!file)
    {
        perror("Error opening file");
        return 1;
    }

    char *line = NULL;
    size_t len = 0;
    ssize_t read;

    // Measure start time
    clock_t start_time = clock();
    size_t mem_before = get_memory_usage(); // Get memory before

    // Read file line by line
    while ((read = getline(&line, &len, file)) != -1)
    {
        // Process line (optional)
    }

    // Measure end time
    clock_t end_time = clock();
    size_t mem_after = get_memory_usage(); // Get memory after

    // Cleanup
    free(line);
    fclose(file);

    // Calculate time taken in milliseconds
    double duration_ms = ((double)(end_time - start_time) / CLOCKS_PER_SEC) * 1000;

    // Print results
    printf("Time taken: %.2f ms\n", duration_ms);
    printf("Memory used: %zu KB\n", (mem_after > mem_before) ? (mem_after - mem_before) : 0);

    return 0;
}
