using Test, BentleyOttmann

@testset "test segment init" begin
    s1 = Segment(1,2,3,4)
    @test s1.px == 1.0
    @test s1.py == 2.0
    @test s1.qx == 3.0
    @test s1.qy == 4.0
end
