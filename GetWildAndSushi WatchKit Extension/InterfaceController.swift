//
//  InterfaceController.swift
//  GetWildAndSushi WatchKit Extension
//
//  Created by Shun Tabata on 2016/12/22.
//  Copyright © 2016年 Shun Tabata. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    var isRotate = false
    @IBOutlet var sushi: WKInterfaceImage!
    @IBAction func tap(_ sender: Any) {
        if isRotate {
            sushi.stopAnimating()
            isRotate = false
            send()
        } else {
            sushi.startAnimating()
            isRotate = true
            send()
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        sushi.setImageNamed("sushi")
        
        sushi.startAnimatingWithImages(in: NSRange(location: 1, length: 36), duration: 1, repeatCount: -1)
        sushi.stopAnimating()
    }
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func send(){
        if (WCSession.default().isReachable) {
            if isRotate {
                WCSession.default().sendMessage(["Get": "Wild"], replyHandler: {_ in}, errorHandler: nil)
            } else {
                WCSession.default().sendMessage(["Get": "Sushi"], replyHandler: {_ in}, errorHandler: nil)
            }
        }
    }
}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
