//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

// 과일 저장소 타입
class FruitStore {
  static let shared = FruitStore()
  
  private let initialValue = 10
  private var inventory = [Fruit.strawberry: 0, Fruit.pineapple: 0, Fruit.banana: 0, Fruit.kiwi: 0, Fruit.mango: 0]
  
  private init() {
    for fruitList in inventory {
      inventory.updateValue(initialValue, forKey: fruitList.key)
    }
  }
  
  func update(fruitName: Fruit, number: Int) {
    inventory.updateValue(number, forKey: fruitName)
  }
  
  func subtract(fruitName: Fruit, number: Int) {
    let currentNumber = getNum(fruitName: fruitName)
    let result = currentNumber - number
    inventory.updateValue(result, forKey: fruitName)
  }
  
  func getNum(fruitName: Fruit) -> Int {
    let currentNumber = inventory[fruitName] ?? 0
    return currentNumber
  }
  
  func checkInventory(fruitName: Fruit, number: Int) throws {
    let currentNumber = getNum(fruitName: fruitName)
    if currentNumber < number {
      throw FruitStoreError.outOfStock
    }
  }
}
