function parse(line)
    x = 0
    y = 0

    re = r"e|se|sw|w|nw|ne"

    for m in eachmatch(re, line)
        txt = m.match

        if txt == "e"
            x += 1
            y -= 1
        elseif txt == "se"
            y -= 1
        elseif txt == "sw"
            x -= 1
        elseif txt == "w"
            x -= 1
            y += 1
        elseif txt == "nw"
            y += 1
        elseif txt == "ne"
            x += 1
        end
    end

    return (x, y)
end

function neighbours((x, y))
    return [
        (x + 1, y - 1),
        (x - 1, y + 1),
        (x + 1, y),
        (x - 1, y),
        (x, y + 1),
        (x, y - 1),
    ]
end

tiles = Set{NTuple{2,Int}}()

open("input-24") do file
    for line in eachline(file)
        tile = parse(line)
        if tile ∈ tiles
            delete!(tiles, tile)
        else
            push!(tiles, tile)
        end
    end
    println(length(tiles))
end

n_steps = 100

@time for _ in 1:n_steps
    n_neighbours = Dict{NTuple{2,Int},Int}()
    for tile in tiles
        n_neighbours[tile] = get(n_neighbours, tile, 0)
        for neighbour in neighbours(tile)
            n_neighbours[neighbour] = get(n_neighbours, neighbour, 0) + 1
        end
    end


    for (tile, m) in n_neighbours
        if tile ∈ tiles && (m == 0 || m > 2)
            delete!(tiles, tile)
        elseif tile ∉ tiles && (m == 2)
            push!(tiles, tile)
        end
    end

end
println(length(tiles))
