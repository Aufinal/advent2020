open("input-06") do file
    groups = map(group -> map(s -> Set(split(s, "")), split(group, "\n")), split(read(file, String), "\n\n"))
    println(sum(map(group -> length(union(group...)), groups)))
    println(sum(map(group -> length(intersect(group...)), groups)))
end