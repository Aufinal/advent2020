function recursive_combat(deck1, deck2)
    played = Set{String}()
    while true
        str = join(deck1, ",") * ";" * join(deck2, ",")
        if str in played
            return (1, deck1)
        else 
            push!(played, str)
        end
        if isempty(deck1)
            return (2, deck2)
        elseif isempty(deck2)
            return (1, deck1)
        end
        a, b = popfirst!(deck1), popfirst!(deck2)

        if length(deck1) >= a && length(deck2) >= b
            winner, _ = recursive_combat(deck1[begin:a], deck2[begin:b])
        else
            winner = a > b ? 1 : 2
        end
        if winner == 1
            push!(deck1, a, b)
        else
            push!(deck2, b, a)
        end
    end
end

function combat(deck1, deck2)
    while !isempty(deck1) && !isempty(deck2)
        a, b = popfirst!(deck1), popfirst!(deck2)

        if a > b
            push!(deck1, a, b)
        else
            push!(deck2, b, a)
        end
    end
    if isempty(deck1)
        return deck2
    else
        return deck1
    end
end

open("input-22") do file
    deck1, deck2 = split(read(file, String), "\n\n")
    deck1 = parse.(Int, split(deck1, "\n")[2:end])
    deck2 = parse.(Int, split(deck2, "\n")[2:end])
    n = length(deck1)

    @time deck = combat(copy(deck1), copy(deck2))
    println(sum((2n - i + 1) * val for (i, val) in enumerate(deck)))


    @time _, deck = recursive_combat(copy(deck1), copy(deck2))
    l = length(deck)
    println(sum((l - i + 1) * val for (i, val) in enumerate(deck)))
end