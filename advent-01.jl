# Problem 1

open("input-01") do file
    numbers = [parse(Int, x) for x in readlines(file)]
    x, y = first([(x, y) for x in numbers for y in numbers if x < y && x + y == 2020])
    println("($x, $y) $(x * y)")
end

# Problem 2

open("input-01") do file
    numbers = [parse(Int, x) for x in readlines(file)]
    x, y, z = first([(x, y, z) for x in numbers for y in numbers for z in numbers if x < y < z && x + y + z == 2020])
    println("($x, $y, $z) $(x * y * z)")
end
