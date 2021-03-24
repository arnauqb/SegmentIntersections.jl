export EventQueue

#import DataStructures: PriorityQueue, enqueue!, peek
using DataStructures

#enqueue!(Q::PriorityQueue, p::Point) = enqueue!(Q, p, p)

EventQueue() = AVLTree{Event}()

