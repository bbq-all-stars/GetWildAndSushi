//
//  ViewController.swift
//  GetWildAndSushi
//
//  Created by Shun Tabata on 2016/12/22.
//  Copyright © 2016年 Shun Tabata. All rights reserved.
//

import UIKit
import WatchConnectivity
import YoutubePlayer_in_WKWebView

class ViewController: UIViewController {
    let player = WKYTPlayerView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(player)
        
        player.load(withVideoId: "LgBxze0ye94")
        
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        
    }
}

extension ViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard let get = message["Get"] as? String else {
            return
        }
        if get == "Wild" {
            player.playVideo()
        } else if get == "Sushi" {
            player.pauseVideo()
        }
    }
}
