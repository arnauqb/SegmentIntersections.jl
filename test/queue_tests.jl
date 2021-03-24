using BentleyOttmann, Test

@testset "Test queue" begin
    Q = EventQueue()
    e1 = Event(1, 2, 3, 4)
    e2 = Event(5, 6, 3, 4)
    e3 = Event(4, 3, 2, 7)
    e4 = Event(4, 3, 2, 4)
    insert!(Q, e1)
    insert!(Q, e2)
    insert!(Q, e3)
    insert!(Q, e4)
    @test fetch!(Q) == e3
    @test fetch!(Q) == e2
    @test fetch!(Q) == e4
    @test fetch!(Q) == e1
end
