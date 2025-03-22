# julia readfile.jl

file_path = "/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv"  
result = @timed begin
    open(file_path, "r") do file
        line_count = 0
        for line in eachline(file)
            line_count += 1
            # tokens = split(line, ",")
        end
        println("Lines are ",line_count)
    end
end

#println(result)
println("Time taken: ", result.time, " seconds")
# println("Memory used: ", result.bytes / (1024^2), " MB")