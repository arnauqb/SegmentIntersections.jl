import Base: intersect!
export Segment, Segments, intersect!

struct Segment{T<:Float64}
    p::Point{T}
    q::Point{T}
end

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

"""
Checks for the intersection of two segments s1, s2.
A linear system needs to be solved, and we pass A and b
to avoid allocating memory at every single  calculation.
"""
function intersect!(s1::Segment, s2::Segment, A::Matrix{Float64}, b::Vector{Float64})
    if is_singular(s1) || is_singular(s2)
        return false
    end
    A[1, 1] = s1.q.x - s1.p.x
    A[1, 2] = s2.p.x - s2.q.x
    A[2, 1] = s1.q.y - s1.p.y
    A[2, 2] = s2.p.y - s2.q.y
    b[1] = s2.p.x - s1.p.x
    b[2] = s2.p.y - s1.p.y
    sol = A \ b
    if (0 < sol[1] < 1) && (0 < sol[2] < 1)
        intersection =
            Point(s1.p.x + sol[1] * (s1.q.x - s1.p.x), s1.p.y + sol[2] * (s1.q.y - s1.p.y))
        return true, intersection
    else
        return false, Point(0.0, 0.0)
    end
end
