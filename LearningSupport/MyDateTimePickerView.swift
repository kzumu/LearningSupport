//
//  MyDateTimePickerView.swift
//  LearningSupport
//
//  Created by TaikiFnit on 2018/07/05.
//  Copyright © 2018 Kazumasa Shimomura. All rights reserved.
//

import Foundation
import UIKit

protocol DateTimeToParentProtocol {
    func pickerChanged(str: String, dayRow: Int, hourRow: Int)
    func pickerInitialized(str: String)
}

protocol ParentToDateTimeProtocol {
    func setPciker(dayRow: Int, hourRow: Int)
    func firstEditing()
}

class MyDateTimePickerView: UIView {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var parentViewDelegate: DateTimeToParentProtocol?
    
    let dayStr = ["月曜日","火曜日","水曜日","木曜日","金曜日", "指定なし", ""]
    let hourStr = ["1限","2限","3限","4限","5限", "指定なし", ""]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        let view = Bundle.main.loadNibNamed("MyDateTimePickerView", owner: self, options: nil)?.first as! UIView
        
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
    }
}

extension MyDateTimePickerView: ParentToDateTimeProtocol {
    func firstEditing() {
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
        self.pickerView.selectRow(0, inComponent: 1, animated: true)
        
        guard let pView = self.parentViewDelegate else { return }
        let dayName = dayStr[0] + " " + hourStr[0]
        pView.pickerInitialized(str: dayName)
    }
    
    func setPciker(dayRow: Int, hourRow: Int) {
        self.pickerView.selectRow(dayRow, inComponent: 0, animated: true)
        self.pickerView.selectRow(hourRow, inComponent: 1, animated: true)
    }
}

extension MyDateTimePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dayStr.count
        } else {
            return hourStr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dayStr[row]
        } else {
            return hourStr[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let  pView = self.parentViewDelegate else { return }
        let dayRow = pickerView.selectedRow(inComponent: 0)
        let hourRow = pickerView.selectedRow(inComponent: 1)
        let dayName = dayStr[dayRow] + " " + hourStr[hourRow]
        pView.pickerChanged(str: dayName, dayRow: dayRow, hourRow: hourRow)
    }
}
