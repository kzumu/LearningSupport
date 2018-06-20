//
//  InputInfoViewController.swift
//  LearningSupport
//
//  Created by Kazumasa Shimomura on 2016/12/05.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit
import MessageUI

class InputInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate {
    
    let grade = ["１年生","２年生","３年生","４年生"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    

    @IBOutlet weak var schoolNumberField: UITextField!
    @IBOutlet weak var subjectTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mailAddressField: UITextField!
    @IBOutlet weak var otherField: UITextField!
    
    var txtActiveField: UITextField!
    @IBOutlet weak var scrollViewer: UIScrollView!
    

    //編集後のtextFieldを新しく格納する変数を定義
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectTitle.text = Reservation.subjectName
        dateLabel.text = Reservation.day + Reservation.hour
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if schoolNumberField.text == ""  || nameField.text == "" || mailAddressField.text  == "" {
            let ac = UIAlertController(title: "空欄があります", message: "正しく入力してから再度実行してください", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true, completion: nil)
            return
        }
        
        Reservation.name = nameField.text!
        Reservation.mail = mailAddressField.text!
        Reservation.other = otherField.text!
        Reservation.grade = grade[pickerView.selectedRow(inComponent: 0)]
        Reservation.schoolNumber = schoolNumberField.text!
        
        makeMail()
    }
    
    @IBAction func overLayTapped(_ sender: Any) {
        schoolNumberField.resignFirstResponder()
        nameField.resignFirstResponder()
        mailAddressField.resignFirstResponder()
        otherField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grade.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return grade[row]
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Email Send Cancelled")
        case .saved:
            print("Email Saved as a Draft")
        case .sent:
            self.dismiss(animated: true, completion: {
                print("Email Sent Successfully")
                let ac = UIAlertController(title: "\(Reservation.mail)に控えを送信します。",
                                           message: "メールが正常に送信されないバグが発生しているようです。\nお手数をおかけしますがホームボタンをダブルタップして送信ボックスをチェックの上、未送信の場合は未送信リストを下にスワイプして再送信して見てください。",
                                           preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                ac.addAction(okAction)
                self.present(ac, animated: true, completion: nil)
                return
            })
        case .failed:
            print("Email Send Failed")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollViewer.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollViewer.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollViewer.contentInset = contentInset
    }
    
    func stringForCcToArray(str: String) -> [String] {
        var array:[String] = []
        
        let commaSp = Reservation.mail.components(separatedBy: ", ")
        let comma = Reservation.mail.components(separatedBy: ",")
        let space = Reservation.mail.components(separatedBy: " ")
        
        for item in [commaSp, comma, space] {
            if array.count < item.count {
                array = item
            }
        }
        
        return array
    }
    
    func makeMail() {
        //メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail()==false {
            
            let alert = UIAlertController(title: "エラー", message: "原因不明のエラーです\n管理者にご連絡ください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            print("Email Send Failed")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
        let toRecipients = [Email.to]
        //        let toRecipients = [Email.stubTo]
        
        let CcRecipients:[String] = self.stringForCcToArray(str: Reservation.mail)
        
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("予約申請")
        mailViewController.setToRecipients(toRecipients) //Toアドレスの表示
        mailViewController.setCcRecipients(CcRecipients) //Ccアドレスの表示
        
        let body = "<table border><tr><td>希望日</td><td>\(Reservation.day)\(Reservation.hour)</td></tr><tr><td>科目名</td><td>\(Reservation.subjectName)</td></tr><tr><td>申請者名</td><td>\(Reservation.name)</td></tr><tr><td>学年</td><td>\(Reservation.grade)</td></tr><tr><td>学籍番号</td><td>\(Reservation.schoolNumber)</td></tr><tr><td>メールアドレス</td><td>\(Reservation.mail)</td></tr><tr><td>伝達事項</td><td>\(Reservation.other)</td></tr></table>"
        
        //<tr><td>1-1</td><td>1-2</td></tr>
        mailViewController.setMessageBody(body, isHTML: true)
        
        
        
        self.present(mailViewController, animated: true, completion: nil)
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
