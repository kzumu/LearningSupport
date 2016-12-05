//
//  ChooseDateViewController.swift
//  LearningSupport
//
//  Created by Kazumasa Shimomura on 2016/12/05.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let dayStr = ["月曜日","火曜日","水曜日","木曜日","金曜日"]
    let hourStr = ["1限","2限","3限","4限","5限"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Reservation.subjectName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let row0 = pickerView.selectedRow(inComponent: 0)
        let row1 = pickerView.selectedRow(inComponent: 1)
        Reservation.day = dayStr[row0]
        Reservation.hour = hourStr[row1]
        
        performSegue(withIdentifier: "toInputInfo", sender: self)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dayStr.count
        }else {
            return hourStr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dayStr[row]
        }else {
            return hourStr[row]
        }
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
