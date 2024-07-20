//
//  Queue.swift
//  
//
//  Created by Dilpreet Singh on 02/07/24.
//


public protocol Queue {  
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
