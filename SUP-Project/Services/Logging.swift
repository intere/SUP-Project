//
//  Logging.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/20/22.
//

import Foundation

protocol Logging {
    func log(_ message: LogMessage)
}

extension Logging {
    func trace(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .trace, date: .now, message: message, file: file, function: function, line: line))
    }

    func debug(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .debug, date: .now, message: message, file: file, function: function, line: line))
    }

    func info(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .info, date: .now, message: message, file: file, function: function, line: line))
    }

    func warn(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .warn, date: .now, message: message, file: file, function: function, line: line))
    }

    func error(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .error, date: .now, message: message, file: file, function: function, line: line))
    }

    func assertion(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .assertion, date: .now, message: message, file: file, function: function, line: line))
        assertionFailure(message)
    }

    func fatal(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .fatal, date: .now, message: message, file: file, function: function, line: line))
        fatalError(message)
    }

    // MARK: - Log Errors
    func warn(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .warn, date: .now, message: error.errorMessage, file: file, function: function, line: line))
    }

    func error(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .error, date: .now, message: error.errorMessage, file: file, function: function, line: line))
    }

    func assertion(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .assertion, date: .now, message: error.errorMessage, file: file, function: function, line: line))
        assertionFailure(error.errorMessage)
    }

    func fatal(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        log(.init(level: .fatal, date: .now, message: error.errorMessage, file: file, function: function, line: line))
        fatalError(error.errorMessage)
    }
}

class Logger: Logging {
    static let shared = Logger()
    private var appenders: [LogAppender] = []
    private let queue = DispatchQueue(label: "logging.queue")

    init() {
        appenders.append(StdOutAppender())
    }

    // MARK: - Appender functions

    func add(appender: LogAppender) {
        appenders.append(appender)
    }

    // MARK: - Log Messages

    func log(_ message: LogMessage) {
        queue.async {
            self.appenders.forEach { appender in
                appender.log(message: message)
            }
        }
    }
}

extension Error {
    var errorMessage: String {
        if let localizedError = self as? LocalizedError {
            if let description = localizedError.errorDescription {
                return description
            }
        }
        return "\(self)"
    }
}

enum LogLevel {
    case trace
    case debug
    case info
    case warn
    case error
    case assertion
    case fatal

    var string: String {
        switch self {
        case .trace:
            return "TRACE"
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .warn:
            return "WARN"
        case .error:
            return "ERROR"
        case .assertion:
            return "ASSERTION"
        case .fatal:
            return "FATAL"
        }
    }

    var sortValue: Int {
        switch self {
        case .trace:
            return 0
        case .debug:
            return 1
        case .info:
            return 2
        case .warn:
            return 3
        case .error:
            return 4
        case .assertion:
            return 5
        case .fatal:
            return 6
        }
    }
}

func <(left: LogLevel, right: LogLevel) -> Bool { left.sortValue < right.sortValue }
func <=(left: LogLevel, right: LogLevel) -> Bool { left.sortValue <= right.sortValue }
func >(left: LogLevel, right: LogLevel) -> Bool { left.sortValue > right.sortValue }
func >=(left: LogLevel, right: LogLevel) -> Bool { left.sortValue >= right.sortValue }
func ==(left: LogLevel, right: LogLevel) -> Bool { left.sortValue == right.sortValue }

struct LogMessage {
    let level: LogLevel
    let date: Date
    let message: String
    let file: String
    let function: String
    let line: Int

    var shortFile: String { URL(fileURLWithPath: file).lastPathComponent }
}

protocol LogAppender {
    func log(message: LogMessage)
}

struct StdOutAppender: LogAppender {

    func log(message: LogMessage) {
        let dateString = Constants.dateFormatter.string(from: message.date)
        print("[\(dateString)][\(message.level.string)][\(message.shortFile)#\(message.line)(\(message.function)]: \(message.message)")
    }

    struct Constants {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YYYY-HH:mm:ss.SSS"
            return formatter
        }()
    }

}
