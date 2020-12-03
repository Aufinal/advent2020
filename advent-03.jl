function parse_line(line)
    return [char == '#' ? 1 : 0 for char in line]
end

function parse_file(filename)
    open(filename) do file
        return hcat([parse_line(line) for line in readlines(file)]...)
    end
end

function toboggan(sapins, (dx, dy))
    (m, n) = size(sapins)
    return sum(sapins[1 + (k * dx) % m, 1 + (k * dy)] for k in 1:((n - 1) ÷ dy))
end

sapins = parse_file("input-03")

# Problem 1

println("Sapins rencontrés : $(toboggan(sapins, (3, 1)))")

# Problem 2

p = prod(toboggan(sapins, slope) for slope in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])

println("Produit trouvé : $p")