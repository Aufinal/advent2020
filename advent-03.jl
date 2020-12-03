function parse_file(filename)
    open(filename) do file
        return hcat(map(line -> map(char -> char == '#', collect(line)), eachline(file))...)
    end
end

function toboggan(sapins, (dx, dy))
    return sum(sapins[1 + (k * dx) % size(sapins, 1), 1 + (k * dy)] for k in 1:((size(sapins, 2) - 1) ÷ dy))
end

sapins = parse_file("input-03")

# Problem 1

println("Sapins rencontrés : $(toboggan(sapins, (3, 1)))")

# Problem 2

p = prod(toboggan(sapins, slope) for slope in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])

println("Produit trouvé : $p")