//
//  ObstacleNode.swift
//  Latajaca Wikusia iOS
//
//  Created by Wiktoria Jasińska on 25/03/2024.
//

import Foundation
import SpriteKit

class ObstacleNode: SKSpriteNode {
    
    // Inicjalizacja przeszkody
    init() {
        let texture = SKTexture(imageNamed: "obstacleImage") // Załaduj teksturę przeszkody
        super.init(texture: texture, color: .clear, size: texture.size()) // Wywołaj inicjalizator klasy bazowej
        setupObstacle() // Wywołaj funkcję konfiguracji przeszkody
    }

    // Konieczna inicjalizacja wymagana przez dziedziczenie po klasie SKSpriteNode
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct PhysicsCategory {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1
        static let Obstacle: UInt32 = 0b10
        static let Ground: UInt32 = 0b100
    }

    // Konfiguracja przeszkody
    private func setupObstacle() {
        // Ustaw pozycję początkową przeszkody
        self.position = CGPoint(x: 0, y: 0) // Możesz dostosować pozycję, aby przeszkody pojawiały się na ekranie w odpowiednim miejscu

        // Dodaj fizykę do przeszkody
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size) // Ustaw kształt fizyki na prostokąt o wymiarach przeszkody
        self.physicsBody?.isDynamic = false // Ustaw dynamiczność fizyki na false, aby przeszkody nie reagowały na siły fizyczne
        self.physicsBody?.affectedByGravity = false // Wyłącz wpływ grawitacji na przeszkody
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle // Ustaw kategorię fizyczną przeszkód
        self.physicsBody?.collisionBitMask = PhysicsCategory.None // Ustaw, z czym przeszkody mogą kolidować (w tym przypadku niczym)
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player // Ustaw, z czym przeszkody mogą kolidować w celu wykrywania kontaktu z graczem
    }


}
