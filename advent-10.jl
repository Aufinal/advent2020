function diffs(int_list)
    diffs = [0, 0, 1]
    curr = 0
    for i in int_list
        diffs[i - curr] += 1
        curr = i
    end

    return diffs[1] * diffs[3]
end

function combinations(int_list)
    comb = Dict{Int,Int}()
    comb[0] = 1
    for i in int_list
        comb[i] = get(comb, i - 1, 0) + get(comb, i - 2, 0) + get(comb, i - 3, 0)
    end
    return comb[int_list[end]]
end

function parse_file(file)
    int_list = [parse(Int, x) for x in eachline(file)]
    return sort(int_list)
end

open("input-10") do file
    @time int_list = parse_file(file)
    @time result1 = diffs(int_list)
    println(result1)
    @time result2 = combinations(int_list)
    println(result2)
end

