//
//  Model.swift
//  Alef
//
//  Created by mdy on 02.06.2021.
//

import Foundation

class Model: ModelProtocol {
    
  var lastName: String?
  var firstName: String?
  var middleName: String?
  var age: Int?
  var children = [Child]()
  
  var isChildAdd: Bool { return children.count < maxChildren }
  private let maxChildren = 5
   
  func addChild(child: Child) -> Bool {
    children.append(child)
    return isChildAdd
  }
  
  func delChild(at index: Int) -> Bool {
    children.remove(at: index)
    return isChildAdd
  }
  
  func editChild(at index: Int, child: Child) {
    children[index].name = child.name
    children[index].age = child.age
  }

  func validData(data: String, type: ValidationType) -> (Bool, String) {
    switch type {
      case .emptyString:
        guard data.count > 1 else { return (false, "Пустые данные") }
      case .age:
        guard data.count > 0 else { return (false, "Пустые данные") }
        guard let age = Int(data) else { return (false, "Не целое число") }
        print(age)
        guard age < 99 else { return (false, "Столько не живут 😥") }
    }
    return (true, "")
  }

}

struct Child {
  var name: String?
  var age: Int?
}
