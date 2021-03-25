export find_intersections

"""
    find_intersections(segments::Vector{Segment{T}}; tol=1e-9) where {T<:AbstractFloat}

Compute all the intersections between the segments using the Bentley-Ottmann algorithm.

Seting a tolerance value to work for all situations is tricky, so try to play with it if you
are finding that not all intersections are found.

# Examples
```jldoctest
julia> segments = [Segment(0,0,5,5), Segment(0,5,5,0)];
julia> intersections = find_intersections(segments)
julia> [Point(2.5, 2.5)]
```
"""
function find_intersections(segments::Vector{Segment{T}}; tol=1e-9) where {T<:AbstractFloat}
    Q = EventQueue(segments)
    y0 = Q.tree[1].y
    ys = [y0]
    status = Status(y0, tol)
    intersections = []
    while length(Q) != 0
        event = fetch_event!(Q)
        handle_event_point(Q, event, status, intersections)
    end
    return intersections
end

function handle_event_point(
    Q::EventQueue,
    event::Event,
    status::Status,
    intersections,
)
    p = event.point
    status.y_sweep = p.y
    U = event.segments
    L = Set{Segment}()
    C = Set{Segment}()
    for (key, segment) in status.dict
        if is_lower_end(segment, p)
            push!(L, segment)
        elseif contains(segment, p)
            push!(C, segment)
        end
    end
    CL = union(C, L)
    total = union(CL, U)
    if length(total) > 1
        push!(intersections, p)
    end
    UC = union(U, C)
    update!(status, insert=UC, delete=CL)
    if length(UC) == 0
        sl = find_left(status, p.x)
        sr = find_right(status, p.x)
        find_new_event(Q, sl, sr, p)
    else
        sp, xp = find_leftmost(UC, p.y, status.tol)
        sl = find_left(status, xp)
        find_new_event(Q, sl, sp, p)
        spp, xpp = find_rightmost(UC, p.y, status.tol)
        sr = find_right(status, xpp)
        find_new_event(Q, spp, sr, p)
    end
    return
end


function find_new_event(Q::EventQueue, s1::Segment, s2::Segment, p::Point)
    if s1 == s2
        return
    end
    do_intersect, intersection = intersect!(s1, s2)
    if do_intersect
        if ((intersection.y < p.y) | ((intersection.y == p.y) & (intersection.x > p.x)))
            insert!(Q, intersection)
        end
    end
end

# for when s1 or s2 are nothing
find_new_event(Q::EventQueue, s1, s2, p::Point) = nothing
