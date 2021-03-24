export enqueue!, PriorityQueue, peek

import DataStructures: PriorityQueue, enqueue!, peek

enqueue!(Q::PriorityQueue, p::Point) = enqueue!(Q, p, p)

