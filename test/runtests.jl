using Sub2Index
using Test

@testset "Simple Indexing" begin

A = reshape(1:100, (10, 10))

@test @_ A₁ == A[1] == 1
@test @_ A₂₃ == A[23] == 23
@test @_ A₂₊₃ == A[2 + 3] == 5
@test @_ A₍₄₎₍₅₎ == A[4, 5] == 44

end

@testset "Fibonacci Sequence" begin

F = ones(Int, 10)

@_ for n = 3:10 Fₙ = Fₙ₋₁ + Fₙ₋₂ end

@test F == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

end

@testset "Pascal Triangle" begin

Π = zeros(Int, (10, 10))

@_ for i = 1:10 Π₍ᵢ₎₍₁₎ = Π₍ᵢ₎₍ᵢ₎ = 1 end
@_ for i = 3:10, j = 2:i-1
    Π₍ᵢ₎₍ⱼ₎ = Π₍ᵢ₋₁₎₍ⱼ₋₁₎ + Π₍ᵢ₋₁₎₍ⱼ₎
end

@test Π == [1  0   0   0    0    0   0   0  0  0
            1  1   0   0    0    0   0   0  0  0
            1  2   1   0    0    0   0   0  0  0
            1  3   3   1    0    0   0   0  0  0
            1  4   6   4    1    0   0   0  0  0
            1  5  10  10    5    1   0   0  0  0
            1  6  15  20   15    6   1   0  0  0
            1  7  21  35   35   21   7   1  0  0
            1  8  28  56   70   56  28   8  1  0
            1  9  36  84  126  126  84  36  9  1]

end

@testset "fallbacks" begin

@test @_(123) == 123
@test @_("Fₙ = Fₙ₋₁ + Fₙ₋₂") == "Fₙ = Fₙ₋₁ + Fₙ₋₂"
@test @_(:Fₙ) == :Fₙ

end
