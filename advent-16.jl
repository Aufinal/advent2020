function test_bounds((a, b, c, d), field)
    return (a <= field <= b) || (c <= field <= d)
end

open("input-16") do file
    conditions = Array{Tuple{Int, Int, Int, Int}, 1}()
    departure = Array{Int, 1}()
    regex = r"(\d+)\-(\d+) or (\d+)\-(\d+)"
    n_fields = 0
    while (line = readline(file)) != ""
        n_fields += 1
        if startswith(line, "departure")
            push!(departure, n_fields)
        end
        matched = match(regex, line)
        push!(conditions, tuple(
            map(x -> parse(Int, x), matched.captures)...
        ))
    end
    readline(file)
    ticket = [parse(Int, x) for x in split(readline(file), ",")]

    readline(file)
    readline(file)

    sum_invalid = 0
    possible = ones(Int, n_fields, n_fields)
    for line in eachline(file)
        fields = [parse(Int, x) for x in split(line, ",")]
        invalid_fields = sum(field for field in fields if all(!test_bounds(b, field) for b in conditions))
        sum_invalid += invalid_fields
        if invalid_fields == 0
            for (i, field) in enumerate(fields)
                for (j, bounds) in enumerate(conditions)
                    if !test_bounds(bounds, field)
                        possible[i, j] = 0
                    end
                end
            end
        end
    end

    rowsums = possible * ones(Int, n_fields)
    colsums = possible' * ones(Int, n_fields)
    matching = zeros(Int, n_fields)
    for i in 1:n_fields
        matching[i] = findfirst(isequal(n_fields + 1 - colsums[i]), rowsums)
    end
    println(invalid_fields)
    println(join(ticket[matching[departure]], "*"))
    
end