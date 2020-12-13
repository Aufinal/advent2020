function chinese_remainder(a::Array{Tuple{Int,Int}})
    p = prod([x[2] for x in a])

    return mod(sum(x * invmod(p ÷ n, n) * p ÷ n for (x, n) in a), p)
end

open("input-13") do file
    start = parse(Int, readline(file))
    buses = [tryparse(Int, x) for x in split(readline(file), ",")]
    real_buses = filter(x -> !isnothing(x), buses)

    min, i = findmin([bus - start % bus for bus in real_buses])
    println(min * real_buses[i])

    println(chinese_remainder([(-i + 1, n) for (i, n) in enumerate(buses) if !isnothing(n)]))
end