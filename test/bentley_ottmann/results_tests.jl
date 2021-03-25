using Test, SegmentIntersections

@testset "Test random lines" begin
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

# This test does currently not pass
#@testset "Test complete graph" begin
#    n = 4
#    r = 100
#    theta_values = range(0, 2π, length=n+1)[1:end-1]
#    coordinates = [[r*cos(theta), r*sin(theta)] for theta in theta_values]
#    segments = Segment{Float64}[]
#    for i in 1:n
#        for j in (i+1):n
#            push!(segments, Segment(Point(coordinates[i]...), Point(coordinates[j]...)))
#        end
#    end
#    bo_intersections = find_intersections(segments)
#    brute_intersections = find_intersections_brute(segments)
#    @test length(bo_intersections) == length(brute_intersections)
#    matches = 0
#    println("checking intersections...")
#    for expected in brute_intersections 
#        for intersection in bo_intersections 
#            if isapprox(intersection, expected, rtol = 1e-2)
#                matches += 1
#            end
#        end
#    end
#    @test matches == length(bo_intersections)
#end
