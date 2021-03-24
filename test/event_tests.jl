using Test, BentleyOttmann

@testset "Test event order" begin
    e1 = Event(1,2,3,4)
    e2 = Event(5,6,0,1)
    @test e2 < e1
    @test e2 != e1
    @test e1 > e2
    e1 = Event(1,2,1,4)
    e2 = Event(2,4,0,1)
    @test e2 > e1
    @test e2 != e1
    @test e1 < e2
end
