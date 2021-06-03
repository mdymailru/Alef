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
       
  func addChild(child: Child) -> Bool {
    children.append(child)
    return validData(type: .maxChild).result
  }
  
  func delChild(at index: Int) -> Bool {
    children.remove(at: index)
    return validData(type: .maxChild).result 
  }
  
  func editChild(at index: Int, child: Child) {
    children[index].name = child.name
    children[index].age = child.age
  }

  func validData(data: String = "", type: ValidationType) -> (result: Bool, error: String) {
    switch type {
      case .emptyString:
        guard data.count > 1 else { return (false, "Пустые данные") }
      case .age:
        guard data.count > 0 else { return (false, "Пустые данные") }
        guard let age = Int(data) else { return (false, "Не целое число") }
        guard age < 99 else { return (false, "Столько не живут 😥") }
      case .maxChild:
        guard children.count < 5 else { return (false, "Максимально 5 детей") }
    }
    return (true, "")
    
  }

}

struct Child {
  var name: String?
  var age: Int?
}
