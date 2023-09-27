# ios-juice-maker

쥬스메이커 프로젝트 저장소입니다.

# 쥬스 메이커

쥬스를 주문하고, 과일의 재고를 관리할 수 있는 앱

<br/><br/>

## 작동 영상

<div style="display:flex; justify-content: 
            center;">
<img src="https://user-images.githubusercontent.com/48057629/270588866-f2609071-ba58-4e08-812f-815450813dda.gif" >    
</div>

<br/><br/>

## 시퀀스 다이어그램

<img src="https://user-images.githubusercontent.com/48057629/270911082-6d3c0095-3b0e-41ff-b9ed-c11314dc9492.png">

<br/><br/>

## 클래스 다이어그램

<img src="https://user-images.githubusercontent.com/48057629/270911076-b379e2e7-fda2-4384-bc7d-3a561ca14ac6.png">

<br/><br/>

## [STEP1](https://github.com/tasty-code/ios-juice-maker/pull/50)

### 구현 내용

- FruitStore.swift 파일에 과일의 재고를 관리하는 FruitStore 타입을 정의함
  - Singleton Pattern으로 구현
    - 과일의 재고를 관리하는 FruitStore Class가 단 하나의 인스턴스만 생성되어 관리되게 함
- FruitStore는 다음의 조건을 충족함
  - FruitStore가 관리하는 과일의 종류 : 딸기, 바나나, 파인애플, 키위, 망고
  - 각 과일의 초기 재고 : 10개
  - 각 과일의 수량 n개를 변경하는 기능이 있음
- JuiceMaker.swift 파일에 다음의 조건을 충족하는 JuiceMaker 타입을 정의함 - FruitStore의 과일을 사용해 과일쥬스를 제조할 수 있는 메서드 구현 - 딸기쥬스 : 딸기 16개 소모 - 바나나쥬스 : 바나나 2개 소모 - 키위쥬스 : 키위 3개 소모 - 파인애플 쥬스 : 파인애플 2개 소모 - 딸바쥬스 : 딸기 10개 + 바나나 1개 소모 - 망고 쥬스 : 망고 3개 소모 - 망고키위 쥬스 : 망고 2개 + 키위 1개 소모 - 과일의 재고가 부족하면 과일쥬스를 제조할 수 없는 메서드 구현 - 오류처리 구현 - JuiceMaker는 FruitStore를 소유하고 있음 - enum 내 dictionary를 넣어 중복되는 로직 수정
  <br/><br/>

## [STEP2](https://github.com/tasty-code/ios-juice-maker/pull/58)

### 구현 내용

- '재고 수정' 버튼을 터치하면 '재고 추가' 화면으로 이동
  - Modality로 연결함
- 각 주문 버튼 터치 시
  - 쥬스 재료의 재고가 있는 경우 : 쥬스 제조 후 “\*\*\* 쥬스 나왔습니다! 맛있게 드세요!” Alert 표시
  - 쥬스 재료의 재고가 없는 경우 : “재료가 모자라요. 재고를 수정할까요?” Alert 표시
    - ‘예' 선택시 재고수정 화면으로 이동
    - ‘아니오' 선택 시 Alert 닫기
  - 과일쥬스를 제조하여 과일의 재고가 변경되면 화면의 적절한 요소에 변경사항을 반영합니다.
- 이동 방식은 present 사용

<br/><br/>

## [STEP3](https://github.com/tasty-code/ios-juice-maker/pull/65)

### 구현 내용

- 화면 제목 '재고 추가' 및 '닫기' 버튼 구현
  - 닫기를 터치하면 이전화면으로 복귀
- 화면 진입시 과일의 현재 재고 수량 표시
- -, + 를 통한 재고 수정
- iPhone 12 외에 다른 시뮬레이터에서도 UI가 정상적으로 보일 수 있도록 오토레이아웃 적용

<br/><br/>

## 해당 프로젝트의 고민과 해결

- Singleton Pattern을 활용

  - FruitStore는 과일의 재고를 관리해야한다. 여러 JuiceMaker가 FruitStore의 인스턴스를 만들어도 단 하나의 인스턴스만 생성되게 만들고 싶었다. 그래서 Singleton Pattern으로 구현했다.

  ```swift
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
  ```

- enum 프로퍼타를 활용한 recipe 구현

  - 각 쥬스 클릭 시 필요한 레시피를 Switch로 각각 버튼에 따라 구현했었다. 찾아보니 enum의 property로 정의할 수 있어 해당 방식으로 변경해 적용했다.

  ```swift
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
  ```

