using Test, SegmentIntersections

@testset "Test queue" begin
    Q = EventQueue()
    s1 = Segment(1, 2, 3, 4)
    s2 = Segment(5, 6, 3, 4)
    s3 = Segment(4, 3, 2, 7)
    s4 = Segment(4, 3, 2, 4)
    s5 = Segment(0, 1, 2, 7)
    insert!(Q, s1)
    insert!(Q, s2)
    insert!(Q, s3)
    insert!(Q, s4)
    insert!(Q, s5)
    e = fetch_event!(Q)
    @test e.point == Point(2,7)
    @test e.segments == Set([s3, s5])
    e = fetch_event!(Q)
    @test e.point == Point(5,6)
    @test e.segments == Set([s2])
    e = fetch_event!(Q)
    @test e.point == Point(2,4)
    @test e.segments == Set([s4])
    e = fetch_event!(Q)
    @test e.point == Point(3,4)
    @test e.segments == Set([s1])
end
