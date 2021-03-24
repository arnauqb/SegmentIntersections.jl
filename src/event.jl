export Event, Events

struct Event{T}
    node::Point{T}
    segments::Vector{Segment{T}}
end

function Event(px::T, py::T, qx::T, qy::T) where {T<:Float64}
    p = Point(px, py)
    q = Point(qx, qy)
    segment = Segment(px, py, qx, qy)
    if p < q
        return Event(p, [segment])
    else
        return Event(q, [segment])
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

