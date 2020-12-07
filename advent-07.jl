struct Child
    num::Int
    color::String
end

function parse_file(filename::String)::Dict{String,Array{Child}}
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

function sum_contains(tree::Dict{String,Array{Child}}, target::String)
    contains = Dict{String,Bool}()
    function aux!(node::String, contains::Dict{String,Bool}, target::String, tree::Dict{String,Array{Child}})::Bool
        if node == target
            return true
        elseif haskey(contains, node)
            return contains[node]
        elseif !haskey(tree, node)
            return false
        else
            result = any(aux!(child.color, contains, target, tree) for child in tree[node])
            contains[node] = result
            return result
        end
    end
    return sum(aux!(key, contains, target, tree) for key in keys(tree))
end

function contains(tree::Dict{String,Array{Child}}, node::String)::Int
    if !haskey(tree, node)
        return 0
    else
        return sum(child.num * (1 + contains(tree, child.color)) for child in tree[node])
    end
end

println("Parsing...")
@time tree = parse_file("input-07") 
println("Problem 1 :")
@time println(sum_contains(tree, "shiny gold"))
println("Problem 2 :")
@time println(contains(tree, "shiny gold"))