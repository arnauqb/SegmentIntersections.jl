using Test, SegmentIntersections

@testset "Test event creation" begin
    e1 = Event(1,2)
    e2 = Event(0,5)
    e3 = Event(1,2)
    @test e1.point == Point(1,2)
    @test e2 < e1
    @test e1 == e3
end
