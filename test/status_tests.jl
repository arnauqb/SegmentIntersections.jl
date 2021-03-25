using Test, BentleyOttmann

@testset "Test insert segment" begin
    status = Status(3.0)
    segment = Segment(1,2,3,4)
    insert!(status, segment)
    xs = collect(keys(status.dict))
    @test length(xs) == 1
    @test xs[1] ≈ 2.0
    @test status.dict[xs[1]] == segment
    segment = Segment(0.41, 1.11, 6.15, 0.29)
    status.y_sweep = 0.5
    insert!(status, segment)
    xs = collect(keys(status.dict))
    @test length(xs) == 2
    @test xs[1] ≈ 2.0
    @test xs[2] ≈ 4.68
    @test status.dict[xs[2]] == segment
end

@testset "Test update status" begin
    status = Status(3.0)
    segment = Segment(1,2,3,4)
    insert!(status, segment)
    segment_set = Set([Segment(10, 2, 12, 4), Segment(5,2,7,4)])
    update!(status, segment_set)
    xs = collect(keys(status.dict))
    @test xs[1] ≈ 2
    @test status.dict[xs[1]] == Segment(1,2,3,4)
    @test xs[2] ≈ 6
    @test status.dict[xs[2]] == Segment(5,2,7,4)
    @test xs[3] ≈ 11
    @test status.dict[xs[3]] == Segment(10,2,12,4)
end

@testset "Test delete segment from status" begin
    status = Status(3.0)
    segment = Segment(1,2,3,4)
    insert!(status, segment)
    @test length(status.dict) == 1
    xs = collect(keys(status.dict))
    @test xs[1] ≈ 2
    @test status.dict[xs[1]] == segment
    delete!(status, segment)
    @test length(status.dict) == 0
    xs = collect(keys(status.dict))
    @test length(xs) == 0
end

@testset "Test find segment side of point" begin
    segment1 = Segment(7.0, 10.0, 4.48, 5.09)
    segment2 = Segment(7.76, 9.33, 9.4, 7.83)
    segment3 = Segment(14.3, 7.61, 16.3, 9.57)
    status = Status(0.0)
    point = Point(11.8, 8.69)
    status.y_sweep = point.y
    update!(status, Set([segment1, segment2, segment3]))
    @test find_left(status, point) == segment2
    @test find_right(status, point) == segment3
end
