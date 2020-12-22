open("input-21") do file
    candidates = Dict{String,Set{String}}()
    occs = Dict{String,Int}()
    matches = Dict{String,String}()

    for line in eachline(file)
        line = strip(line, ')')
        ingredients, allergens = split(line, " (contains ")
        ingredients = split(ingredients)
        allergens = split(allergens, ", ")

        for all in allergens
            if haskey(candidates, all)
                intersect!(candidates[all], ingredients)
            else
                candidates[all] = Set(ingredients)
            end
        end

        for ing in ingredients
            occs[ing] = get(occs, ing, 0) + 1
        end
    end

    println(sum(occs[key] for key in setdiff(keys(occs), union(values(candidates)...))))

    while !isempty(candidates)
        one_cand = filter(p -> length(last(p)) == 1, candidates)
        for (key, value) in one_cand
            matches[key] = first(value)
            delete!(candidates, key)
        end
        to_remove = union(values(one_cand)...)

        for (key, value) in candidates
            setdiff!(value, to_remove)
        end
    end

    println(join(map(x -> x[2], sort(collect(matches))), ","))
end