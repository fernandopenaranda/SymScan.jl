using SymScan
using Documenter

DocMeta.setdocmeta!(SymScan, :DocTestSetup, :(using SymScan); recursive=true)

makedocs(;
    modules=[SymScan],
    authors="Fernando Peñaranda",
    sitename="SymScan.jl",
    format=Documenter.HTML(;
        canonical="https://fernandopenaranda.github.io/SymScan.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/fernandopenaranda/SymScan.jl",
    devbranch="main",
)
