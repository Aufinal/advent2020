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
    result = 1
    curr = 0
    run = 0
    n = length(int_list)
    comb::Array{Int} = zeros(n)
    comb[1] = 1
    comb[2] = 1
    comb[3] = 2
    for i in 4:n
        comb[i] = comb[i - 1] + comb[i - 2] + comb[i - 3]
    end
    for i in int_list
        if i == curr + 3
            result *= comb[run + 1]
            run = 0
        else
            run += 1
        end
        curr = i
    end
    result *= comb[run + 1] 
    return result
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

