//zig run -O ReleaseFast readfile.zig

const std = @import("std");

pub fn main() !void {

    const start_time = std.time.milliTimestamp();

    const file_path = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"; 
    var file = try std.fs.cwd().openFile(file_path, .{});
    defer file.close();

    var line_count: usize = 0;
    var field_count: usize = 0;
    var line_buffer: [1024]u8 = undefined;

    var reader = std.io.bufferedReader(file.reader());
    var buf_reader = reader.reader();
    while (try buf_reader.readUntilDelimiterOrEof(&line_buffer, '\n')) |line| {
        line_count += 1;
        //_ = line;
        var tokens = std.mem.tokenizeScalar(u8, line, ',');
        while (tokens.next()) |_| {
            field_count += 1;
        }
    }
    const end_time = std.time.milliTimestamp();
    std.debug.print("Zig Execution time: {} ms\n", .{end_time - start_time});
    std.debug.print("Total lines: {}\n", .{line_count});
    std.debug.print("Tokens: {}\n", .{field_count});
}
