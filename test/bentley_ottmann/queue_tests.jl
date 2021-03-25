using Test, SegmentIntersections

@testset "Test queue" begin
    Q = EventQueue()
    s1 = Segment(1, 2, 3, 4)
    s2 = Segment(5, 6, 3, 4)
    s3 = Segment(4, 3, 2, 7)
    s4 = Segment(4, 3, 2, 4)
    insert!(Q, s1)
    insert!(Q, s2)
    insert!(Q, s3)
    insert!(Q, s4)
    e = fetch_event!(Q)
    @test e.point == Point(2,7)
    e = fetch_event!(Q)
    @test e.point == Point(5,6)
    e = fetch_event!(Q)
    @test e.point == Point(2,4)
    e = fetch_event!(Q)
    @test e.point == Point(3,4)
end
