open("input-05") do file
    ids = Set(map(str -> parse(Int, map(c -> c == 'B' || c == 'R' ? '1' : '0', str), base=2), eachline(file)))
    # Problem 1
    println("Maximum ID : $(maximum(ids))")
    # Problem 2
    println("My board pass : $(first(filter(x -> !(x ∈ ids), minimum(ids):maximum(ids))))")
end