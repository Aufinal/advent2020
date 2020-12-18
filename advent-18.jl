⊗, ⊕ = +, *
open("input-18") do file
    lines = replace.(readlines(file), "*" => "⊕")
    @time println(sum(map(eval ∘ Meta.parse, lines)))
    @time println(sum(map(eval ∘ Meta.parse, replace.(lines, "+" => "⊗"))))
end