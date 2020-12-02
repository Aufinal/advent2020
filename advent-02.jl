function parse_rule(rule)
    regex = r"(\d+)-(\d+) (\w): (\w+)"
    m = match(regex, rule)

    num1 = parse(Int, m[1])
    num2 = parse(Int, m[2])
    char = first(m[3])
    
    return num1, num2, char, m[4]
end

# Problem 1

open("input-02") do file
    n_valid = 0
    for line in readlines(file)
        min_num, max_num, char, str = parse_rule(line)
        c = count(i -> (i == char), str)
        if min_num <= c <= max_num
            n_valid += 1
        end
    end
    println("Valid passwords : $n_valid")
end

# Problem 2

open("input-02") do file
    n_valid = 0
    for line in readlines(file)
        a, b, char, str = parse_rule(line)
        if (str[a] == char) ⊻ (str[b] == char)
            n_valid += 1
        end
    end
    println("Valid passwords : $n_valid")
end

