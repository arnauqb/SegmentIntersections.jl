using Test, SegmentIntersections

@testset "Test results" begin
    random_data = 100 .* rand(100, 4);
    segments = Segment{Float64}[]
    for datap in eachrow(random_data)
        push!(segments, Segment(datap...))
    end
    bo_intersections = find_intersections(segments)
    brute_intersections = find_intersections_brute(segments)
    @test length(bo_intersections) == length(brute_intersections)
    for expected in brute_intersections 
        match = false
        for intersection in bo_intersections 
            if isapprox(intersection, expected, rtol = 1e-2)
                match = true
            end
        end
        @test match == true
    end
end
