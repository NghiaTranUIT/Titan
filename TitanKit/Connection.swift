//import libpq

/// A database connection is NOT thread safe.
open class Connection {
    let connectionPointer: OpaquePointer

    init(pointer: OpaquePointer) {
        self.connectionPointer = pointer
    }

    deinit {
        PQfinish(connectionPointer)
    }

    /// Executes a passed in query. First parameter is referred to as `$1` in the query.
    open func execute(_ query: Query, parameters: [Parameter] = []) throws -> QueryResult {
        let values = UnsafeMutablePointer<UnsafePointer<Int8>>(allocatingCapacity: parameters.count)

        defer {
            values.deinitialize()
            values.deallocate(capacity: parameters.count)
        }

        var temps = [Array<UInt8>]()
        for (i, value) in parameters.enumerated() {
            temps.append(Array<UInt8>(value.asString.utf8) + [0])
            values[i] = UnsafePointer<Int8>(temps.last!)
        }

        let resultPointer = PQexecParams(connectionPointer,
                                         query.string,
                                         Int32(parameters.count),
                                         nil,
                                         values,
                                         nil,
                                         nil,
                                         query.resultFormat.rawValue)

        let status = PQresultStatus(resultPointer)

        switch status {
        case PGRES_COMMAND_OK, PGRES_TUPLES_OK: break
        default:
            let message = String.fromCString(PQresultErrorMessage(resultPointer)) ?? ""
            throw QueryError.InvalidQuery(errorMessage: message)
        }

        return QueryResult(resultPointer: resultPointer)
    }
}

// TODO: Implement on Connection
public enum ConnectionStatus {
    case connected
    case disconnected
}
