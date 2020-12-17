function run_once(
    A::Array{Int8, 3},
    (x_begin, y_begin, z_begin)::Tuple{Int8, Int8, Int8},
    (x_end, y_end, z_end)::Tuple{Int8, Int8, Int8}
    
    )
    kernel = ones(Int8, 3, 3, 3)
    kernel[2, 2, 2] = zero(Int8)
    for x in x_begin:x_end
        for y in y_begin:y_end
            for z in z_begin:z_end
                @nloops 3 i kernel begin
                    A[x + i_1] += (@nref 2 occupied d -> (x_d + i_d - 1)) * (@nref 2 kernel i)
                end
            end
        end
    end
        


end

function run_n(initial::Array{Int8, 2}, n_steps)
    x, y = size(initial)
    nx, ny, nz = x + 2n_steps, y + 2n_steps, 1 + 2n_steps
    B = zeros(Int8, nx, ny ,nz)
    B[n_steps+1:n_steps+x, n_steps+1:n_steps+y, n_steps + 1] = initial

    display(B)
end


open("example-17") do file
    initial::Array{Int8, 2} = hcat([[c == '.' ? 0 : 1 for c in line] for line in eachline(file)]...)
    run_n(initial, 1)
end