//
//  EditStoreViewController.swift
//  JuiceMaker
//
//  Created by YEJI on 2023/09/19.
//

import UIKit

protocol EditStoreDelegate {
  func sendData(str: String)
}

class EditStoreViewController: UIViewController, EditStoreDelegate {
  
  @IBOutlet weak var strLable: UILabel!
  var strww: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let mainView = self.storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController else { return }
    mainView.delegate = self
    
    strLable.text = strww
  }
  
  @IBAction func dismissButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  func sendData(str: String) {
    print("edit store delegate send data \(str)")
    strww = str
  }
}
