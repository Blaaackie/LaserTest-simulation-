//
//  GameScene.swift
//  LazerMan
//
//  Created by Tye Blackie on 2017-09-05.
//  Copyright © 2017 Tye Blackie. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var Hero = SKSpriteNode(imageNamed: "SoccerBall")
    var background = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        
        let border = self.childNode(withName: "BorderSprite")
        
        Hero.size = CGSize(width: 200, height: 200)
        Hero.position = CGPoint(x: 0, y: -600)
        Hero.zPosition = 2
        
        self.addChild(Hero)
        
        createBackgrounds()
        
        
        let borderFrame = SKPhysicsBody(edgeLoopFrom: (border?.frame)!)
        borderFrame.friction = 0
        borderFrame.restitution = 1
        self.physicsBody = borderFrame
        
        
//        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
//        border.friction = 0
//        border.restitution = 1
//        self.physicsBody = border
        
//        let rightBorder = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), to: CGPoint(x: self.frame.width / 2, y: -(self.frame.height / 2)))
//        rightBorder.friction = 0
//        self.physicsBody = rightBorder
//        
//        let leftBorder = SKPhysicsBody(edgeFrom: CGPoint(x: -(self.frame.width / 2), y: self.frame.height / 2), to: CGPoint(x: -(self.frame.width / 2), y: -(self.frame.height / 2)))
//        leftBorder.friction = 0
//        self.physicsBody = leftBorder
    }
    
    
    
    
    
    
    override func update(_ currentTime: CFTimeInterval) {
        moveBackgrounds()
    }
    
    func createBackgrounds() {
        
        for i in 0...3 {
            
            let background = SKSpriteNode(imageNamed: "MetalBackground")
            background.name = "Background"
            background.size = CGSize(width: (self.scene?.size.width)!, height: 1000)
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: 0, y: CGFloat(i) * background.size.height)
            background.zPosition = 0
            
            self.addChild(background)
        }
    }
    
    func moveBackgrounds() {
        
        self.enumerateChildNodes(withName:"Background") { (node, error) in
            
            node.position.y -= 1
            
            if node.position.y < -((self.scene?.size.height)!) {
                
                node.position.y += (self.scene?.size.height)! * 3
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.location(in: self)
            
            var SmallBall = SKSpriteNode(imageNamed: "SoccerBall")
            SmallBall.position = Hero.position
            SmallBall.size = CGSize(width: 30, height: 30)
            SmallBall.physicsBody = SKPhysicsBody(circleOfRadius: SmallBall.size.width / 2)
            SmallBall.physicsBody?.affectedByGravity = true
            SmallBall.zPosition = 1
            
            self.addChild(SmallBall)
            
            
        var dx = CGFloat(location.x - Hero.position.x)
        var dy = CGFloat(location.y - Hero.position.y)
            
            let magnitude = sqrt(dx * dx + dy * dy)
            
            dx /= magnitude
            dy /= magnitude
            
            let vector = CGVector(dx: 60.0 * dx, dy: 60.0 * dy)
            
            
        SmallBall.physicsBody?.applyImpulse(vector)
            
            
            
        }
    }
}
