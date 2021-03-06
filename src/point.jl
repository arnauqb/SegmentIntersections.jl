export Point

struct Point{T<:Float64}
    x::T
    y::T
end

function Point(x::Int, y::Int)
    return Point(convert(Float64, x), convert(Float64, y))
end

Base.:(==)(p::Point, q::Point) = (p.x == q.x) & (p.y == q.y)
Base.isless(p::Point, q::Point) = (p.y > q.y) | ((p.y == q.y) & (p.x < q.x))
Base.isapprox(p::Point, q::Point; rtol = 1e-6) =
    isapprox(p.x, q.x, rtol = rtol) && isapprox(p.y, q.y, rtol = rtol)
