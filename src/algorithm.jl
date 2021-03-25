export handle_event_point
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
    for segment in CL
        delete!(status, segment)
    end
    UC = union(U, C)
    update!(status, UC)
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
