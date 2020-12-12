using Base.Cartesian

function parse_file(file)
    seats = hcat([[c == '.' ? 0 : 1 for c in line] for line in eachline(file)]...)
    return seats
end

function get_neighbours!(seats::Array{Int,2}, neighbours)
    m, n = size(seats)
    directions = [(i, j) for i in -1:1 for j in -1:1 if i != 0 || j != 0]
    @nloops 2 x seats begin
        nlist = Vector{Tuple{Int,Int}}()
        for (u, v) in directions
            for k in 1:max(m, n)
                if !((1 <= x_1 + k * u <= m) && (1 <= x_2 + k * v <= n))
                    continue
                elseif seats[x_1 + k * u, x_2 + k * v] == 1
                    push!(nlist, (x_1 + k * u, x_2 + k * v))
                    break
                end
            end
        end
        neighbours[(x_1, x_2)] = copy(nlist)
    end
    return neighbours
end

function problem2(seats::Array{Int,2})
    m, n = size(seats)
    neighbours = Dict{Tuple{Int,Int},Array{Tuple{Int,Int}}}()
    get_neighbours!(seats, neighbours)
    occupied = zeros(Int, (m, n))
    n_neighbours = zeros(Int, (m, n))
    haschanged = true
    while haschanged
        haschanged = false
        @nloops 2 x n_neighbours begin
            n_neighbours[x_1, x_2] = sum([occupied[i, j] for (i, j) in neighbours[(x_1, x_2)]])
        end
        @nloops 2 x n_neighbours begin
            old = occupied[x_1, x_2]
            occupied[x_1, x_2] = seats[x_1, x_2] & ((occupied[x_1, x_2] | (n_neighbours[x_1, x_2] == 0)) & (n_neighbours[x_1, x_2] < 5))
            haschanged |= old != occupied[x_1, x_2]
        end
    end
    return sum(occupied)
end

function problem1(seats::Array{Int,2})
    m, n = size(seats)
    occupied = zeros(Int, (m + 2, n + 2))
    n_neighbours = zeros(Int, (m, n))
    kernel = ones(Int, (3, 3))
    kernel[2, 2] = 0
    haschanged = true
    while haschanged
        haschanged = false
        fill!(n_neighbours, zero(Int))
        @nloops 2 x n_neighbours begin
            @nloops 2 i kernel begin
                (@nref 2 n_neighbours x) += (@nref 2 occupied d -> (x_d + i_d - 1)) * (@nref 2 kernel i)
            end
        end
        @nloops 2 x n_neighbours begin
            old = occupied[x_1 + 1, x_2 + 1]
            occupied[x_1 + 1, x_2 + 1] = seats[x_1, x_2] & ((occupied[x_1 + 1, x_2 + 1] | (n_neighbours[x_1, x_2] == 0)) & (n_neighbours[x_1, x_2] < 4))
            haschanged |= old != occupied[x_1 + 1, x_2 + 1]
        end
    end
    return sum(occupied)
end

open("input-11") do file
    seats = parse_file(file)
    result = problem1(seats)
    println(result)
    result2 = problem2(seats)
    println(result2)
end