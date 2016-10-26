//
//  LogManager.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 25/10/2016.
//  Copyright © 2016 Gytenis Mikulėnas 
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

import UIKit
import CocoaLumberjack

// MARK: TODO
// Check: https://github.com/CocoaLumberjack/CocoaLumberjack/issues/794

/*DDLog.add(<#T##logger: DDLogger!##DDLogger!#>)
 DDLog.addLogger(DDTTYLogger.sharedInstance()) // TTY = Xcode console
 DDLog.addLogger(DDASLLogger.sharedInstance()) // ASL = Apple System Logs
 
 let fileLogger: DDFileLogger = DDFileLogger() // File Logger
 fileLogger.rollingFrequency = 60*60*24  // 24 hours
 fileLogger.logFileManager.maximumNumberOfLogFiles = 7
 DDLog.addLogger(fileLogger)*/

// MARK: Convenience functions

func DDLogVerbose(log: String) {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.logManager.verbose(log: log)
}

func DDLogDebug(log: String) {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.logManager.debug(log: log)
}

func DDLogInfo(log: String) {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.logManager.info(log: log)
}

func DDLogWarn(log: String) {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.logManager.warn(log: log)
}

func DDLogError(log: String) {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.logManager.error(log: log)
}

// TODO:
class LogManager: LogManagerProtocol {

    init() {
        
        // Default setup
        // Color support for Xcode7. Not working for Xcode 8 because Apple refactoring plugins to be available via extensions
        /*
        #if TARGET_IPHONE_SIMULATOR
            // Sends log statements to Xcode console - if available
            setenv("XcodeColors", "YES", 1);
        #endif*/
        
        let logLevel = self.convertedLogLevel(logLevel: self.logLevel)
        
        // Add device logging
        DDLog.add(DDASLLogger.sharedInstance(), with: logLevel)
        
        #if DEBUG
        
            // Add Xcode console logging
            DDLog.add(DDTTYLogger.sharedInstance(), with: logLevel)
            //[DDLog addLogger:[GMCustomLogger sharedInstance]];
            
            // Enable Colors
            DDTTYLogger.sharedInstance().colorsEnabled = true
            DDTTYLogger.sharedInstance().setForegroundColor(UIColor.red, backgroundColor: nil, for: DDLogFlag.error)
            DDTTYLogger.sharedInstance().setForegroundColor(UIColor.orange, backgroundColor: nil, for: DDLogFlag.warning)
            DDTTYLogger.sharedInstance().setForegroundColor(UIColor.magenta, backgroundColor: nil, for: DDLogFlag.info)
            DDTTYLogger.sharedInstance().setForegroundColor(UIColor.blue, backgroundColor: nil, for: DDLogFlag.debug)
            DDTTYLogger.sharedInstance().setForegroundColor(UIColor.green, backgroundColor: nil, for: DDLogFlag.verbose)
        #endif
    }
    
    // LogManagerProtocol
    
    lazy var logLevel: LogLevelType = {
        
        return LogLevelType.debug
    }()
    
    func set(logLevel: LogLevelType) {
        
        let logLevel: DDLogLevel = self.convertedLogLevel(logLevel: logLevel)

        // Add device logging
        DDLog.add(DDASLLogger.sharedInstance(), with: logLevel)
        
        #if DEBUG
            
            // Add Xcode console logging
            DDLog.add(DDTTYLogger.sharedInstance(), with: logLevel)
            
        #endif
        
        DDLogInfo(log: "LogManager: LogLevel set to " + stringify(object: self.logLevel.rawValue))
    }
    
    func verbose(log: String) {
        
        DDLogVerbose(log)
    }
    
    func debug(log: String) {
        
        DDLogDebug(log)
    }
    
    func info(log: String) {
        
        DDLogInfo(log)
    }
    
    func warn(log: String) {
        
        DDLogWarn(log)
    }
    
    func error(log: String) {
        
        DDLogError(log)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal func convertedLogLevel(logLevel: LogLevelType) -> DDLogLevel {
        
        var convertedLogLevel: DDLogLevel = DDLogLevel.off
        
        switch (logLevel) {
            
        case .error:
            
            convertedLogLevel = DDLogLevel.error
            
        case .warning:
            
            convertedLogLevel = DDLogLevel.warning
            
        case .info:
            
            convertedLogLevel = DDLogLevel.info
            
        case .debug:
            
            convertedLogLevel = DDLogLevel.debug
            break;
            
        case .verbose:
            
            convertedLogLevel = DDLogLevel.verbose
            break;
            
        case .all:
            
            convertedLogLevel = DDLogLevel.all
            break;
            
        default:
            
            convertedLogLevel = DDLogLevel.off
            break;
        }
        
        return convertedLogLevel;
    }
}
