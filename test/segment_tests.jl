using Test, BentleyOttmann

@testset "test segment init" begin
    s1 = Segment(1,2,3,4)
    @test s1.p == Point(3,4)
    @test s1.q == Point(1,2)
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
end
