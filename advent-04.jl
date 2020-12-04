# Problem 1

open("input-04") do file
    println("Valid passports : $(count(p -> all(occursin(key, p) for key in ["byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"]), split(read(file, String), "\n\n")))")
end

# Problem 2

function count_valid(filename)
    regexes = [
        r"byr:(19[2-9][0-9]|200[0-2])(\s|$)",
        r"iyr:(201[0-9]|2020)(\s|$)",
        r"eyr:(202[0-9]|2030)(\s|$)",
        r"hgt:((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)(\s|$)",
        r"hcl:#[0-9a-f]{6}(\s|$)",
        r"ecl:(amb|blu|brn|gry|grn|hzl|oth)(\s|$)",
        r"pid:[0-9]{9}(\s|$)",
    ]

    open(filename) do file
        return count(s -> all(occursin(regex, s) for regex in regexes), split(read(file, String), "\n\n"))
    end
end

println("Valid passports : $(count_valid("input-04"))")
