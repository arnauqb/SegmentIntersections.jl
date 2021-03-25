export Status, find_left, find_right, insert!, update!, delete!
using DataStructures

mutable struct Status{T <: AbstractFloat}
    dict::SortedDict{T, Segment{T}}
    y_sweep::T
    tol::T
end

Status(y0, tol=1e-9) = Status(SortedDict{Float64, Segment{Float64}}(), y0, tol)

function insert!(status::Status, segment::Segment)
    y = status.y_sweep - status.tol
    x = get_x(segment, y)
    status.dict[x] = segment
end

function update!(status::Status; insert, delete)
    y = status.y_sweep - status.tol
    new_dict = SortedDict{Float64, Segment{Float64}}()
    for (key, segment) in status.dict
        if segment ∉ delete
            new_dict[get_x(segment, y)] = segment
        end
    end
    for segment in insert 
        new_dict[get_x(segment, y)] = segment
    end
    status.dict = new_dict
end

function find_left(status::Status, x)
    x -= 1e-5 
    (length(status.dict) == 0) && return nothing
    (x < first(status.dict).first) && return nothing
    return status.dict[searchsortedlast(status.dict, x)]
end

function find_right(status::Status, x)
    x += 1e-5 
    (length(status.dict) == 0) && return nothing
    (x > last(status.dict).first) && return nothing
    return status.dict[searchsortedfirst(status.dict, x)]
end

