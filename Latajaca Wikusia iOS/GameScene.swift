//
//  GameScene.swift
//  Latajaca Wikusia iOS
//
//  Created by Wiktoria Jasińska on 25/03/2024.
//
import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var gameLogic: GameLogic!
    let playerCategory: UInt32 = 0x1 << 0
    let obstacleCategory: UInt32 = 0x1 << 1

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        physicsWorld.contactDelegate = self
        
        // Utwórz obraz postaci
        let playerTexture = SKTexture(imageNamed: "ptaszek2.png")
        player = SKSpriteNode(texture: playerTexture)
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)

        // Utwórz instancję GameLogic i przekaż referencję do tej sceny
        gameLogic = GameLogic(scene: self)
        gameLogic.startGame()
        
        // Dodaj przeszkody
        addObstacle()
        
        // Ustaw właściwości fizyki sceny
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
    }
    
    func addObstacle() {
        // Utwórz obraz przeszkody
        let obstacleTexture = SKTexture(imageNamed: "przeszkoda.png")
        let obstacle = SKSpriteNode(texture: obstacleTexture)
        obstacle.position = CGPoint(x: frame.midX + 200, y: frame.midY)
        addChild(obstacle)
        
        // Ustaw fizykę dla przeszkody
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = obstacleCategory
        obstacle.physicsBody?.contactTestBitMask = playerCategory
        obstacle.physicsBody?.collisionBitMask = 0
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // Sprawdź, czy doszło do kolizji między graczem a przeszkodą
        if collision == playerCategory | obstacleCategory {
            // Kolizja między graczem a przeszkodą
            // Tutaj możesz dodać kod do obsługi zdarzenia, na przykład zatrzymać grę, zaktualizować wynik itp.
            print("Kolizja między graczem a przeszkodą")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Aktualizacja gry
    }
}
