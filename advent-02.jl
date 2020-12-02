function parse_line(line)
    regex = r"(\d+)-(\d+) (\w): (\w+)"
    m = match(regex, line)

    min = parse(Int, m[1])
    max = parse(Int, m[2])
    char = first(m[3])
    
    return m[4], char, min, max
end

function is_valid_count((password, char, min, max))
    return min <= count(i -> (i == char), password) <= max
end

function is_valid_xor((password, char, min, max))
    return (password[min] == char) ⊻ (password[max] == char)
end

function check_count(filename, check_fun)
    open(filename) do file
        return count(check_fun ∘ parse_line, readlines(file))
    end
end

# Problem 1

println("Valid passwords : $(check_count("input-02", is_valid_count))")

# Problem 2

println("Valid passwords : $(check_count("input-02", is_valid_xor))")
