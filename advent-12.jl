function manhattan(c::Complex)
    return abs(real(c)) + abs(imag(c))
end

open("example-12") do file
    pos1 = complex(0)
    dir1 = complex(1, 0)

    pos2 = complex(0, 0)
    dir2 = complex(10, 1)

    for line in eachline(file)
        m = match(r"^([A-Z])(\d+)$", line)
        instr, num = m.captures
        num = parse(Int, num)
        if instr == "N"
            pos1 += num * 1im
            dir2 += num * 1im
        elseif instr == "S"
            pos1 -= num * 1im
            dir2 -= num * 1im
        elseif instr == "E"
            pos1 += num
            dir2 += num
        elseif instr == "W"
            pos1 -= num
            dir2 -= num
        elseif instr == "L"
            dir1 *= 1im^(num ÷ 90)
            dir2 *= 1im^(num ÷ 90)
        elseif instr == "R"
            dir1 *= (-1im)^(num ÷ 90)
            dir2 *= (-1im)^(num ÷ 90)
        elseif instr == "F"
            pos1 += num * dir1
            pos2 += num * dir2
        end
    end
    println(manhattan(pos1))
    println(manhattan(pos2))
end