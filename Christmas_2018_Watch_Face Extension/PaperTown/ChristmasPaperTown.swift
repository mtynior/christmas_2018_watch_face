//
//  ChristmasPaperTown.swift
//  Christmas_2018_Watch_Face Extension
//
//  Created by Michal on 04/12/2018.
//  Copyright © 2018 Michal Tynior. All rights reserved.
//

import Foundation
import SpriteKit

public final class ChristmasPaperTown: SKScene {
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    private let mainColor = UIColor(red: 0.745, green: 0.117, blue: 0.176, alpha: 1.00)
    
    private let fontName = "DancingScript-Bold"
    
    private let textureAtlas = SKTextureAtlas(named: "ChristmasPaperTown")
    
    private var faceNode: SKNode {
        return childNode(withName: "Face")!
    }
    
    private var timeLabelNode: SKLabelNode {
        return faceNode.childNode(withName: "Time") as! SKLabelNode
    }
    
    private var dateLabelNode: SKLabelNode {
        return faceNode.childNode(withName: "Date") as! SKLabelNode
    }
    
    private lazy var snowEmitter: SKEmitterNode = {
        let emitter = SKEmitterNode(fileNamed: "SnowParticle.sks")!
        emitter.particleTexture = textureAtlas.textureNamed("snowflake")
        return emitter
    }()
    
    public override convenience init() {
        self.init(fileNamed: "ChristmasPaperTown")!
    }
    
    public override func sceneDidLoad() {
        let townNode = faceNode.childNode(withName: "Town") as! SKSpriteNode
        let santaNode = faceNode.childNode(withName: "Santa") as! SKSpriteNode
        let backgroundNode = faceNode.childNode(withName: "Background") as! SKSpriteNode
        
        townNode.texture = textureAtlas.textureNamed("town")
        santaNode.texture = textureAtlas.textureNamed("santa")
        
        backgroundNode.color = mainColor
        timeLabelNode.fontColor = mainColor
        timeLabelNode.fontName = fontName
        dateLabelNode.fontColor = mainColor
        dateLabelNode.fontName = fontName
        
        snowEmitter.targetNode = backgroundNode
        snowEmitter.position.y = (size.height / 1.75)
        addChild(snowEmitter)
    }
    
    public override func update(_ currentTime: TimeInterval) {
        updateTime()
    }
    
    private func updateTime() {
        let now = Date()
        let time = timeFormatter.string(from: now)
        timeLabelNode.text = time
        dateLabelNode.text = dateFormatter.string(from: now)
    }
    
}
