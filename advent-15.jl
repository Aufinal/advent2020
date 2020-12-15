open("input-15") do file
    numbers = [parse(Int, num) for num in split(readline(file), ",")]
    last_spoken = Dict{Int,Int}()
    
    for (i, n) in enumerate(numbers)
        last_spoken[n] = i
    end

    spoken = 0
    for turn_number in 1 + length(numbers):30000000 - 1
        if turn_number == 2020
            println(spoken)
        end
        if haskey(last_spoken, spoken)
            l = last_spoken[spoken]
            last_spoken[spoken] = turn_number
            spoken = turn_number - l
        else
            last_spoken[spoken] = turn_number
            spoken = 0
        end
    end
    println(spoken)
end