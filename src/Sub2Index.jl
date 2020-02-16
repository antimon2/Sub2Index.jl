module Sub2Index

export @_

const SUB2NDIC = Dict(zip("₍₎₊₋₀₁₂₃₄₅₆₇₈₉₌ₐᵦᵪₑᵧₕᵢⱼₖₗₘₙₒₚᵩᵣᵨₛₔₜᵤᵥₓ", "()+-0123456789=aβχeγhijklmnopφrρsətuvx"))

function sub2ind(src::AbstractString)
    idx = 1
    substrings = Any[]
    for m in eachmatch(r"[ᵢ-ᵪ₀-₎ₐ-ₜⱼ]+", src)
        offset = m.offset
        offset > idx && push!(substrings, src[idx:prevind(src, offset)])
        push!(substrings, '[')
        prechar = '\0'
        for c in m.match
            nextchar = SUB2NDIC[c]
            prechar == ')' && nextchar == '(' && push!(substrings, ',')
            push!(substrings, nextchar)
            prechar = nextchar
        end
        push!(substrings, ']')
        idx = offset + ncodeunits(m.match)
    end
    idx <= length(src) && push!(substrings, src[idx:end])
    join(substrings)
end

function sub2ind(src::Symbol)
    srcstr = string(src)
    convertedstr = sub2ind(srcstr)
    esc(Meta.parse(convertedstr))
end

function sub2ind(src::Expr)
    Expr(src.head, (sub2ind(arg) for arg in src.args)...)
end

sub2ind(src) = src

"""
    @_(expr)

Replace all subscript charcters to by normal characters and encloses them in square brackets (i.e. indexing expression).  
For example, `@_ Fₙ = Fₙ₋₁ + Fₙ₋₂` is converted to `F[n] = F[n-1] + F[n-2]`.

# Example

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

If each subscript is put in parentheses, it will be converted to the indexing of each dimension.  
For example, `@_ Π₍ᵢ₎₍ⱼ₎` is converted to `Π[i, j]`.

# Example

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
"""
macro _(ex)
    sub2ind(ex)
end

end # module
