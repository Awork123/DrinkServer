import Fluent
import FluentSQLiteDriver
import Vapor

//let machineLoop = EventLoopFuture

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
/*
    let hostname: String
    #if os(Linux)
    hostname = "psql"
    #else
    hostname = "localhost"
    #endif
    
    app.databases.use(.postgres(
        hostname: Environment.get("POSTGRES_HOST") ?? hostname,
        username: Environment.get("POSTGRES_USER") ?? "vapor_username",
        password: Environment.get("POSTGRES_PASSWORD") ?? "vapor_password",
        database: Environment.get("POSTGRES_DB") ?? "vapor_database"
    ), as: .psql)
*/
    app.databases.use(.sqlite(.memory), as: .sqlite)
    
    app.migrations.add(User.Migtation())
    app.migrations.add(Token.Migration())
    // register routes
    try app
        .routes
        .register(collection: UserController())
    app
        .http
        .server
        .configuration
        .hostname = "0.0.0.0"
    try routes(app)
    
    app
    .autoMigrate()
}
