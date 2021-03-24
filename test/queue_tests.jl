using BentleyOttmann, Test

@testset "Test queue" begin
    Q = PriorityQueue()
    p = Point(1,2)
    q = Point(3,4)
    r = Point(3,3)
    s = Point(3,2)
    enqueue!(Q, p)
    enqueue!(Q, q)
    enqueue!(Q, r)
    enqueue!(Q, s)
    @test dequeue!(Q) == q
    @test dequeue!(Q) == r
    @test dequeue!(Q) == p
    @test dequeue!(Q) == s
end
