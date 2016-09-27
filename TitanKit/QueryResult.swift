//import libpq

/// Results are readonly operations and therefore threadsafe.
public final class QueryResult {
    let resultPointer: OpaquePointer

    init(resultPointer: OpaquePointer) {
        self.resultPointer = resultPointer
    }

    deinit {
        PQclear(resultPointer)
    }

    public lazy var columnIndexesForNames: [String: Int] = {
        var columnIndexesForNames = [String: Int]()

        for columnNumber in 0..<self.numberOfColumns {
            let name = String.fromCString(PQfname(self.resultPointer, columnNumber))!
            columnIndexesForNames[name] = Int(columnNumber)
        }

        return columnIndexesForNames
    }()

    public lazy var numberOfRows: Int32 = {
        return PQntuples(self.resultPointer)
    }()

    public lazy var numberOfColumns: Int32 = {
        return PQnfields(self.resultPointer)
    }()

    lazy var typesForColumnIndexes: [ColumnType?] = {
        var typesForColumns = [ColumnType?]()
        typesForColumns.reserveCapacity(Int(self.numberOfColumns))

        for columnNumber in 0..<self.numberOfColumns {
            let typeId = PQftype(self.resultPointer, columnNumber)
            typesForColumns.append(ColumnType(rawValue: typeId))
        }

        return typesForColumns
    }()

    public lazy var rows: [QueryResultRow] = {
        var rows = [QueryResultRow]()
        rows.reserveCapacity(Int(self.numberOfRows))

        for rowIndex in 0..<self.numberOfRows {
            rows.append(self.readResultRowAtIndex(rowIndex))
        }

        return rows
    }()

    fileprivate func readResultRowAtIndex(_ rowIndex: Int32) -> QueryResultRow {
        var values = [Any?]()
        values.reserveCapacity(Int(self.numberOfColumns))

        for columnIndex in 0..<self.numberOfColumns {
            values.append(readColumnValueAtIndex(columnIndex, rowIndex: rowIndex))
        }

        return QueryResultRow(columnValues: values, queryResult: self)
    }

    fileprivate func readColumnValueAtIndex(_ columnIndex: Int32, rowIndex: Int32) -> Any? {
        guard PQgetisnull(self.resultPointer, rowIndex, columnIndex) == 0 else { return nil }

        let startingPointer = PQgetvalue(self.resultPointer, rowIndex, columnIndex)

        guard let type = self.typesForColumnIndexes[Int(columnIndex)] else {
            let length = Int(PQgetlength(self.resultPointer, rowIndex, columnIndex))
            // Unsupported column types are returned as [UInt8]
            return byteArrayForPointer(UnsafePointer<UInt8>(startingPointer), length: length)
        }

        switch type {
        case .boolean: return UnsafePointer<Bool>(startingPointer).memory
        case .int16: return Int16(bigEndian: UnsafePointer<Int16>(startingPointer).memory)
        case .int32: return Int32(bigEndian: UnsafePointer<Int32>(startingPointer).memory)
        case .int64: return Int64(bigEndian: UnsafePointer<Int64>(startingPointer).memory)
        case .singleFloat: return floatFromInt32(Int32(bigEndian: UnsafePointer<Int32>(startingPointer).memory))
        case .doubleFloat: return doubleFromInt64(Int64(bigEndian: UnsafePointer<Int64>(startingPointer).memory))
        case .text: return String.fromCString(startingPointer)!
        }
    }

    fileprivate func byteArrayForPointer(_ start: UnsafePointer<UInt8>, length: Int) -> [UInt8] {
        return Array(UnsafeBufferPointer(start: start, count: length))
    }
}

public enum ColumnType: UInt32 {
    case boolean = 16
    case int64 = 20
    case int16 = 21
    case int32 = 23
    case text = 25
    case singleFloat = 700
    case doubleFloat = 701
}
