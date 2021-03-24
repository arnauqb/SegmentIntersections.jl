using BentleyOttmann, Test

@testset "Test queue" begin
    Q = EventQueue()
    s1 = (1, 2, 3, 4)
    s2 = (5, 6, 3, 4)
    s3 = (4, 3, 2, 7)
    s4 = (4, 3, 2, 4)
    insert!(Q, s1)
    insert!(Q, s2)
    insert!(Q, s3)
    @test fetch!(Q) == Point(2,7), s3
    @test fetch!(Q) == Point(5,6), s2
    @test fetch!(Q) == Point(2,4), s4
    @test fetch!(Q) == Point(3,4), s1
end
