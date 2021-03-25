using Test, SegmentIntersections

@testset "test segment init" begin
    s1 = Segment(1,2,3,4)
    @test s1.p == Point(3,4)
    @test s1.q == Point(1,2)
end

@testset "Test segment order" begin
    s1 = Segment(1,2,3,4)
    s2 = Segment(1,5,3,4)
    @test s2 < s1
    s1 = Segment(3,5,3,4)
    s2 = Segment(1,5,3,4)
    @test s2 < s1
end

@testset "Test singular segment" begin
    s = Segment(1, 2, 1, 4)
    @test is_singular(s) == true 
    s = Segment(3, 2, 3, 2)
    @test is_singular(s) == true 
    s = Segment(1, 2, 3, 4)
    @test is_singular(s) == false
end

@testset "Test segment intersection" begin
    # do intersect
    segment1 = Segment(2.3, 7.99, 10.64, 3.93)
    segment2 = Segment(2.86, 3.45, 11.0, 7.0)
    do_intersect, intersection = intersect!(segment1, segment2)
    @test do_intersect == true
    @test intersection.x ≈ 7.48 rtol = 1e-2
    @test intersection.y ≈ 5.47 rtol = 1e-2
    # don't intersect
    segment1 = Segment(5, -2, 9.4, -2.79)
    segment2 = Segment(4.82, -5.83, 7.2, -3.41)
    do_intersect, intersection = intersect!(segment1, segment2)
    @test do_intersect == false
    @test intersection == Point(0.0, 0.0)
    # ignore singular 
    segment1 = Segment(1, 2, 1, 4)
    segment2 = Segment(1, 2, 3, 4)
    do_intersect, intersection = intersect!(segment1, segment2)
    @test do_intersect == false
    @test intersection == Point(0.0, 0.0)
end

@testset "Test is end" begin
    segment = Segment(1,2,3,4)
    @test is_lower_end(segment, Point(3,4)) == false
    @test is_lower_end(segment, Point(1,2)) == true
    @test is_lower_end(segment, Point(10,2)) == false
    @test is_upper_end(segment, Point(3,4)) == true
    @test is_upper_end(segment, Point(1,2)) == false
    @test is_upper_end(segment, Point(10,2)) == false
end

@testset "Test contains" begin
    segment = Segment(1,2,3,4)
    @test contains(segment, Point(1,2)) == false
    @test contains(segment, Point(3,4)) == false
    @test contains(segment, Point(2,3)) == true
    @test contains(segment, Point(2,3)) == true
    @test contains(segment, Point(1.5,2.5)) == true
end

@testset "Test leftmost and rightmost" begin
    segment1 = Segment(12.4, 5.56, 9.69, 2.85)
    segment2 = Segment(12.4, 5.56, 11.71, 2.61)
    segment3 = Segment(12.4, 5.56, 13.06, 2.68)
    segment4 = Segment(12.4, 5.56, 14.55, 3.47)
    segment_set = Set([segment1, segment2, segment3, segment4])
    segment, xmin = find_leftmost(segment_set, 4)
    @test segment == segment1
    @test xmin ≈  10.84
    segment, xmax = find_rightmost(segment_set, 4)
    @test segment == segment4
    @test xmax ≈ 14.0 rtol=1e-2
end
