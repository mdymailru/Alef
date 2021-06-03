//
//  MainViewController.swift
//  Alef
//
//  Created by mdy on 02.06.2021.
//

import UIKit

class MainViewController: UIViewController {

  var model: Model!
  var isVisibleAddChildButton: Bool! {
    didSet { addChildButton.isHidden = !isVisibleAddChildButton
      infoWarningLabel.text = model.validData(type: .maxChild).error
    }
  }
  
  @IBOutlet weak var infoWarningLabel: UILabel!
  @IBOutlet weak var lastNameTF: UITextField!
  @IBOutlet weak var firstNameTF: UITextField!
  @IBOutlet weak var middleNameTF: UITextField!
  @IBOutlet weak var ageTF: UITextField!
  @IBOutlet weak var tableViewChild: UITableView!
  @IBOutlet weak var addChildButton: UIButton!
    
  @IBAction func touchDelChildButton(_ sender: UIButton) {
    
    guard let row = sender.superview?.tag else { return }
    let alert = UIAlertController(title: "Удалить \(row + 1):\(model.children[row].name ?? "") ?",
                                message: "",
                         preferredStyle: .actionSheet)
    let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    let actionDelete = UIAlertAction(title: "Удалить",
                                     style: .destructive,
        handler: { [weak self] _ in self?.isVisibleAddChildButton = self?.model.delChild(at: row)
                                    self?.tableViewChild.reloadData() })
    alert.addAction(actionCancel)
    alert.addAction(actionDelete)
    present(alert, animated: true, completion: nil)
  }
      
  override func viewDidLoad() {
    lastNameTF.tag = 1 //is bad? but no time
    lastNameTF.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    firstNameTF.tag = 2 //is bad? but no time
    firstNameTF.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    ageTF.tag = 4 //is bad? but no time
    ageTF.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    
    initMainVC()
  }
  
  func initMainVC() {
    model = Model()
    isVisibleAddChildButton = model.validData(type: .maxChild).result 
  }
  
  @objc
  func textFieldDidChange(_ textField: UITextField) {
    guard let data = textField.text else { return }
    var type = ValidationType.emptyString
    
    switch textField.tag {
      case 1...2: type = .emptyString  //lastNameTF
      case 4: type = .age              //ageTF
       
      default: return
    }
    let valid = model.validData(data: data, type: type)
    infoWarningLabel.text = valid.error
  }
}

//MARK: ChildrenTableViewDataSource
extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return model.children.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellChild", for: indexPath) as! CellChild
    
    cell.contentView.tag = indexPath.row
    cell.numberChildCellLabel.text = "\(indexPath.row + 1)"
        
    let child = model.children[indexPath.row]
    guard let name = child.name, let age = child.age else { return cell }
    cell.shortChildInfoCellLabel.text = "\(name), \(age)"
            
    return cell
  }
  
}

//MARK: ChildDelegate
extension MainViewController: ChildDelegate {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    view.endEditing(true)
    
    let childVC = segue.destination as! ChildViewController
    childVC.delegate = self
    childVC.editModeRow = nil            //new Child
    
    if let cell = sender as? CellChild { //editing Child
      let index = cell.contentView.tag
      childVC.name = (model.children[index].name) ?? ""
      guard let age = model.children[index].age else { return }
      childVC.ageStr = String(age)
      childVC.editModeRow = index
    }
  }
  
  func addChild(child: Child) {
    isVisibleAddChildButton = model.addChild(child: child)
    tableViewChild.reloadData()
  }
  
  func editChild(row index: Int, child: Child) {
    model.editChild(at: index, child: child)
    tableViewChild.reloadData()
  }
}

