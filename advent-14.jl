function apply_mask1(mask::String, num::Int, mask_size::Int)
    bits = string(num, pad=mask_size, base=2)
    masked = String([mbit == 'X' ? nbit : mbit for (mbit, nbit) in zip(mask, bits)])
    return parse(Int, masked, base=2)
end

function apply_mask2(mask::String, num::Int, mask_size::Int, n_x::Int)
    bits = string(num, pad=mask_size, base=2)
    masked = String([mbit == '0' ? nbit : mbit for (mbit, nbit) in zip(mask, bits)])
    addresses = zeros(Int, 2^n_x)
    for i in 0:2^n_x - 1
        bits = string(i, pad=n_x, base=2)
        index = 0
        replaced = replace(masked, r"X" => s -> bits[index += 1])
        addresses[i + 1] = parse(Int, replaced, base=2)
    end

    return addresses
end

open("input-14") do file
    re_mask = r"mask = (.*)"
    re_assign = r"mem\[(\d+)\] = (\d+)"
    mask::String = ""
    nx = 0
    mask_size = 0
    mem1 = Dict{Int,Int}()
    mem2 = Dict{Int,Int}()

    for line in eachline(file)
        m = match(re_mask, line)
        if !isnothing(m)
            mask = m.captures[1]
            nx = count(c -> c == 'X', mask)
            mask_size = length(mask)
        else
            m = match(re_assign, line)
            address, num = m.captures
            num = parse(Int, num)
            address = parse(Int, address)
            mem1[address] = apply_mask1(mask, num, mask_size)
            for add in apply_mask2(mask, address, mask_size, nx)
                mem2[add] = num
            end
        end
    end
    println(sum(values(mem1)))
    println(sum(values(mem2)))
end
