//
//  ChooseDateTableViewController.swift
//  LearningSupport
//
//  Created by TaikiFnit on 2018/07/05.
//  Copyright © 2018 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class ChooseDateTableViewController: UITableViewController, DateTimeToParentProtocol, UITextFieldDelegate {

    @IBOutlet weak var firstPreferTextField: UITextField!
    @IBOutlet weak var secondPreferTextField: UITextField!
    @IBOutlet weak var thirdPreferTextField: UITextField!
    
    var textFieldFoucsing: UITextField?
    
    var selectedRows: [UITextField: (Int, Int)] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "次へ", style: .plain, target: self, action: #selector(onClickRightButton(sender:)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstPreferTextField.becomeFirstResponder()
    }
    
    func setKeyboard() {
        let keyboardView = MyDateTimePickerView()
        keyboardView.parentViewDelegate = self
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
        keyboardView.frame = frame
        
        firstPreferTextField.inputView = keyboardView
        firstPreferTextField.inputAssistantItem.leadingBarButtonGroups = []
        firstPreferTextField.inputAssistantItem.trailingBarButtonGroups = []
        firstPreferTextField.delegate = self
        secondPreferTextField.inputView = keyboardView
        secondPreferTextField.inputAssistantItem.leadingBarButtonGroups = []
        secondPreferTextField.inputAssistantItem.trailingBarButtonGroups = []
        secondPreferTextField.delegate = self
        thirdPreferTextField.inputView = keyboardView
        thirdPreferTextField.inputAssistantItem.leadingBarButtonGroups = []
        thirdPreferTextField.inputAssistantItem.trailingBarButtonGroups = []
        thirdPreferTextField.delegate = self
    }
    
    @objc internal func onClickRightButton(sender: UIButton) {
        Reservation.firstPreferDay = firstPreferTextField.text ?? "選択なし"
        Reservation.secondPreferDay = secondPreferTextField.text ?? "選択なし"
        Reservation.thirdPreferDay = thirdPreferTextField.text ?? "選択なし"
        if Reservation.secondPreferDay == "" {
            Reservation.secondPreferDay = "選択なし"
        }
        if Reservation.thirdPreferDay == "" {
            Reservation.thirdPreferDay = "選択なし"
        }
        
        self.performSegue(withIdentifier: "toInputInfo", sender: self)
    }
    
    func pickerChanged(str: String, dayRow: Int, hourRow: Int) {
        if let textField = self.textFieldFoucsing {
            textField.text = str
            self.selectedRows[textField] = (dayRow, hourRow)
        }
    }
    
    func pickerInitialized(str: String) {
        if let textField = self.textFieldFoucsing {
            textField.text = str
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldFoucsing = textField
        
        if let keyboardView = textField.inputView as? MyDateTimePickerView {
            
            if let (dayRow, hourRow) = self.selectedRows[textField] {
               keyboardView.setPciker(dayRow: dayRow, hourRow: hourRow)
            } else {
                keyboardView.firstEditing()
            }
        }
    }
}
