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
  
  @IBOutlet weak var ChildNameTF: UITextField!
  @IBOutlet weak var ChildAgeTF: UITextField!
  
  @IBAction func touchCancelButton(_ sender: UIButton) {
    view.endEditing(true)
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func touchSaveButton(_ sender: UIButton) {
    guard let name = ChildNameTF.text,
          let ageStr = ChildAgeTF.text,
          let age = Int(ageStr)
    else { print("Input Data no correct"); return }
    
    let child = Child(name: name, age: age)
    if let row = editModeRow {
      delegate?.editChild(row: row, child: child) //edit
    } else  {
      delegate?.addChild(child: child)            //new
    }
  }
  
  override func viewDidLoad() {
    ChildNameTF.text = name
    ChildAgeTF.text = ageStr
    ChildNameTF.becomeFirstResponder()
  }
}

extension ChildViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    ChildNameTF.resignFirstResponder()
    return true
  }
  
}
