//
//  DoublyLinkedList.swift
//  
//
//  Created by Dilpreet Singh on 02/07/24.
//


/// This line declares a generic class Node that can store a value of any type T.
public class Node<T> {
    
    /// This property stores the data (or value) of the node.
  public var value: T
    
    /// This property holds a reference to the next Node in the linked list.
    ///
    ///  `next`: The name of the property.
    ///  Whereas `Node<T>` is the type of the property. This specifies that next is of type Node which holds elements of type T, which is generic type.
    ///  `?`: Indicates that this is an optional property, meaning it can hold either a `Node<T>` or` nil`.
  public var next: Node<T>?
    
    /// This property holds a reference to the previous Node in the linked list
    ///
    /// `next`: The name of the property.
    ///  Whereas `Node<T>` is the type of the property. This specifies that next is of type Node which holds elements of type T, which is generic type.
    ///  `?`: Indicates that this is an optional property, meaning it can hold either a `Node<T>` or` nil`.
  public var previous: Node<T>?
    
  public init(value: T) {
    self.value = value
  }
}


/// Node will conform to the CustomStringConvertible protocol.
///
/// `:` : This symbol is used to specify that Node is conforming to a protocol. It is used here to indicate that Node will conform to the CustomStringConvertible protocol.
/// CustomStringConvertible: This is a protocol in Swift that requires conforming types to provide a description property. This property should return a String that represents the instance in a human-readable format.
extension Node: CustomStringConvertible {
    
    ///  Declares a public computed property `description` of type `String` that provides a custom string representation of the Node instance, as required by `CustomStringConvertible` Protocol
    ///
    /// `public`: This access modifier makes the description property accessible from any module that imports the module containing the Node class. It ensures that the description property can be accessed from outside the defining module.
    /// `var`: This keyword declares a variable property. Since this is a computed property, var is used instead of let.
    /// `description`: This is the name of the property. By naming it description, we fulfill the requirement of the CustomStringConvertible protocol.
    /// `: String` : This indicates the type of the property. The description property must be of type String as required by the CustomStringConvertible protocol.
  public var description: String {
      
      /// Returns Value in String
      ///
      /// describing:: This is the label for the initializer parameter. The describing initializer is a static method of String that returns a string representation of the given value.
      /// value: This is the property of the Node class that holds the data of the node. It can be of any type T specified when the Node instance is created.
    String(describing: value)
  }
}



public class DoublyLinkedList<T> {
  
  private var head: Node<T>?
  private var tail: Node<T>?
  
  public init() { }
  
  public var isEmpty: Bool {
    head == nil
  }
  
  public var first: Node<T>? {
    head
  }
  
  public func append(_ value: T) {
    let newNode = Node(value: value)
    
    guard let tailNode = tail else {
      head = newNode
      tail = newNode
      return
    }
    
    newNode.previous = tailNode
    tailNode.next = newNode
    tail = newNode
  }
  
  public func remove(_ node: Node<T>) -> T {
    let prev = node.previous
    let next = node.next
    
    if let prev = prev {
      prev.next = next
    } else {
      head = next
    }
    
    next?.previous = prev
    
    if next == nil {
      tail = prev
    }
    
    node.previous = nil
    node.next = nil
    
    return node.value
  }
}

extension DoublyLinkedList: CustomStringConvertible {
  
  public var description: String {
    var string = ""
    var current = head
    while let node = current {
      string.append("\(node.value) -> ")
      current = node.next
    }
    return string + "end"
  }
}

public class LinkedListIterator<T>: IteratorProtocol {
  
  private var current: Node<T>?
  
  init(node: Node<T>?) {
    current = node
  }
  
  public func next() -> Node<T>? {
    defer { current = current?.next }
    return current
  }
}

extension DoublyLinkedList: Sequence {
  
  public func makeIterator() -> LinkedListIterator<T> {
    LinkedListIterator(node: head)
  }
}
