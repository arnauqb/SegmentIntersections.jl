import Base: intersect!
export Segment, Segments, intersect!, is_lower_end, contains, find_leftmost, find_rightmost

struct Segment{T<:Float64}
    p::Point{T}
    q::Point{T}
    slope::T
    sweep_y::T
    function Segment(p::Point{T}, q::Point{T}) where {T<:Float64}
        if p > q
            p, q = q, p
        end
        slope = (q.x - p.x) / (q.y - p.y)
        return new{T}(p, q, slope)
    end
end


get_x(segment::Segment, y) = segment.p.x + segment.slope * (y - segment.p.y)
get_y(segment::Segment, x) = segment.p.y + (x - segment.p.x) / segment.slope

Base.isless(s::Segment, t::Segment) = get_x(s, s.sweep_y) < get_x(t, t.sweep_y)

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
"""
function intersect!(s1::Segment, s2::Segment)
    if is_singular(s1) || is_singular(s2)
        return false
    end
    A = zeros((2,2))
    b = zeros(2)
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

is_lower_end(segment::Segment, Point::Point) = segment.q == Point
function contains(segment::Segment, point::Point)
    y = get_y(segment, point.x)
    # Segments are guaranteed to be down going always
    if (y > segment.p.y) | (y < segment.q.y)
        return false
    else
        return true
    end
end

function find_leftmost(segment_set, y)
    ret = nothing
    xmin = Inf
    for segment in segment_set
        x = get_x(segment, y)
        if x < xmin 
            xmin = x
            ret = segment
        end
    end
    return ret
end

function find_rightmost(segment_set, y)
    ret = nothing
    xmax = 0
    for segment in segment_set
        x = get_x(segment, y)
        if x > xmax 
            xmax = x
            ret = segment
        end
    end
    return ret
end
