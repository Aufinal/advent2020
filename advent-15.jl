function run_game(numbers::Array{UInt32,1}, n_steps::Int)
    last_spoken = zeros(UInt32, n_steps)

    for (i, n) in enumerate(numbers)
        last_spoken[n + 1] = i
    end

    spoken = 0
    for turn_number in 1 + length(numbers):n_steps - 1
        last_spoken[spoken + 1], spoken = turn_number, turn_number - (last_spoken[spoken + 1] == 0 ? turn_number : last_spoken[spoken + 1])
    end

    return spoken
end

open("input-15") do file
    numbers = [parse(UInt32, num) for num in split(readline(file), ",")]
    @time res1 = run_game(numbers, 2020)
    @time res2 = run_game(numbers, 30000000)

    println("$res1 $res2")
end