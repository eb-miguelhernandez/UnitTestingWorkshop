public struct Epic {
    let operations: [EpicOperation]
    public init(operations: [EpicOperation]) {
        self.operations = operations
    }

    public func iterator() -> EpicIterator {
        return EpicIterator(self)
    }

    /// Runs all operations. Returns the iterator.
    public func run() -> EpicIterator {
        var iterator = self.iterator()
        while iterator.finished == false {
            let operation = iterator.next()
            if let block = operation?.block {
                block()
            }
        }
        return iterator
    }

    public struct EpicIterator: IteratorProtocol {
        private let epic: Epic
        private var currentIndex: Int = 0
        public var lastIndex: Int { return currentIndex }
        /// Returns true if there are no more operations to follow
        public var finished: Bool { return (self[self.currentIndex]) == nil ? true : false }

        init(_ epic: Epic) {
            self.epic = epic
        }

        /// Returns the next operation to be executed
        public mutating func next() -> EpicOperation? {
            guard let nextItem = self[self.currentIndex] else { return nil }

            self.currentIndex += 1
            return nextItem
        }

        private subscript(index: Int) -> EpicOperation? {
            guard index >= 0 && index < self.epic.operations.count else { return nil }
            return self.epic.operations[index]
        }
    }
}

public typealias EpicBlock = () -> Void

public struct EpicOperation {
    typealias EmptyBlock = (() -> Void)?
    public let identifier: String
    public let block: EpicBlock?

    public init(_ identifier: String, block: EpicBlock?) {
        self.identifier = identifier
        self.block = block
    }
}
