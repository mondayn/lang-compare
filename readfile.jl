
file_path = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"  

result = @timed begin
    open(file_path, "r") do file
        for line in eachline(file)
            # Process each line (optional)
        end
    end
end

println(result)
println("Time taken: ", result.time, " seconds")
println("Memory used: ", result.bytes / (1024^2), " MB")