//import libpq

public enum ConnectionError: Error {
    case connectionFailed(message: String)
}

open class Database {
    open static func connect(parameters: ConnectionParameters = ConnectionParameters()) throws -> Connection {

        let connectionPointer = PQsetdbLogin(parameters.host,
            parameters.port,
            parameters.options,
            "",
            parameters.databaseName,
            parameters.user,
            parameters.password)

        guard PQstatus(connectionPointer) == CONNECTION_OK else {
            let message = String.fromCString(PQerrorMessage(connectionPointer))
            throw ConnectionError.ConnectionFailed(message: message ?? "Unknown error")
        }

        return Connection(pointer: connectionPointer)
    }
}
