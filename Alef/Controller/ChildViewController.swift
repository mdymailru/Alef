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
  var validTF = [Int: Bool]()
  
  var isVisibleSaveButton: Bool! {
    didSet { saveButton.isEnabled = isVisibleSaveButton
      
    }
  }
    
  weak var delegate: ChildDelegate?
  
  @IBOutlet weak var childNameTF: UITextField!
  @IBOutlet weak var childAgeTF: UITextField!
  @IBOutlet weak var infoWarningLabel: UILabel!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBAction func touchCancelButton(_ sender: UIButton) {
    view.endEditing(true)
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func touchSaveButton(_ sender: UIButton) {
    guard let name = childNameTF.text,
          let ageStr = childAgeTF.text,
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
    childNameTF.text = name
    childAgeTF.text = ageStr
        
    childNameTF.becomeFirstResponder()
    
    childNameTF.tag = 1 //is bad? but no time
    textFieldDidChange(childNameTF)
    childNameTF.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    
    childAgeTF.tag = 4 //is bad? but no time
    textFieldDidChange(childAgeTF)
    childAgeTF.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
      
  }
  
  @objc
  func textFieldDidChange(_ textField: UITextField) {
    guard let data = textField.text else { return }
    var type = ValidationType.emptyString
    
    switch textField.tag {
      case 1...2: type = .emptyString  //childNameTF
      case 4: type = .age              //ChildAgeTF
       
      default: return
    }
    let valid = delegate?.proxyValidate(data: data, type: type)
    validTF[textField.tag] = valid?.result
    
    isVisibleSaveButton = !validTF.values.contains(false)
    infoWarningLabel.text = valid?.error
  }
}

extension ChildViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    childAgeTF.becomeFirstResponder()    //resignFirstResponder()
        
    return true
  }
    
}
