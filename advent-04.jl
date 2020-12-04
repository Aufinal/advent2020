function parse_file(filename)
    passports = []
    open(filename) do file
        passport_str = ""
        for line in eachline(file)
            if line == ""
                push!(passports, Dict(map(s -> split(s, ":"), split(strip(passport_str), " "))))
                passport_str = ""
            else
                passport_str *= " " * line
            end
        end
        push!(passports, Dict(map(s -> split(s, ":"), split(strip(passport_str), " "))))
    end
    return passports
end

# Problem 1

passports = parse_file("input-04")
println("Valid passports : $(count(p -> all(haskey(p, key) for key in ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]), passports))")

# Problem 2

function is_valid(passport)
    regex_checks = Dict(
        "byr" => r"^(19[2-9][0-9]|200[0-2])$",
        "iyr" => r"^(201[0-9]|2020)$",
        "eyr" => r"^(202[0-9]|2030)$",
        "hgt" => r"^((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)$",
        "hcl" => r"^#[0-9a-f]{6}$",
        "ecl" => r"^(amb|blu|brn|gry|grn|hzl|oth)$",
        "pid" => r"^[0-9]{9}$",
    )

    return all(haskey(passport, key) && occursin(regex_checks[key], passport[key]) for key in keys(regex_checks))
end

println("Valid passports : $(count(is_valid, passports))")