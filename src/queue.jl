import Base: insert!, length, delete!
export EventQueue, fetch_event!, insert_event!
using DataStructures

struct EventQueue{T}
    tree::AVLTree{Point{T}}
    segments::Dict{Point{T}, Set{Segment{T}}} # maps upper point -> list of segments
end

length(Q::EventQueue) = length(Q.tree)
function delete!(Q::EventQueue, p::Point)
    delete!(Q.tree, p)
    delete!(Q.segments, p)
end

EventQueue() =
    EventQueue(AVLTree{Point{Float64}}(), Dict{Point{Float64},Set{Segment{Float64}}}())

function insert!(Q::EventQueue, segment::Segment)
    p = segment.p # guaranteed to be the upper point
    q = segment.q
    if p ∈ Q.tree
        push!(Q.segments[p], segment)
    else
        push!(Q.tree, p)
        Q.segments[p] = Set([segment])
    end
    if q ∉ Q.tree
        push!(Q.tree, q)
        Q.segments[q] = Set(Segment[]) # we only store for the upper
    end
end

function insert!(Q::EventQueue, p::Point)
    if p ∉ Q.tree
        push!(Q.tree, p)
    end
end

function EventQueue(segments::Vector{Segment{T}}) where {T<:AbstractFloat}
    Q = EventQueue()
    for segment in segments
        insert!(Q, segment)
    end
    return Q
end


function fetch_event!(Q::EventQueue)
    p = Q.tree[1]
    if p in keys(Q.segments)
        segments = Q.segments[p]
    else
        segments = Set{Segment{Float64}}()
    end
    delete!(Q, p)
    return Event(p, segments)
end


