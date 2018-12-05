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
    
    private let calendar = Calendar.current
    
    private let mainColor = UIColor(red: 0.745, green: 0.117, blue: 0.176, alpha: 1.00)
    
    private let fontName = "DancingScript-Bold"
    
    private let textureAtlas = SKTextureAtlas(named: "ChristmasPaperTown")
    
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
        let emitter = SKEmitterNode(fileNamed: "SnowEmitter.sks")!
        emitter.particleTexture = textureAtlas.textureNamed("snowflake")
        return emitter
    }()
    
    private lazy var presentEmitter: SKEmitterNode = {
        let emitter = SKEmitterNode(fileNamed: "PresentEmitter.sks")!
        emitter.particleTexture = textureAtlas.textureNamed("present")
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
        snowEmitter.zPosition = -2
        addChild(snowEmitter)

        presentEmitter.targetNode = backgroundNode
        presentEmitter.position.x = santaNode.position.x + (santaNode.size.width / 2.25)
        presentEmitter.position.y = santaNode.position.y
        presentEmitter.zPosition = -2
        presentEmitter.particleBirthRate = 0
        addChild(presentEmitter)
    }
    
    public override func update(_ currentTime: TimeInterval) {
        updateTime()
    }
    
    private func updateTime() {
        let now = Date()
        let time = timeFormatter.string(from: now)
        timeLabelNode.text = time
        dateLabelNode.text = dateFormatter.string(from: now)
        
        // Happy Holidays!
        let components = calendar.dateComponents([.month, .day], from: now)
        let dayOfMonth = components.day ?? 0
        let month = components.month ?? 0
        
        let isChristmasTime = (month == 12) && (24...26 ~= dayOfMonth)
        presentEmitter.particleBirthRate = isChristmasTime ? 1 : 0
    }
    
}
