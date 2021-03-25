export Status, find_left, find_right
using DataStructures

mutable struct Status{T <: AbstractFloat}
    dict::SortedDict{T, Segment{T}}
    y_sweep::T
    tol::T
end

Status(y0, tol=1e-10) = Status(SortedDict{Float64, Segment{Float64}}(), y0, tol)

function insert!(status::Status, segment::Segment)
    y = status.y_sweep - status.tol
    x = get_x(segment, y)
    status.dict[x] = segment
end

function update!(status::Status, segment_set)
    y = status.y_sweep - 1e-20 #status.tol
    dict = SortedDict{Float64, Segment{Float64}}()
    for segment in union(segment_set, Set(values(status.dict)))
        dict[get_x(segment, y)] = segment
    end
    status.dict = dict
end

function delete!(status::Status, segment::Segment) 
    for key in keys(status.dict)
        if status.dict[key] == segment
            delete!(status.dict, key)
            return
        end
    end
end


function find_left(status::Status, point::Point)
    x = point.x - 1e-6
    #y = status.y_sweep - status.tol
    #x = get_x(segment, y)
    (length(status.dict) == 0) && return nothing
    (x < first(status.dict).first) && return nothing
    return status.dict[searchsortedlast(status.dict, x)]
end

function find_right(status::Status, point::Point)
    x = point.x + 1e-6
    #y = status.y_sweep - status.tol
    #x = get_x(segment, y)
    (length(status.dict) == 0) && return nothing
    (x > last(status.dict).first) && return nothing
    return status.dict[searchsortedfirst(status.dict, x)]
end

