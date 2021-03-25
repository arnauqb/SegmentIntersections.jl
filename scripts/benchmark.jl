using BenchmarkTools, SegmentIntersections

random_coordinates = 100 .* rand(500, 4);
segments = Segment{Float64}[]
for datap in eachrow(random_coordinates)
    push!(segments, Segment(datap...))
end

println("Running brute force...")
@btime find_intersections_brute(segments);

println("Running Bentley-Ottman...")
@btime find_intersections(segments);
