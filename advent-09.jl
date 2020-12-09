
function is_sum_previous(int_list::Array{Int}, size::Int)
    sums = zeros(Int, (size, size))
    for i in 1:size
        for j in 1:size
            sums[i, j] = int_list[i] + int_list[j]
        end
    end

    for cursor in (size + 1):length(int_list)
        if !(int_list[cursor] in sums)
            return int_list[cursor]
        end
        for i in 1:size
            sums[1 + (cursor - 1) % size, i] += int_list[cursor] - int_list[cursor - size]
            sums[i, 1 + (cursor - 1) % size] += int_list[cursor] - int_list[cursor - size]
        end
    end
end

function find_contig(target::Int, int_list::Array{Int})
    sum = 0
    min_index = 1
    max_index = 1
    while sum != target
        if sum < target
            sum += int_list[max_index]
            max_index += 1
        else
            sum -= int_list[min_index]
            min_index += 1
        end
    end
    return min_index, max_index
end

open("input-09") do file
    int_list = map(s -> parse(Int, s), eachline(file))
    @time target = is_sum_previous(int_list, 25)
    println(target)
    @time min, max = find_contig(target, int_list)
    numbers = int_list[min:max - 1]
    println("$(minimum(numbers) + maximum(numbers))")
end