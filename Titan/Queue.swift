//
//  WorkerQueue.swift
//  Titan
//
//  Created by Nghia Tran on 2/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation

class Queue<Item: Worker>: QueueType {
    
    typealias Element = Item
    
    //
    // MARK: - Variable
    fileprivate var _queue: [Element] = []
    var queue: [Element] {
        return self._queue
    }
    
    fileprivate var _size: Int = 0
    var size: Int {
        return self._size
    }
    
    fileprivate var _isEmpty: Bool = true
    var isEmpty: Bool {
        return self._isEmpty
    }
    
    //
    // MARK: - Public
    func enqueue(worker: Element) {
        self._queue.append(worker)
    }
    
    func dequeue(worker: Element) {
        let index = self._queue.index { innerWorker -> Bool in
            return innerWorker == worker
        }
        
        if let index = index {
            self._queue.remove(at: index)
        }
    }
    
    func dequeue() -> Element? {
        return nil
    }
    
    func cancelAllWorker() {
        
    }
}
