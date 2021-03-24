using BentleyOttmann, Test

@testset "create point" begin
    p = Point(1,2)
    @test p.x == 1.0
    @test typeof(p.x) == Float64
    @test p.y == 2.0
    @test typeof(p.y) == Float64
    p = Point(1.0,2.0)
    @test p.x == 1.0
    @test typeof(p.x) == Float64
    @test p.y == 2.0
    @test typeof(p.y) == Float64
end

@testset "Test point order" begin
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
