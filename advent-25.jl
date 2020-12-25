open("input-25") do file
    card = parse(Int, readline(file))
    door = parse(Int, readline(file))
    loop_door = 0
    m = 20201227

    x = 1
    i = 0
    @time while loop_door == 0
        x = (7 * x) % m
        i += 1
        if x == door
            loop_door = i
        end
    end
    println(powermod(card, loop_door, m))
end