import Base: insert!
export EventQueue, insert!, fetch!
using DataStructures

EventQueue() = AVLTree{Event}()

function fetch!(Q::AVLTree{Event})
    e = Q[1]
    delete!(Q, e)
    return e
end


