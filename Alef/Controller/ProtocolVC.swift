//
//  ProtocolVC.swift
//  Alef
//
//  Created by mdy on 03.06.2021.
//

import Foundation

protocol ChildDelegate: AnyObject {
  func addChild(child: Child)
  func editChild(row index: Int, child: Child)
  func proxyValidate(data: String, type: ValidationType) -> (result: Bool, error: String)
}
