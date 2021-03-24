using BentleyOttmann, Test

@testset "Test queue" begin
    Q = EventQueue()
    e1 = Event(1, 2, 3, 4)
    e2 = Event(5, 6, 3, 4)
    e3 = Event(4, 3, 2, 7)
    e4 = Event(4, 3, 2, 4)
    insert_event!(Q, e1)
    insert_event!(Q, e2)
    insert_event!(Q, e3)
    insert_event!(Q, e4)
    @test fetch_event!(Q) == e3
    @test fetch_event!(Q) == e2
    @test fetch_event!(Q) == e4
    @test fetch_event!(Q) == e1
end
