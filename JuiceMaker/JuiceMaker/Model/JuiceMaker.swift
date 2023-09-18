//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

// 쥬스 메이커 타입
struct JuiceMaker {
  let store = FruitStore.shared
  
  enum Juice: Int {
    case strawberry
    case banana
    case kiwi
    case pineapple
    case strawberryBanana
    case mango
    case mangoKiwi
  }
  
  func makeJuice(type: Int, juiceName: String) -> String {
    do {
      switch type {
      case Juice.strawberry.rawValue:
        if try store.checkInventory(fruitName: .strawberry, num: 16) {
          store.subtract(fruitName: .strawberry, num: 16)
        }
      case Juice.banana.rawValue:
        if try store.checkInventory(fruitName: .banana, num: 2) {
          store.subtract(fruitName: .banana, num: 2)
        }
      case Juice.kiwi.rawValue:
        if try store.checkInventory(fruitName: .kiwi, num: 3) {
          store.subtract(fruitName: .kiwi, num: 3)
        }
      case Juice.pineapple.rawValue:
        if try store.checkInventory(fruitName: .pineapple, num: 2) {
          store.subtract(fruitName: .pineapple, num: 2)
        }
      case Juice.strawberryBanana.rawValue:
        let checkOne = try store.checkInventory(fruitName: .strawberry, num: 10)
        let checkTwo = try store.checkInventory(fruitName: .banana, num: 1)
        if checkOne && checkTwo {
          store.subtract(fruitName: .strawberry, num: 10)
          store.subtract(fruitName: .banana, num: 1)
        }
      case Juice.mango.rawValue:
        if try store.checkInventory(fruitName: .mango, num: 3) {
          store.subtract(fruitName: .mango, num: 3)
        }
      case Juice.mangoKiwi.rawValue:
        let checkOne = try store.checkInventory(fruitName: .mango, num: 2)
        let checkTwo = try store.checkInventory(fruitName: .kiwi, num: 1)
        if checkOne && checkTwo {
          store.subtract(fruitName: .mango, num: 2)
          store.subtract(fruitName: .kiwi, num: 1)
        }
      default:
        return "잘못된 주문입니다."
      }
    } catch FruitStoreError.outOfStock {
      return "재료가 모자라요. 재고를 수정할까요?"
    } catch let error {
      return  "또 다른 에러 발생 \(error)"
    }
    return "\(juiceName) 나왔습니다! 맛있게 드세요!"
  }
}
