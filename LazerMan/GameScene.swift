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
    
    var Hero = SKSpriteNode(imageNamed: "Laser")
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


    }
    
    override func update(_ currentTime: CFTimeInterval) {
        
        moveBackgrounds()
        
        removeExessProjectiles()
        
    }
    
    func removeExessProjectiles() {
        
        for temp in self.children {
            if temp.name == "SmallBall" && temp.position.y < -600 {
                temp.removeFromParent()
                print(temp.position.y)
            }
        }
    }
    
    func createBackgrounds() {
        
        for i in 0...3 {
            
            let background = SKSpriteNode(imageNamed: "LaserTunnel")
            background.name = "Background"
            background.size = CGSize(width: (self.scene?.size.width)!, height: 1000)
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: 0, y: CGFloat(i) * background.size.height)
            background.zPosition = 0
            
            self.addChild(background)
        }
    }
    
    func moveBackgrounds() {
        
        self.enumerateChildNodes(withName:"Background")
        {
            (node, error) in
            
            node.position.y -= 3
            
            if node.position.y < -((self.scene?.size.height)!)
            {
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
            SmallBall.name = "SmallBall"
            
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
