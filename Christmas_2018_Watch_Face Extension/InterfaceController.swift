//
//  InterfaceController.swift
//  Christmas_2018_Watch_Face Extension
//
//  Created by Michal on 04/12/2018.
//  Copyright © 2018 Michal Tynior. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var sceneView: WKInterfaceSKScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let watchFace = ChristmasPaperTown()
        watchFace.scaleMode = .aspectFill
        
        sceneView.presentScene(watchFace)
        sceneView.preferredFramesPerSecond = 30
    }
    
    override func didAppear() {
        removeWatchOSTimeLabel()
    }
    
}

extension InterfaceController {
    
    private func removeWatchOSTimeLabel() {
        guard let fullScreenViewType = NSClassFromString("SPFullScreenView") else {
            return
        }
        
        guard let viewControllers = (((NSClassFromString("UIApplication")?
            .value(forKey: "sharedApplication") as? NSObject)?
            .value(forKey: "keyWindow") as? NSObject)?
            .value(forKey: "rootViewController") as? NSObject)?
            .value(forKey: "viewControllers") as? [NSObject] else {
                return
        }
        
        viewControllers.forEach { controller in
            guard let views = (controller.value(forKey: "view") as? NSObject)?.value(forKey: "subviews") as? [NSObject] else {
                return
            }
            
            views.forEach { view in
                if view.isKind(of: fullScreenViewType) {
                    ((view.value(forKey: "timeLabel") as? NSObject)?
                        .value(forKey: "layer") as? NSObject)?
                        .perform(NSSelectorFromString("setOpacity:"), with: CGFloat(0))
                }
            }
            
        }
        
    }
    
}
