export Event, Events, handle_event_point

struct Event{T}
    point::Point{T}
    segments::Set{Segment{T}}
end

Event(point::Point{T}) where {T<:Number} = Event(point, Set{Segment{T}}())

Event(x::Float64, y::Float64) = Event(Point(x, y))
Event(x::Number, y::Number) = Event(convert(Float64, x), convert(Float64, y))

Base.:(==)(e1::Event, e2::Event) = e1.point == e2.point
Base.isless(e1::Event, e2::Event) = e1.point < e2.point

