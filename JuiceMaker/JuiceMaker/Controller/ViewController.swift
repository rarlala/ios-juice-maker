//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController, UINavigationControllerDelegate {
  
  private let juiceMaker = JuiceMaker()
  
  @IBOutlet weak private var strawberryNumberLabel: UILabel!
  @IBOutlet weak private var bananaNumberLabel: UILabel!
  @IBOutlet weak private var pineappleNumberLabel: UILabel!
  @IBOutlet weak private var kiwiNumberLabel: UILabel!
  @IBOutlet weak private var mangoNumberLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNumberLabel()
    NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("TestNotification"), object: nil)
  }
  
  
  
  @IBAction private func juiceOrderButtonTapped(_ sender: UIButton) {
    guard let buttonName = sender.titleLabel?.text else { return }
    let juiceName = buttonName.split(separator: " ")[0]
    let message = juiceMaker.createJuice(type: String(juiceName))
    showAlert(message: message)
    setNumberLabel()
  }
  
  private func showAlert(message: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
    let outOfStock = (message == "재료가 모자라요. 재고를 수정할까요?")
    
    if outOfStock {
      alert.addAction(UIAlertAction(title: "예", style: UIAlertAction.Style.default, handler: { [self] _ in
        guard let editStoreView = self.storyboard?.instantiateViewController(identifier: "EditStoreView") as? EditStoreViewController else { return }
        editStoreView.modalTransitionStyle = .coverVertical
        editStoreView.modalPresentationStyle = .automatic
        performSegue(withIdentifier: "EditStoreViewSegue", sender: nil)
      }))
    }
    
    alert.addAction(UIAlertAction(title: outOfStock ? "아니오" : "확인", style: UIAlertAction.Style.cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc private func updateData(_ notification: Notification) {
    setNumberLabel()
  }
  
  private func setNumberLabel() {
    strawberryNumberLabel.text = String(juiceMaker.store.getNum(fruitName: Fruit.strawberry))
    bananaNumberLabel.text = String(juiceMaker.store.getNum(fruitName: Fruit.banana))
    pineappleNumberLabel.text = String(juiceMaker.store.getNum(fruitName: Fruit.pineapple))
    kiwiNumberLabel.text = String(juiceMaker.store.getNum(fruitName: Fruit.kiwi))
    mangoNumberLabel.text = String(juiceMaker.store.getNum(fruitName: Fruit.mango))
  }
}
