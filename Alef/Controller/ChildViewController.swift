//
//  ChildViewController.swift
//  Alef
//
//  Created by mdy on 02.06.2021.
//

import UIKit

class ChildViewController: UIViewController {

  var name = ""
  var ageStr = ""
  var editModeRow: Int?
  
  weak var delegate: ChildDelegate?
  
  @IBOutlet weak var tFieldChildName: UITextField!
  @IBOutlet weak var tFieldChildAge: UITextField!
  
  @IBAction func touchCancelButton(_ sender: UIButton) {
    view.endEditing(true)
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func touchSaveButton(_ sender: UIButton) {
    guard let name = tFieldChildName.text,
          let ageStr = tFieldChildAge.text,
          let age = Int(ageStr)
    else { print("Input Data no correct"); return }
    
    let child = Child(name: name, age: age)
    if let row = editModeRow {
      delegate?.editChild(row: row, child: child)
    } else  {
      delegate?.addChild(child: child)
    }
  }
  
  override func viewDidLoad() {
    tFieldChildName.text = name
    tFieldChildAge.text = ageStr
    tFieldChildName.becomeFirstResponder()
  }
}

extension ChildViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    tFieldChildName.resignFirstResponder()
    return true
  }
  
}
