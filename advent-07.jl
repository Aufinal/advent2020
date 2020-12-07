using Memoize

struct Child
    num::Int
    color::String
end

function parse_file(filename)
    tree = Dict{String,Array{Child}}()
    open(filename) do file
        for line in eachline(file)
            if !occursin("no other", line)
                regex = r" ?(\d*+) ?(.+?) bags? ?\w*(?:,|.)?"
                m = collect(eachmatch(regex, line))
                tree[m[1][2]] = map(x -> Child(parse(Int, x.captures[1]), x.captures[2]), m[2:end])
            end
        end     
    end  
    return tree
end

@memoize function ancestor(color, tree, node)
    if node == color
        return true
    elseif node ∉ keys(tree)
        return false
    else
        return any(ancestor(color, tree, child.color) for child in tree[node])
    end
end

function contains(tree, node)
    if node ∉ keys(tree)
        return 0
    else
        return sum(child.num * (1 + contains(tree, child.color)) for child in tree[node])
    end
end

println("Parsing...")
@time tree = parse_file("input-07") 
println("Problem 1 :")
@time println(sum(ancestor("shiny gold", tree, node) for node in keys(tree)))
println("Problem 2 :")
@time println(contains(tree, "shiny gold"))