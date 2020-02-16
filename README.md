# Sub2Index.jl
Provides a macro that converts subscripts (`Fₙ`) to indexing (`F[n]`).

## Installation

On Pkg REPL-mode:

```julia-repl
(v1.x) pkg> add https://github.com/antimon2/Sub2Index.jl.git
```

## Example

```julia-repl
julia> F = ones(Int, 10);
julia> @_ for n = 3:10 Fₙ = Fₙ₋₁ + Fₙ₋₂ end;
       # equivalent to `for n = 3:10 F[n] = F[n-1] + F[n-2] end`
julia> F
10-element Array{Int64,1}:
  1
  1
  2
  3
  5
  8
 13
 21
 34
 55

```

```julia-repl
 
julia> Π = zeros(Int, (10, 10));
julia> @_ for i = 1:10 Π₍ᵢ₎₍₁₎ = Π₍ᵢ₎₍ᵢ₎ = 1 end;
julia> @_ for i = 3:10, j = 2:i-1 Π₍ᵢ₎₍ⱼ₎ = Π₍ᵢ₋₁₎₍ⱼ₋₁₎ + Π₍ᵢ₋₁₎₍ⱼ₎ end;
julia> Π
10×10 Array{Int64,2}:
 1  0   0   0    0    0   0   0  0  0
 1  1   0   0    0    0   0   0  0  0
 1  2   1   0    0    0   0   0  0  0
 1  3   3   1    0    0   0   0  0  0
 1  4   6   4    1    0   0   0  0  0
 1  5  10  10    5    1   0   0  0  0
 1  6  15  20   15    6   1   0  0  0
 1  7  21  35   35   21   7   1  0  0
 1  8  28  56   70   56  28   8  1  0
 1  9  36  84  126  126  84  36  9  1

```

## Reference

(Inspired by)

+ https://stackoverflow.com/questions/49705173/use-subscript-as-index-in-julia
+ https://twitter.com/opensourcesblog/status/1226791023008985088
