//
//  GameViewController.swift
//  Latajaca Wikusia iOS
//
//  Created by Wiktoria Jasińska on 25/03/2024.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
          super.viewDidLoad()
          
          // Utwórz widok SpriteKit
          let skView = SKView(frame: view.frame)
          view.addSubview(skView)

          // Utwórz i dodaj scenę do widoku
          let scene = GameScene(size: view.bounds.size)
          scene.scaleMode = .aspectFill
          skView.presentScene(scene)
      }
}
