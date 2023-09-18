//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
  
  let juiceMaker = JuiceMaker()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func juiceOrderButtonTapped(_ sender: UIButton) {
    let tag = sender.tag
    juiceMaker.makeJuice(type: tag)
  }
  
}

