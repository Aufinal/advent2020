function run_game(numbers::Array{UInt32,1}, n_steps::Int)
    last_spoken = Dict{UInt32,UInt32}()

    for (i, n) in enumerate(numbers)
        last_spoken[n] = i
    end

    spoken = 0
    for turn_number in 1 + length(numbers):n_steps - 1
        last_spoken[spoken], spoken = turn_number, turn_number - get(last_spoken, spoken, turn_number)
    end

    return spoken
end

open("input-15") do file
    numbers = [parse(UInt32, num) for num in split(readline(file), ",")]
    @time res1 = run_game(numbers, 2020)
    @time res2 = run_game(numbers, 30000000)

    println("$res1 $res2")
end