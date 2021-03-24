export Status, find_left, find_right
using DataStructures

struct Status{T}
    tree::AVLTree{Segment{T}}
    segments::Dict{T, Set{Segment{T}}} # maps upper point -> list of segments
end

Status() = Status(AVLTree{Float64}(), Dict{Float64, Set{Segment{Float64}}}())

function insert!(status::Status, segment::Segment, point::Point)
    y = point.y - 1e-10
    x = get_x(segment, y)
    push!(status.tree, x)
    if x ∈ keys(status.segments)
        push!(status.segments[x], segment)
    else
        status.segments[x] = Set([segment])
    end
end


#function Status(segments::Union{Vector{Segments}, Set{Segments}}, point::Point)
#    y = point.y - 1e-10 # make user input tolerance
#    tree = AVLTree{Float64}()
#    dict = Dict{Point{Float64},Vector{Segment{Float64}}}()
#    for segment in segments
#        x = segment.get_x(y)
#        push!(tree, x)
#        dict[x] = segment
#    end
#    return Status(point, tree, dict)
#end

function delete!(status::Status, segment::Segment)
    delete!(status.tree, segment.p)
    delete!(status.segments, segment.p)
end

function find_left(status::Status, point::Point)
    try
        rank = sorted_rank(status.tree, point.x)
    catch
        return nothing
    end
    if rank == 1
        return nothing
    end
    return status.segments[tree[rank-1]]
end

function find_right(status::Status, point::Point)
    try
        rank = sorted_rank(status.tree, point.x)
    catch
        return nothing
    end
    if rank == length(status.tree)
        return nothing
    end
    return status.segments[tree[rank+1]]
end



#Status() = AVLTree{Segment}()
#
#struct Status{T<:Float64}
#    L::Set{T} # set of segments such that the current point is the lower end
#    C::Set{T} # set of segments such that the current point is inside the segment
#    U::Set{T} # set of segments such that the current point is the upper end
#
#end
