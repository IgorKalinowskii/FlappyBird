//
//  GameLogic.swift
//  Latajaca Wikusia iOS
//
//  Created by Wiktoria Jasińska on 25/03/2024.
//

import Foundation
import SpriteKit

class GameLogic {
    
    // Referencja do sceny gry
    private weak var scene: GameScene?
    
    // Gracz
    private var player: SKSpriteNode!
    private let playerCategory: UInt32 = 0x1 << 0
    
    // Punkty
    private var scoreLabel: SKLabelNode!
    private var score = 0
    
    // Przeszkody
    private var obstacleTimer: Timer!
    private var obstacles = [SKSpriteNode]()
    private let obstacleCategory: UInt32 = 0x1 << 1
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    // Funkcja wywoływana po uruchomieniu sceny
    func startGame() {
        scene?.physicsWorld.contactDelegate = scene
        createPlayer()
        createScoreLabel()
        startObstacleTimer()
    }
    
    private func createPlayer() {
        player = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: scene?.frame.midX ?? 0, y: scene?.frame.midY ?? 0)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = obstacleCategory
        player.physicsBody?.collisionBitMask = 0
        scene?.addChild(player)
    }
    
    private func createScoreLabel() {
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: scene?.frame.midX ?? 0, y: scene?.frame.maxY ?? 0 - 100)
        scene?.addChild(scoreLabel)
    }
    
    private func startObstacleTimer() {
        obstacleTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(createObstacle), userInfo: nil, repeats: true)
    }
    
    @objc private func createObstacle() {
        let obstacleTexture = SKTexture(imageNamed: "przeszkoda.png")
        let obstacle = SKSpriteNode(texture: obstacleTexture)
        obstacle.position = CGPoint(x: scene?.frame.maxX ?? 0 + obstacle.size.width / 2, y: scene?.frame.midY ?? 0)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = obstacleCategory
        obstacle.physicsBody?.contactTestBitMask = playerCategory
        scene?.addChild(obstacle)
        obstacles.append(obstacle)
    }

    
    // Funkcja wywoływana co klatkę gry
    func update() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        for obstacle in obstacles {
            if obstacle.position.x < -(obstacle.size.width / 2) {
                obstacle.removeFromParent()
                if let index = obstacles.firstIndex(of: obstacle) {
                    obstacles.remove(at: index)
                }
            }
        }
    }
    
    // Funkcja wywoływana po kolizji z przeszkodą
    func endGame() {
        obstacleTimer.invalidate()
        // Dodaj kod, który wywoła ekran końcowy lub inny efekt końca gry
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Tutaj umieść logikę obsługi kolizji
        // np. sprawdzenie, czy dotknięto przeszkodę, zakończenie gry itp.
    }
}
