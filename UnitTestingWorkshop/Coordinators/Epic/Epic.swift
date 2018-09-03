struct Epic {
    let operations: [EpicOperation]
    init(operations: [EpicOperation]) {
        self.operations = operations
    }

    func iterator() -> EpicIterator {
        return EpicIterator(self)
    }

    struct EpicIterator: IteratorProtocol {
        let epic: Epic
        var currentIndex: Int = 0

        init(_ epic: Epic) {
            self.epic = epic
        }

        mutating func next() -> EpicOperation? {
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

struct EpicOperation {
    typealias BlockType = (() -> Void)?
    let identifier: String
    let block: BlockType?

    init(_ identifier: String, block: BlockType?) {
        self.identifier = identifier
        self.block = block
    }
}

struct EpicResult<U> {
    let next: Bool
    let value: U
}
