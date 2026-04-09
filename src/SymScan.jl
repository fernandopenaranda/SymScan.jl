module SymScan
    using Brillouin, Crystalline
    using LinearAlgebra
    using StringDistances
# Write your package code here.
    include("MPG_conv_dicts.jl")
    include("sym_check.jl")
    export schonflies_to_hm, preliminary_symmetry_check
end
