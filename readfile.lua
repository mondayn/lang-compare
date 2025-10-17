--[[
475ms: lua readfile.lua 

]]

--local filename = arg[1]
local filename = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"

-- Start timing
local start_time = os.clock()

-- Open the file
local file, err = io.open(filename, "r")
if not file then
    print("Error opening file: " .. err)
    os.exit(1)
end

-- Read file line by line
local line_count = 0
for line in file:lines() do
    line_count = line_count + 1
    -- Process each line here if needed
    -- print("Line " .. line_count .. ": " .. line)
end

-- Close the file
file:close()

-- End timing
local end_time = os.clock()
local duration = end_time - start_time

-- Print results
print(string.format("File: %s", filename))
print(string.format("Lines read: %d", line_count))
print(string.format("Duration: %.3f ms", duration * 1000))
print(string.format("Duration: %.6f seconds", duration))