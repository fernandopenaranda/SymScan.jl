"""
Typically when constructing Hamiltonians in complex point groups an bravais lattices one
makes several mistakes, here I provide a tool that helps in debugging. 
This realizes a preliminar consistency check of whether the Hamiltonian spectrum satisfies 
the symmetries of the intended magnetic point group. 
    `preliminary_symmetry_check(h::Function, Rs, magnetic_point_group_label::String; tol = 1e-10, num_points = 100)`
Input: 
    - `h`: k-dependent hermitian spinless Bloch Hamiltonian of arbitrary dimension
    - `Rs`: real-space Bravais lattice vectors
    - `magnetic_point_group_label`: magnetic point group in Schönflies or Hermann–Mauguin notation.
    see: 
        ISOTROPY's compilation of Daniel Litvin's magnetic space group equivalence tables
         (http://www.bk.psu.edu/faculty/litvin/Download.html).
Remarks: 
    - It is not an absolute test but a necessary condition.
    - Only applies for spinless point groups `G` not magnetic point groups. 
    - If your symmetry connects multiple degrees of freedom (DoFs), e.g.,
      layers, sublattices, or valleys, but your Hamiltonian `H` represents only 
      a subset of the full Hilbert space, then results of the preliminary symmetry 
      check on `H_sub` cannot be trusted for those symmetry operations.
Implementation details:
    if `h` the k-dependent Hamiltonian has a symmetry then its eigenvalues
        {E₁, E₂, ..., Eₙ}(k) = {E₁, E₂, ..., Eₙ}(Rk), 
    crucially it is compared whether the two lists with arbitrary ordering are
    the same where R denotes the action on k of each symmetry generator g in G.
    Then the condition is tested up to some tolerance. 
    The tests are runned over a symmetry line connecting all high-sym momenta.

It only acts on spinless space point groups or spinless magnetic point groups
Crystalline.MSG_BNS_LABELs_D is the dictionary for MGpoint groups. 
# note in k space translations do only add a phase and are not included
"""
function preliminary_symmetry_check(h::Function, Rs, magnetic_point_group_label::String;
         tol = 1e-10, num_points = 100)
    OGnumber, HMlabel = test_magnetic_point_group_syntax(magnetic_point_group_label)
    dim = length(Rs) # k line in the BZ connecting the high_sym momenta:
    ks_GSbasis = interpolate(irrfbz_path(parent_spacegroup(HMlabel, dim), Rs, dim), num_points) 
    Gs = Crystalline.Bravais.dualbasis(Rs)
    sg = mspacegroup(OGnumber)
    for sym_op in sg
        s = 0.0
        for k_GSbasis in ks_GSbasis
            k =  reduce(+, k_GSbasis .* Gs) # k in the Hamiltonian basis 
            eks = real.(eigen(h(k)).values)
            nk = reduce(+, (sym_op.op.rotation *  k_GSbasis) .* Gs) 
            enks = real.(eigen(h(nk)).values)
            s += sum(abs.(sort(eks)-sort(enks)))
        end
        if abs(s)<tol*num_points
            println(string(sym_op),":  ✔")
        else
            println(string(sym_op),":  ✖")
        end
    end
end

# List of valid symbols
"""
provides closest calls to wrong magnetic group inputs.
If the input is in Schonflies_to_hm notation it has to be exact match
Else it interprets the input as in HM notation and provides guesses if
    not a match.
"""
function test_magnetic_point_group_syntax(user_input)
    valid_symbols = Crystalline.MSG_OG_LABELS_V
    if user_input ∈ keys(schonflies_to_hm)
        HMlabel = schonflies_to_hm[user_input]
        MOG_number = findfirst(x -> x == HMlabel, valid_symbols)
        return MOG_number, HMlabel
    else
        if user_input ∉ valid_symbols
            distances = [evaluate(Levenshtein(), user_input, s) for s in valid_symbols]
            N = 5
            sorted_idx = sortperm(distances)
            top_suggestions = valid_symbols[sorted_idx[1:10]]
            throw(ArgumentError("Syntax for the Magnetic Point Group not recognized. 
            Did you mean one of: $(top_suggestions)"))
        else 
            MOG_number = findfirst(x-> x==user_input, valid_symbols)
            return MOG_number, user_input
        end
    end 
end

""" finds the parent space group (BSN1 number) of a given magnetic point group
passed in Hermann–Mauguin notation, input for the Brillouin.irrfbz_path"""
function parent_spacegroup(MSG, dim)
    if dim == 3
        for (k, v) in Crystalline.MSG_BNS_LABELs_D
            if v == MSG
                return k[1] #returns the OG number of the parent space group 
            end
        end
    elseif dim == 2
        if MSG ∈ wallpaper_HM
            return findfirst(x-> x == MSG,  wallpaper_HM)
        else 
            throw(ArgumentError("Inputs inconsistency: Dim = $(dim) but the parent point group $(M) does not exist in 2D"))
        end
    else
    return nothing end
end

#____________________________________________________________________________________________________
## Deprecated
# function preliminary_symmetry_check(h::Function, Rs, point_group_number; 
#         tol = 1e-10, kpoints = 100)
#     # k-line in the BZ connecting the high_sym momenta
#     ks_GSbasis = interpolate(irrfbz_path(sgnum, Rs), kpoints) 
#     Gs = dualbasis(Rs) 
#     sg = spacegroup(point_group_number)
#     for sym_op in sg
#         s = 0.0
#         for k_GSbasis in ks_GSbasis
#             k =  reduce(+, k_GSbasis .* Gs) # k in the Hamiltonian basis 
#             eks = real.(eigen(h(k)).values)
#             nk = sym_op.rotation * k 
#             # note in k space translations do only add a phase and are not included
#             enks = real.(eigen(h(nk)).values)
#             s += sum(sort(eks)-sort(enks))
#         end
#         if s<tol
#             println(string(sym_op),":  ✔")
#         else
#             println(string(sym_op),":  ✖")
#         end
#     end
# end


#sg = spacegroup(160, Val(2)) error


#= to do 
   # Rs_conv = directbasis(sg, Val(3)) 
    # P = inv(Rs_custom) * Rs_conv
    # P_inv = inv(P)
    # P_T = P'
    # Q = Rs * inv(Rs_conv)
    # println("", keys(high_sym_momenta_Gsbasis))

        # W_conv = sym_op.op.rotation
        # W_custom = P_inv * W_conv * P
        # W_new = P_inv * W * P
        # W_k = transpose(P) * W * P^{-T} # in the user units
        # k_new = kP_T * k_conv
        
=#