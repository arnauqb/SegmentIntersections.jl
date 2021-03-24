using Test, BentleyOttmann

@testset "test segment init" begin
    s1 = Segment(1,2,3,4)
    @test s1.p == Point(1,2)
    @test s1.q == Point(3,4)
end

@testset "Test segment intersection" begin
    A = zeros((2,2))
    b = zeros(2)
    # do intersect
    segment1 = Segment(2.3, 7.99, 10.64, 3.93)
    segment2 = Segment(2.86, 3.45, 11.0, 7.0)
    do_intersect, intersection = intersect!(segment1, segment2, A, b)
    @test do_intersect == true
    @test intersection == Point(7.4837451201333005, 5.68380771649371)
    # don't intersect
    segment1 = Segment(5, -2, 9.4, -2.79)
    segment2 = Segment(4.82, -5.83, 7.2, -3.41)
    do_intersect, intersection = intersect!(segment1, segment2, A, b)
    @test do_intersect == false
    @test intersection == Point(0.0, 0.0)
end
