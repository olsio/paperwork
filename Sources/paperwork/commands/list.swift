import ArgumentParser
import Foundation
import ImageCaptureCore
import Logging

extension paperwork {
    
    struct List: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "List available scanners.")
        
        
        mutating func run() {
            print("list")
            
            DispatchQueue.global(qos: .utility).async {
                let logger = Logger(label: "io.ols.paperwork.main")
                let browser = ScannerBrowser(logger: logger)
                let scanners = browser.scan()
                print("\(scanners)")
                
                print("Done")
                DispatchQueue.main.async {
                    CFRunLoopStop(CFRunLoopGetCurrent())
                }
            }
        }
    }
}
