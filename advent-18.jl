⊗, ⊕ = +, *
open("input-18") do file
    lines = replace.(readlines(file), "*" => "⊕")
    println(sum(map(eval ∘ Meta.parse, lines)))
    println(sum(map(eval ∘ Meta.parse, replace.(lines, "+" => "⊗"))))
end