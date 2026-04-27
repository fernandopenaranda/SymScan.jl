const schonflies_to_hm = Dict(
    "C1"  => "P1",
    "Ci"  => "P-1",
    "C2"  => "P2",
    "Cs"  => "Pm",
    "C2h" => "P2/m",
    "D2"  => "P222",
    "C2v" => "Pmm2",
    "D2h" => "Pmmm",
    "C4"  => "P4",
    "S4"  => "P-4",
    "C4h" => "P4/m",
    "D4"  => "P422",
    "C4v" => "P4mm",
    "D2d" => "P-42m",
    "D4h" => "P4/mmm",
    "C3"  => "P3",
    "C3i" => "P-3",
    "D3"  => "P32",
    "C3v" => "P3m",
    "D3d" => "P-3m",
    "C6"  => "P6",
    "C3h" => "P-6",
    "C6h" => "P6/m",
    "D6"  => "P622",
    "C6v" => "P6mm",
    "D3h" => "P-6m2",
    "D6h" => "P6/mmm",
    "T"   => "P23",
    "Th"  => "Pm-3",
    "O"   => "P432",
    "Td"  => "P-43m",
    "Oh"  => "Pm-3m"
)

const wallpaper_HM = [
    "P1",    # 1
    "P2",    # 2
    "Pm",    # 3
    "Pg",    # 4
    "Cm",    # 5
    "Pmm",   # 6
    "Pmg",   # 7
    "Pgg",   # 8
    "Cmm",   # 9
    "P4",    # 10
    "P4mm",  # 11
    "P4gm",  # 12
    "P3",    # 13
    "P3m1",  # 14
    "P31m",  # 15
    "P6",    # 16
    "P6mm"   # 17
]