//
//  QueueRingBuffer.swift
//  
//
//  Created by Dilpreet Singh on 05/07/24.
//

public struct RingBuffer<T> {
  
    /// An array of optional Elements `[T?]`
    /// ## Use
    /// Store the buffer's contents. Intialised to fixed size with `nil` values, indicating empty slots
  private var array: [T?]
    
    /// An integer representing the current read position in the buffer, initialised to `0`.
  private var readIndex = 0
    
    /// An integer representing the current write position in the buffer, initialised to `0`.
  private var writeIndex = 0
  
    ///  Initialiser of `array`
    ///  ## Working
    ///  The initialiser takes an integer `count`, which determines the buffer's size. It initialises the `array` with `nil` values of the given count
  public init(count: Int) {
    array = Array<T?>(repeating: nil, count: count)
  }
  
    /// Returns the element at the `readIndex` without modifying the buffer.
    /// ## Use
    /// Peek at the next element to be read.
  public var first: T? {
    array[readIndex]
  }
  
    
  public mutating func write(_ element: T) -> Bool {
    if !isFull {
      array[writeIndex % array.count] = element
      writeIndex += 1
      return true
    } else {
      return false
    }
  }
  
  public mutating func read() -> T? {
    if !isEmpty {
      let element = array[readIndex % array.count]
      readIndex += 1
      return element
    } else {
      return nil
    }
  }
  
    /// Computes the number of elements available for reading
  private var availableSpaceForReading: Int {
    writeIndex - readIndex
  }
  
    
  public var isEmpty: Bool {
    availableSpaceForReading == 0
  }
  
    /// Computes the number of elements that can still be written
    ///
    /// Find out how much space is available to write
  private var availableSpaceForWriting: Int {
    array.count - availableSpaceForReading
  }
  
  public var isFull: Bool {
    availableSpaceForWriting == 0
  }
}

extension RingBuffer: CustomStringConvertible {
  public var description: String {
    let values = (0..<availableSpaceForReading).map {
      String(describing: array[($0 + readIndex) % array.count]!)
    }
    return "[" + values.joined(separator: ", ") + "]"
  }
}
