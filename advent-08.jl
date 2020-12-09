function parse_instr(instr)
    r = r"(jmp|acc|nop) ((?:-|\+)\d+)"
    m = match(r, instr)
    return [m[1], parse(Int, m[2])]
end

function execute(program)
    executed = repeat([false], length(program))
    curr_index = 1
    acc = 0
    while curr_index <= length(program)
        if curr_index <= 0 || executed[curr_index]
            return false, acc
        end

        instr, arg = program[curr_index]
        executed[curr_index] = true
        if instr == "jmp"
            curr_index += arg
        elseif instr == "nop"
            curr_index += 1
        else
            acc += arg
            curr_index += 1
        end
    end
    return true, acc
end

function tweak(program)
    for i in 1:length(program)
        if program[i][1] ∈ ["jmp", "nop"]
            program[i][1] = program[i][1] == "jmp" ? "nop" : "jmp"
            success, acc = execute(program)
            program[i][1] = program[i][1] == "jmp" ? "nop" : "jmp"
            if success
                return acc
            end
        end
    end
end

open("input-08") do file
    program = map(parse_instr, eachline(file))
    _, acc = execute(program)
    println(acc)
    acc = tweak(program)
    println(acc)
end                         