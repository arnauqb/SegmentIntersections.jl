using PyPlot, SegmentIntersections

function plot_random_lines()
    random_coordinates = 100 .* rand(100, 4);
    segments = Segment{Float64}[]
    for datap in eachrow(random_coordinates)
        push!(segments, Segment(datap...))
    end
    
    intersections_brute = find_intersections_brute(segments);
    
    intersections = find_intersections(segments);
    
    fig, ax = plt.subplots(1,2, sharex=true, sharey=true, figsize=(10,4))
    for segment in segments
        for axis in ax
            axis.plot(
                [segment.p.x, segment.q.x],
                [segment.p.y, segment.q.y],
                color = "C0",
                linewidth = 1,
            )
        end
    end
    ax[1].set_title("Brute force algorithm")
    ax[2].set_title("Bentley-Ottmann algorithm")
    xs = [point.x for point in intersections];
    ys = [point.y for point in intersections];
    ax[1].scatter(xs, ys, color = "red", s = 30)
    xs = [point.x for point in intersections_brute];
    ys = [point.y for point in intersections_brute];
    ax[2].scatter(xs, ys, color = "red", s = 30)
    plt.subplots_adjust(wspace=0, hspace=0)
    fig.savefig("random_lines.png", dpi=300, bbox_inches="tight")
end

function plot_complete_graph(n=16, r=100)
    theta_values = range(0, 2π, length=n+1)[1:end-1]
    coordinates = [[r*cos(theta), r*sin(theta)] for theta in theta_values]
    segments = Segment{Float64}[]
    for i in 1:n
        for j in (i+1):n
            push!(segments, Segment(Point(coordinates[i]...), Point(coordinates[j]...)))
        end
    end

    intersections_brute = find_intersections_brute(segments);
    
    intersections_bo = find_intersections(segments, tol=1e-9);
    
    fig, ax = plt.subplots(1,2, sharex=true, sharey=true, figsize=(10,4))
    for segment in segments
        for axis in ax
            axis.plot(
                [segment.p.x, segment.q.x],
                [segment.p.y, segment.q.y],
                color = "C0",
                linewidth = 1,
            )
        end
    end
    ax[1].set_title("Brute force algorithm")
    xs = [point.x for point in intersections_brute];
    ys = [point.y for point in intersections_brute];
    ax[1].scatter(xs, ys, color = "red", s = 30)
    xs = [point.x for point in intersections_bo];
    ys = [point.y for point in intersections_bo];
    ax[2].scatter(xs, ys, color = "red", s = 30)
    ax[2].set_title("Bentley-Ottmann algorithm")
    plt.subplots_adjust(wspace=0, hspace=0)
    fig.savefig("complete_graph.png", dpi=300, bbox_inches="tight")
end

plot_random_lines()
plot_complete_graph(14)

