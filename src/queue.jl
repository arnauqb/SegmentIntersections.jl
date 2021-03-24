export EventQueue, insert!, fetch!
using DataStructures

EventQueue() = AVLTree{Event}()

insert!(Q::AVLTree{Event}, e::Event) = push!(Q, e)

function fetch!(Q::AVLTree{Event})
    e = Q[1]
    delete!(Q, e)
    return e
end


