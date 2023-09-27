//
//  EditStoreViewController.swift
//  JuiceMaker
//
//  Created by YEJI on 2023/09/19.
//

import UIKit

final class EditStoreViewController: UIViewController {
  
  weak var delegate: DismissEditStoreViewDelegate?
  
  private let store = FruitStore.shared
  
  @IBOutlet private var numberLabelCollection: [UILabel]!
  
  @IBOutlet weak private var strawberryNumberLabel: UILabel!
  @IBOutlet weak private var bananaNumberLabel: UILabel!
  @IBOutlet weak private var pineappleNumberLabel: UILabel!
  @IBOutlet weak private var kiwiNumberLabel: UILabel!
  @IBOutlet weak private var mangoNumberLabel: UILabel!
  
  @IBOutlet weak private var strawberryStepper: UIStepper!
  @IBOutlet weak private var bananaStepper: UIStepper!
  @IBOutlet weak private var pineappleStepper: UIStepper!
  @IBOutlet weak private var kiwiStepper: UIStepper!
  @IBOutlet weak private var mangoStepper: UIStepper!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNumberLabel()
    setMinimumValue()
  }
  
  private func setNumberLabel() {
    for numberLabel in numberLabelCollection {
      guard let currentFruitName = Fruit(rawValue: numberLabel.tag) else { return }
      numberLabel.text = store.getNum(fruitName: currentFruitName).description
    }
  }
  
  private func setMinimumValue() {
    let fruitStepperList: [UILabel: UIStepper] = [strawberryNumberLabel: strawberryStepper, bananaNumberLabel: bananaStepper, pineappleNumberLabel: pineappleStepper, kiwiNumberLabel: kiwiStepper, mangoNumberLabel: mangoStepper]
    
    for (fruitLabel, fruitStepper) in fruitStepperList {
      guard let stringFruitValue = fruitLabel.text else { return }
      guard let doubleFruitValue = Double(stringFruitValue) else { return }
      fruitStepper.minimumValue = -doubleFruitValue
    }
  }
  
  @IBAction private func dismissButtonTapped(_ sender: UIButton) {
    for numberLabel in numberLabelCollection {
      guard let stringNumberValue = numberLabel.text else { return }
      guard let currentFruitValue = Int(stringNumberValue) else { return }
      guard let currentFruitName = Fruit(rawValue: numberLabel.tag) else { return }
      store.update(fruitName: currentFruitName, number: currentFruitValue)
    }
    
    self.delegate?.updateData()
    self.dismiss(animated: true)
  }
  
  @IBAction private func stepperButtonTapped(_ sender: UIStepper) {
    guard let currentFruitName = Fruit(rawValue: sender.tag) else { return }
    let changeNumber = store.getNum(fruitName: currentFruitName) + Int(sender.value)
    
    for numberLabel in numberLabelCollection {
      if numberLabel.tag == sender.tag {
        numberLabel.text = changeNumber.description
      }
    }
  }
}