- 화면 전환 및 화면 사이 데이터 공유 대한 학습
  - 재고 수정 화면을 어떤 방식으로 띄울지 고민했다. 결론은 Modal로 띄워야 한다고 결론을 내렸다. 찾아보니 Navigation Controller의 용도는 계층적인 구조를 표현하기 위해 사용하는 용도라고 한다. 재고 수정에서 재고 추가 화면 이동은 계층적인 구조가 아니라는 점과 네비게이션으로 연결한다면 뒤로가기 버튼이 생기는데 뒤로가기 버튼의 의미가 모호해진다는 점, 저장과 취소 버튼이 필요하다는 점에서 Modal이 적절하다고 생각해 해당 방식으로 적용했다.
  - Navigation Controller 끼리 연결한 이유에 대해 궁금증을 가지고 있었다. 물어보니 Modal을 사용하고 싶은데 Navigation Bar도 사용하고 싶어서라는 것을 알게되었다.
- Stepper 활용과 Autolayout

  - Autolayout을 활용한 후 Stepper의 크기를 조절하고 싶었는데 Stepper는 코드를 통해 비율에 따라서만 조절할 수 있다는 것을 알게되었다.
  - 5개의 Stepper가 같은 기능을 하는데 한 번에 묶어서 처리하고 싶어 하나의 함수로 연결한 후 stepper의 tag을 활용하였다.

  ```swift
  @IBAction private func stepperButtonTapped(_ sender: UIStepper) {
      guard let currentFruitName = Fruit(rawValue: sender.tag) else { return }
      let changeNumber = store.getNum(fruitName: currentFruitName) + Int(sender.value)

      for numberLabel in numberLabelCollection {
        if numberLabel.tag == sender.tag {
          numberLabel.text = changeNumber.description
        }
      }
    }
  ```

- @IBOutlet Collection 활용
  - 5개의 Stepper가 같은 기능을 하는데 한 번에 묶어서 처리하고 싶어 IBOutlet Collection과 stepper의 tag을 활용하였다.
  ```swift
  @IBOutlet private var numberLabelCollection: [UILabel]!
  ```
- 성능 향상을 위해 final, private, weak 키워드 활용

  ```swift
  final class EditStoreViewController: UIViewController {
    weak var delegate: DismissEditStoreViewDelegate?

    private let store = FruitStore.shared
  }
  ```

<br/><br/>

## 구현 중 참고한 링크

- 참고해야하는 문서

  - [Swift Language Guide - Initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/)
  - [Swift Language Guide - Access Control](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/)
  - [Swift Language Guide - Nested Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/nestedtypes/)
  - [Swift Language Guide - Type Casting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/typecasting/)
  - [Swift Language Guide - Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/)

- UI 관련

  - [하나의 함수로 여러개의 버튼을 연결하는 방법 학습](https://medium.com/@paulfranco/how-to-use-a-single-ibaction-for-multiple-buttons-in-ios-8f1e2f07c82f)
  - [alert 팝업 띄우는 방법 학습](https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift)
  - [[iOS] AutoLayout 정복하기](https://babbab2.tistory.com/133)
  - [[iOS] IBOutlet Collection](https://beansbin-develop.tistory.com/6)

- 화면전환과 데이터 전송

  - [[iOS] 화면간 데이터 전달하기](https://velog.io/@heyksw/iOS-화면간-데이터-전달하기)
  - [[iOS] 데이터 전달 방식 4가지 - property, delegate, closure, NotificationCenter](https://hellozo0.tistory.com/365)
  - [navigation 컨트롤러가 2개인 이유와 present Modally로 연결한 이유](https://stackoverflow.com/questions/14977164/when-i-should-use-navigation-controller)
  - [NotificationCenter와 사용법](https://medium.com/hcleedev/swift-notificationcenter%EC%99%80-%EC%82%AC%EC%9A%A9%EB%B2%95-6eb4490aac88)
  - [[iOS] performSegue](https://jiyeonlab.tistory.com/8)

- 스텝퍼 구현

  - [[iOS/UIKit] UIStepper Tutorial](https://leeari95.tistory.com/58)
  - [[iOS - SwiftUI] Stepper 사용 방법](https://ios-development.tistory.com/1091)

- Delegate 패턴을 구현하며 마주한 오류 해결
  - [Protocol ARC 관련 weak 키워드 추가](https://stackoverflow.com/questions/33471858/swift-protocol-error-weak-cannot-be-applied-to-non-class-type)
  - [[iOS] Protocol](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Class-Only-Protocols)
  - [[iOS] ARC(Automatic Reference Counting)](https://babbab2.tistory.com/26)
