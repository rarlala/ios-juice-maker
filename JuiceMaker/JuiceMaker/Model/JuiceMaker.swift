//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

// 쥬스 메이커 타입
struct JuiceMaker {

  let store = FruitStore.shared
  
  enum Juice: String {
    case strawberry = "딸기쥬스"
    case banana = "바나나쥬스"
    case kiwi = "키위쥬스"
    case pineapple = "파인애플쥬스"
    case strawberryBanana = "딸바쥬스"
    case mango = "망고쥬스"
    case mangoKiwi = "망키쥬스"
    
    var recipe: Dictionary<Fruit, Int> {
      switch self {
      case .strawberry: return [.strawberry: 16]
      case .banana: return [.banana: 2]
      case .kiwi: return [.kiwi: 3]
      case .pineapple: return [.pineapple: 2]
      case .strawberryBanana: return [.strawberry: 10, .banana: 1]
      case .mango: return [.mango: 3]
      case .mangoKiwi: return [.mango: 2, .kiwi: 1]
      }
    }
  }
  
  func createJuice(type: String) -> String {
    if checkAvailableJuice(type: type) {
      makeJuice(type: type)
      return "\(type) 나왔습니다! 맛있게 드세요!"
    } else {
      return "재료가 모자라요. 재고를 수정할까요?"
    }
  }
  
  private func checkAvailableJuice(type: String) -> Bool {
    do {
      guard let juiceType = Juice(rawValue: type) else { return false }
      let recipe = juiceType.recipe
      for (fruit, number) in recipe {
        try store.checkInventory(fruitName: fruit, number: number)
      }
    } catch let error {
      if error as! FruitStoreError == FruitStoreError.outOfStock {
        return false
      }
    }
    return true
  }
  
  private func makeJuice(type: String) {
    guard let juiceType = Juice(rawValue: type) else { return }
    let recipe = juiceType.recipe
    for (fruit, number) in recipe {
      store.subtract(fruitName: fruit, number: number)
    }
  }
}
