using Test, BentleyOttmann

@testset "Test results" begin
    segments = [
        Segment(4.9, 3.56, 2.86, 1.62),
        Segment(3.63, 3.88, 5.45, 2.32),
        Segment(2.99, 3.29, 4.47, 1.8),
        Segment(2.66, 2.85, 3.81, 1.44),
    ];
    expected_intersections = [Point(4.48, 3.16), Point(3.78, 2.5), Point(3.31, 2.05)];
    intersections = find_intersections_brute(segments)
    for expected in expected_intersections
        match = false
        for intersection in intersections
            if isapprox(intersection, expected, rtol = 1e-2)
                match = true
            end
        end
        @test match == true
    end
end
