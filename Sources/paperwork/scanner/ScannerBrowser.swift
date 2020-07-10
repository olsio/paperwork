import Foundation
import ImageCaptureCore
import Logging

class ScannerBrowser: NSObject, ICDeviceBrowserDelegate {
    private let logger: Logger
    private let deviceBrowser = ICDeviceBrowser()
    var scanners = [ICDevice]()
    var semaphore = DispatchSemaphore(value: 0)
    
    init(logger: Logger) {
        self.logger = logger
        super.init()
        
        deviceBrowser.delegate = self
        let mask = ICDeviceTypeMask(rawValue:
            ICDeviceTypeMask.scanner.rawValue |
                ICDeviceLocationTypeMask.local.rawValue |
                ICDeviceLocationTypeMask.bonjour.rawValue |
                ICDeviceLocationTypeMask.shared.rawValue)
        deviceBrowser.browsedDeviceTypeMask = mask!
    }
    
    func scan() -> [ICDevice] {
        deviceBrowser.start()
        _ = semaphore.wait(timeout: .now() + 5)
        return scanners
    }
    
    func deviceBrowser(_ browser: ICDeviceBrowser, didAdd device: ICDevice, moreComing: Bool) {
        logger.info("* \(device.name ?? "[Nameless Device]")")
        scanners.append(device)
        
        if (!moreComing) {
            logger.info("Stopping")
            deviceBrowser.stop()
            semaphore.signal()
        }
    }
    
    func deviceBrowser(_ browser: ICDeviceBrowser, didRemove device: ICDevice, moreGoing: Bool) {
    }
}

