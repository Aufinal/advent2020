⊗, ⊕ = +, *
open("input-18") do file
    lines = readlines(file)
    println(sum(map(eval ∘ Meta.parse, replace.(lines, "*" => "⊕"))))
    println(sum(map(eval ∘ Meta.parse, replace.(lines, "*" => "⊕", "+" => "⊗"))))
end