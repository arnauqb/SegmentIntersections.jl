export find_intersections_brute
"""
This is the O(N^2) brute force version in which we test all segments
against all segments
"""

function find_intersections_brute(segments::Vector{Segment{T}}) where {T<:AbstractFloat}
    A = zeros((2, 2))
    b = zeros(2)
    n_segments = length(segments)
    intersections = typeof(segments[1].p)[]
    for i = 1:(n_segments-1)
        s1 = segments[i]
        for j = (i+1):n_segments
            (i == j) && (continue)
            s2 = segments[j]
            do_intersect, intersection = intersect!(s1, s2, A, b)
            if do_intersect
                push!(intersections, intersection)
            end
        end
    end
    return intersections
end
