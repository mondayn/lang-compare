// cd dotnet9
// dotnet run

using System;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;

class Program
{
    static async Task Main()
    {
        string filePath = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv";

        /*if (!File.Exists(filePath))
        {
            Console.WriteLine("File not found.");
            return;
        }*/

        // Measure memory before execution
        //long memoryBefore = GC.GetTotalMemory(true);

        // Measure time taken
        Stopwatch stopwatch = Stopwatch.StartNew();

        //await foreach (string line in File.ReadLinesAsync(filePath)){
        //Console.WriteLine(line); // Process the line (remove this for faster execution)
        //}

        int line_count = 0;
        foreach (string line in File.ReadLines(filePath))
        {
            line_count += 1;
            //Console.WriteLine(line);
            string[] tokens = line.Split(',');
        }

        stopwatch.Stop();
        //long memoryAfter = GC.GetTotalMemory(true);

        Console.WriteLine($"\nLines: {line_count}");
        Console.WriteLine($"\nExecution Time: {stopwatch.ElapsedMilliseconds} ms");
        //Console.WriteLine($"Memory Used: {memoryAfter - memoryBefore} bytes");
    }
}
