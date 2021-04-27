//
//  Lumberjack.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 26/04/2021.
//

import Foundation
import CocoaLumberjack

/// Global constant to access logs from everywhere.
let log = Lumberjack.self

/// Structure for accessing Lumberack loging.
struct Lumberjack {
    
    /// Configure Lumberjack.
    static func configureLogs() {
        // Configure file logging.
        let fileLogger = DDFileLogger()
        fileLogger.logFormatter = LumberjackFormatter()
        DDLog.sharedInstance.add(fileLogger)
        // Print logs location.
        print("Log files directory: \(fileLogger.logFileManager.logsDirectory)")
        
        // Configure console logging.
        let consoleLogger = DDOSLogger.sharedInstance
        consoleLogger.logFormatter = LumberjackFormatter()
        DDLog.sharedInstance.add(consoleLogger)
    }
    
    /// Log an error.
    static func error(_ message: String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line) {
        
        let message = DDLogMessage(message: "ERROR: \(message)",
                                   level: .error,
                                   flag: .error,
                                   context: 0,
                                   file: String(describing: file),
                                   function: String(describing: function),
                                   line: line,
                                   tag: nil,
                                   options: [.copyFile, .copyFunction],
                                   timestamp: nil)
       
        DDLog.sharedInstance.log(asynchronous: true, message: message)
    }
    
    /// Log info.
    static func info(_ message: String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line) {
        
        let message = DDLogMessage(message: "INFO: \(message)",
                                   level: .info,
                                   flag: .info,
                                   context: 0,
                                   file: String(describing: file),
                                   function: String(describing: function),
                                   line: line,
                                   tag: nil,
                                   options: [.copyFile, .copyFunction],
                                   timestamp: nil)
       
        DDLog.sharedInstance.log(asynchronous: true, message: message)
    }
}

/// Class for formatting logs.
private class LumberjackFormatter: NSObject, DDLogFormatter {

    /// Custom formatting.
    func format(message logMessage: DDLogMessage) -> String? {
        let components: [String] = [
            "\(logMessage.timestamp)",
            "\(logMessage.fileName)(Line: \(logMessage.line.description), Function: \(logMessage.function ?? ""))",
            "\(logMessage.queueLabel)(\(logMessage.threadID))",
            logMessage.message]
        return components.joined(separator: " | ")
    }
}
