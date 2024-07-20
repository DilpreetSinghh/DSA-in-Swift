public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        array.isEmpty
    }

    public var peek: T? {
        array.first
    }

    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
      }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}

var queue = QueueArray<Int>()
queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)
print(queue.peek ?? "Queue is empty") // Output: 10
print(queue.dequeue() ?? "Queue is empty") // Output: 10
print(queue.dequeue() ?? "Queue is empty") // Output: 20
print(queue.isEmpty) // Output: false
print(queue.dequeue() ?? "Queue is empty") // Output: 30
print(queue.isEmpty) // Output: true

//: [Next](@QueueLinkedList)
