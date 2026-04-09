# SymScan

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://fernandopenaranda.github.io/SymScan.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://fernandopenaranda.github.io/SymScan.jl/dev/)
[![Build Status](https://github.com/fernandopenaranda/SymScan.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/fernandopenaranda/SymScan.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/fernandopenaranda/SymScan.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/fernandopenaranda/SymScan.jl)

This package offers a general tool `preliminary_symmetry_check` to check if the spectrum of a provided spinless k-dependent hermitian Hamiltonian matrix `H(k)` with `H::Function` and `k::AbstractArray` obeys the symmetry operations of a given magnetic point group `G` passed either in Schönflies or in Hermann–Mauguin notation.

**Remark:** It is important to emphasize that the output of this tool **does not constitute a full proof** that a given symmetry is satisfied as it also concerns the eigenvalues. The results should be interpreted as necessary checks for compliance with a given symmetry \[ g \in G\], but not sufficient, i.e., `preliminary_symmetry_check` tests whether

$$H(\mathbf{k}) = H(R\mathbf{k})\ \ \ [1]$$

The general symmetry condition is instead:

$$
U H(\mathbf{k}) U^{-1} = H(R \mathbf{k}), \qquad U^2 = \pm \mathbb{1} \ \ \ [2]
$$

- $H(\mathbf{k})$ is the Bloch (or k-space tight-binding) Hamiltonian,  
- $U$ is the symmetry operator (unitary or antiunitary),  
- $R$ is the momentum-space action of the symmetry,  
- $U^2 = \pm \mathbb{1}$ encodes whether the symmetry squares to \(+1\) or \(-1\).

Validating [2] requires knowledge of the system-dependent basis, and must be implemented in a second step.


It uses functionalities built in [Crystalline.jl](https://github.com/thchr/Crystalline.jl) and follows the conventions and tables of the [Bilbao crystallographic database](https://www.cryst.ehu.es/).

See the .ipynb tutorial.
