using BentleyOttmann, Test

@testset "Test event order" begin
    @testset "Test different y" begin
        p = Point(1,2)
        q = Point(3,4)
        @test (q < p) == true
        @test (q <= p) == true
        @test (q > p) == false
        @test (q >= p) == false
        @test (q == p) == false
    end
    @testset "Test same y" begin
        p = Point(1,2)
        q = Point(3,2)
        @test (q < p) == false 
        @test (q <= p) == false 
        @test (q > p) == true
        @test (q >= p) == true
        @test (q == p) == false
    end
end
