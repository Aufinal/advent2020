function parse_bin(str)
    str = map(c -> c == 'B' || c == 'R' ? '1' : '0', str)
    return parse(Int, str, base=2)
end

open("input-05") do file
    ids = sort(map(parse_bin, eachline(file)))
    # Problem 1
    println("Maximum ID : $(ids[end])")
    # Problem 2
    println("My board pass : $(ids[findfirst(i -> ids[i + 1] - ids[i] == 2, 1:length(ids))])")
end