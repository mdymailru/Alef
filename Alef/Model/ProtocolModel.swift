//
//  ProtocolModel.swift
//  Alef
//
//  Created by mdy on 03.06.2021.
//

import Foundation

protocol ModelProtocol {
  var lastName: String? { get set }
  var firstName: String? { get set }
  var middleName: String? { get set }
  var age: Int? { get set }
  var children: [Child] { get set }
  var isChildAdd : Bool { get }
  
  func addChild(child: Child) -> Bool
  func delChild(at index: Int) -> Bool
  func editChild(at index: Int, child: Child)
  func validData(data: String, type: ValidationType) -> (Bool, String)
  
}
