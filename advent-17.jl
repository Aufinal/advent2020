function run_once!(input::Array{Int8,N}, inter::Array{Int8,N}, offset::Int, bounds::NTuple{N,Int}) where N
    I1 = oneunit(CartesianIndex{N})
    for I in CartesianIndices(bounds)
        J = I + offset * I1
        for K in -I1:I1
            inter[J + K] += input[J]
        end
        inter[J] -= input[J]
    end

    for I in CartesianIndices(bounds .+ 2)
        J = I + (offset - 1) * I1
        if (input[J] == 0 && inter[J] == 3) || (input[J] == 1 && 2 <= inter[J] <= 3)
            input[J] = 1
        else
            input[J] = 0
        end
    end
end

function make_tuple(x, y, z, n::Int)
    return tuple(x, y, fill(z, n - 2)...)
end 

function run(initial::Array{Int8,2}, n_dims, n_steps)
    x, y = size(initial)
    dims = make_tuple(x + 2n_steps, y + 2n_steps, 1 + 2n_steps, n_dims)
    B = zeros(Int8, dims)
    n_neighbors = zeros(Int8, dims)
    B[make_tuple((n_steps + 1):(n_steps + x), (n_steps + 1):(n_steps + y), n_steps + 1, n_dims)...] = initial

    for i in 0:(n_steps - 1)
        fill!(n_neighbors, zero(Int8))
        run_once!(B, n_neighbors, n_steps - i, make_tuple(x + 2i, y + 2i, 1 + 2i, n_dims))
    end
    return sum(B)
end


open("input-17") do file
    initial::Array{Int8,2} = transpose(hcat([[c == '.' ? 0 : 1 for c in line] for line in eachline(file)]...))
    println(run(initial, 3, 6))
    @time println(run(initial, 4, 6))
end