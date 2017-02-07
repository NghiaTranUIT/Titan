//
//  QueueType.swift
//  Titan
//
//  Created by Nghia Tran on 2/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

//
// MARK: - WorkerQueueType
// An atrast queue type protocl
protocol QueueType {
    
    associatedtype Element
    
    var queue: [Element] {get}
    
    var size: Int {get}
    
    var isEmpty: Bool {get}
    
    func enqueue(worker: Element)
    
    func dequeue() -> Element?
    
    func dequeue(worker: Element)
    
    func cancelAllWorker()
}
