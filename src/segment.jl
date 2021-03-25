using LinearAlgebra
export Segment,
    Segments,
    intersect!,
    is_lower_end,
    is_upper_end,
    contains,
    find_leftmost,
    find_rightmost,
    contains,
    is_singular,
    min_x,
    min_y,
    max_x,
    max_y,
    trivial_miss


struct Segment{T<:Float64}
    p::Point{T}
    q::Point{T}
    slope::T
    function Segment(p::Point{T}, q::Point{T}) where {T<:Float64}
        if p > q
            p, q = q, p
        end
        slope = (q.x - p.x) / (q.y - p.y)
        return new{T}(p, q, slope)
    end
end

Base.isless(s::Segment, t::Segment) = (s.p.y > t.q.y) | ((s.p.y == t.p.y) && (s.p.x < t.p.x))
Base.:(==)(s::Segment, t::Segment) = (s.p == t.p) && (s.q == t.q)

get_x(segment::Segment, y) = segment.p.x + segment.slope * (y - segment.p.y)
get_y(segment::Segment, x) = segment.p.y + (x - segment.p.x) / segment.slope

min_x(segment::Segment) = min(segment.p.x, segment.q.x)
min_y(segment::Segment) = min(segment.p.y, segment.q.y)
max_x(segment::Segment) = max(segment.p.x, segment.q.x)
max_y(segment::Segment) = max(segment.p.y, segment.q.y)

Segment(px, py, qx, qy) = Segment(Point(px, py), Point(qx, qy))

"""
Checks if the segment s is purely horizontal or vertical.
"""
function is_singular(s::Segment)
    if (s.p.x == s.q.x) || (s.p.y == s.q.y)
        return true
    else
        return false
    end
end

function trivial_miss(s1::Segment, s2::Segment)
    if s1.slope ≈ s2.slope rtol=1e-10
        return true
    elseif max_x(s1) < min_x(s2)
        return true 
    elseif max_x(s2) < min_x(s1)
        return true
    elseif max_y(s1) < min_y(s2)
        return true
    elseif max_y(s2) < min_y(s2)
        return true
    end
    return false
end

"""
Checks for the intersection of two segments s1, s2.
"""
function Base.intersect!(
    s1::Segment{T},
    s2::Segment{T},
    A::Matrix{T},
    b::Vector{T},
    tol=1e-9
) where {T<:AbstractFloat}
    #if is_singular(s1) || is_singular(s2)
    #    return false, Point(0.0, 0.0)
    #end
    if trivial_miss(s1, s2)
        return false, Point(0.0, 0.0)
    end
    A[1, 1] = s1.q.x - s1.p.x
    A[1, 2] = s2.p.x - s2.q.x
    A[2, 1] = s1.q.y - s1.p.y
    A[2, 2] = s2.p.y - s2.q.y
    b[1] = s2.p.x - s1.p.x
    b[2] = s2.p.y - s1.p.y
    sol = 0.0
    try
        sol = A \ b
    catch
        @warn "Singular matrix. Check for edge cases!"
        return false, Point(0.0, 0.0)
    end
    if (-tol < sol[1] < 1+tol) && (-tol < sol[2] < 1+tol)
        intersection =
            Point(s1.p.x + sol[1] * (s1.q.x - s1.p.x), s1.p.y + sol[1] * (s1.q.y - s1.p.y))
        return true, intersection
    else
        return false, Point(0.0, 0.0)
    end
end

function Base.intersect!(s1::Segment{T}, s2::Segment{T}) where {T<:AbstractFloat}
    A = zeros((2, 2))
    b = zeros(2)
    return intersect!(s1, s2, A, b)
end

is_lower_end(segment::Segment, Point::Point) = (segment.q == Point)
is_upper_end(segment::Segment, Point::Point) = (segment.p == Point)
function Base.contains(segment::Segment, point::Point, tol=1e-9)
    if is_lower_end(segment, point) | is_upper_end(segment, point)
        return false
    end
    y = get_y(segment, point.x)
    if y ≈ point.y
        atol = tol
        return true
    else
        return false
    end
end

function find_leftmost(segment_set, y, tol=1e-9)
    ret = nothing
    xmin = Inf
    for segment in segment_set
        x = get_x(segment, y - tol)
        if x < xmin
            xmin = x
            ret = segment
        end
    end
    return ret, xmin
end

function find_rightmost(segment_set, y, tol=1e-9)
    ret = nothing
    xmax = 0
    for segment in segment_set
        x = get_x(segment, y - tol)
        if x > xmax
            xmax = x
            ret = segment
        end
    end
    return ret, xmax
end
