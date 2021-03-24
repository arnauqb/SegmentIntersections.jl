export Point, Segment, Event

struct Point{T<:Float64}
    x::T
    y::T
end

function Point(x::Int, y::Int)
    return Point(convert(Float64, x), convert(Float64, y))
end

Base.:(==)(p::Point, q::Point) = (p.x == q.x) & (p.y == q.y)
Base.isless(p::Point, q::Point) = (p.y > q.y) | ((p.y == q.y) & (p.x < q.x))


struct Segment{T<:Float64}
    px::T
    py::T
    qx::T
    qy::T
end

Segment(px::T, py::T, qx::T, qy::T) where {T<:Int} = Segment(
    convert(Float64, px),
    convert(Float64, py),
    convert(Float64, qx),
    convert(Float64, qy),
)

struct Event{T}
    node::Point{T}
    segment::Segment{T}
end

function Event(px::T, py::T, qx::T, qy::T) where {T<:Float64}
    p = Point(px, py)
    q = Point(qx, qy)
    segment = Segment(px, py, qx, qy)
    if p < q
        return Event(p, segment)
    else
        return Event(q, segment)
    end
end

Event(px::T, py::T, qx::T, qy::T) where {T<:Int} = Event(
    convert(Float64, px),
    convert(Float64, py),
    convert(Float64, qx),
    convert(Float64, qy),
)

Base.:(==)(e1::Event, e2::Event) = e1.node == e2.node
Base.isless(e1::Event, e2::Event) = e1.node < e2.node
