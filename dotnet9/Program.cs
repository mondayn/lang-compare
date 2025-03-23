// cd dotnet9
// dotnet build -c Release
// ./bin/Release/net9.0/dotnet9

using System;
using System.Diagnostics;
using System.IO;
//using System.Threading.Tasks;

//long memoryBefore = GC.GetTotalMemory(true);
//long memoryAfter = GC.GetTotalMemory(true);
//Console.WriteLine($"Memory Used: {memoryAfter - memoryBefore} bytes");


class Program
{
    static async Task Main()
    {
        string filePath = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv";

        Stopwatch stopwatch = Stopwatch.StartNew();

        int line_count = 0;
        foreach (string line in File.ReadLines(filePath))
        {
            line_count += 1;
            string[] tokens = line.Split(',');
        }

        /*int line_count = File.ReadLines(filePath)
            .AsParallel()
            .Select(line => line.Split(','))
            .Count();
        */
        /*using var reader = new StreamReader(filePath);
        char[] separator = new char[] { ',' };
        while (await reader.ReadLineAsync() is string line)
        {
            line_count++;
            //_ = line.AsSpan().Split(separator);  // Avoids unnecessary allocations
        }*/

        stopwatch.Stop();

        Console.WriteLine($"\nLines: {line_count}");
        Console.WriteLine($"\nExecution Time: {stopwatch.ElapsedMilliseconds} ms");
    }
}
