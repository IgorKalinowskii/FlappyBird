//
//  PlayerNode.swift
//  Latajaca Wikusia iOS
//
//  Created by Wiktoria Jasińska on 25/03/2024.
//

import Foundation
import SpriteKit

class PlayerNode: SKSpriteNode {
    
    struct PhysicsCategory {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1 // 1
        static let Obstacle: UInt32 = 0b10 // 2
        static let Ground: UInt32 = 0b100 // 4
        // Dodaj inne kategorie fizyczne, jeśli są potrzebne
    }


    // Inicjalizacja postaci gracza
    init() {
        let texture = SKTexture(imageNamed: "ptaszek") // Załaduj teksturę postaci gracza
        super.init(texture: texture, color: .clear, size: texture.size()) // Wywołaj inicjalizator klasy bazowej
        setupPlayer() // Wywołaj funkcję konfiguracji postaci gracza
    }

    // Konieczna inicjalizacja niezbędna do dziedziczenia po klasie SKSpriteNode
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Konfiguracja postaci gracza
    private func setupPlayer() {
        // Dodaj tutaj odpowiednie ustawienia postaci gracza, np. pozycję początkową, fizykę, animacje itp.
        // Ustaw pozycję początkową postaci gracza
            self.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)

            // Dodaj fizykę do postaci gracza
            self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.categoryBitMask = PhysicsCategory.Player
            self.physicsBody?.collisionBitMask = PhysicsCategory.Obstacle
            self.physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Ground
    }
}

