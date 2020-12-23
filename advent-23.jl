const N = Int(1e6)

@inline function wrap(x)
    return 1 + mod(x - 1, N)
end

function insert!(next::Array{Int,1}, prev::Array{Int,1}, elt::Int, at::Int)
    next[elt] = next[at]
    next[at] = elt
    prev[elt] = at
    prev[next[elt]] = elt
end

function delete!(next::Array{Int,1}, prev::Array{Int,1}, elt::Int)
    next[prev[elt]] = next[elt]
    prev[next[elt]] = prev[elt]

    return elt
end

function rotate!(next::Array{Int,1}, prev::Array{Int,1}, current::Int)
    c1 = delete!(next, prev, next[current])
    c2 = delete!(next, prev, next[current])
    c3 = delete!(next, prev, next[current])

    target = wrap(current - 1)
    while target ∈ [c1, c2, c3]
        target = wrap(target - 1)
    end

    insert!(next, prev, c1, target)
    insert!(next, prev, c2, c1)
    insert!(next, prev, c3, c2)
end

next = Array{Int,1}(2:(N + 1))
prev = Array{Int,1}(0:N - 1)
cups = parse.(Int, collect("247819356"))

for i in 1:9
    next[cups[i]] = (i < 9) ? cups[i + 1] : 10
    prev[cups[i]] = (i > 1) ? cups[i - 1] : N
end
next[end] = cups[1]
prev[10] = cups[9]

current = cups[1]
n_steps = Int(1e7)

@time for _ in 1:n_steps
    rotate!(next, prev, current)
    global current = next[current]
end

# println(get_cups(next))

println(next[1] * next[next[1]])