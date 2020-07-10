import ArgumentParser
import Foundation

struct paperwork: ParsableCommand {
    
   static var configuration = CommandConfiguration(
          // Optional abstracts and discussions are used for help output.
          abstract: "A utility for performing maths.",

          // Commands can define a version for automatic '--version' support.
          version: "1.0.0",
          
          subcommands: [List.self],
          defaultSubcommand: List.self)          
}

paperwork.main()
CFRunLoopRun()
