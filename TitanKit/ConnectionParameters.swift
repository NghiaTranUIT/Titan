#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

public struct ConnectionParameters {
    public let host: String
    public let port: String
    public let options: String
    public let databaseName: String
    public let user: String
    public let password: String

    public init(host: String = String(cString: getenv("PGHOST")) ?? "",
        port: String = String(cString: getenv("PGPORT")) ?? "",
        options: String = String(cString: getenv("PGOPTIONS")) ?? "",
        databaseName: String = String(cString: getenv("PGDATABASE")) ?? "",
        user: String = String(cString: getenv("PGUSER")) ?? "",
        password: String = String(cString: getenv("PGPASSWORD")) ?? "") {
            self.host = host
            self.port = port
            self.options = options
            self.databaseName = databaseName
            self.user = user
            self.password = password
    }
}
