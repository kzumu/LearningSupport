//
//  ChooseSubjectViewController.swift
//  LearningSupport
//
//  Created by Kazumasa Shimomura on 2016/12/05.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class ChooseSubjectViewController: UITableViewController {
    
    var childs1_1:[String] = []
    var childs1_2:[String] = []
    var childs2_1:[String] = []
    var childs2_2:[String] = []
    var childs3_1:[String] = []
    var childs3_2:[String] = []
    var childsOthers: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0 :
            cell.textLabel?.text = childs1_1[indexPath.row]
        case 1 :
            cell.textLabel?.text = childs1_2[indexPath.row]
        case 2 :
            cell.textLabel?.text = childs2_1[indexPath.row]
        case 3 :
            cell.textLabel?.text = childs2_2[indexPath.row]
        case 4 :
            cell.textLabel?.text = childs3_1[indexPath.row]
        case 5 :
            cell.textLabel?.text = childs3_2[indexPath.row]
        case 6:
            cell.textLabel?.text = childsOthers[indexPath.row]
        default: break
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 :
            Reservation.subjectName = childs1_1[indexPath.row]
        case 1 :
            Reservation.subjectName = childs1_2[indexPath.row]
        case 2 :
            Reservation.subjectName = childs2_1[indexPath.row]
        case 3 :
            Reservation.subjectName = childs2_2[indexPath.row]
        case 4 :
            Reservation.subjectName = childs3_1[indexPath.row]
        case 5 :
            Reservation.subjectName = childs3_2[indexPath.row]
        case 6:
            Reservation.subjectName = childsOthers[indexPath.row]
        default:
            break
        }
        
        print(Reservation.subjectName)
        
        
        performSegue(withIdentifier: "toPickDate", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var name = ""
        switch section {
        case 0:
            name = SemesterName.grade1_1
        case 1:
            name = SemesterName.grade1_2
        case 2:
            name = SemesterName.grade2_1
        case 3:
            name = SemesterName.grade2_2
        case 4:
            name = SemesterName.grade3_1
        case 5:
            name = SemesterName.grade3_2
        case 6:
            name = "その他"
        default:
            break
        }
        
        return name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        switch section {
        case 0 :
            count = childs1_1.count
        case 1 :
            count = childs1_2.count
        case 2 :
            count = childs2_1.count
        case 3 :
            count = childs2_2.count
        case 4 :
            count = childs3_1.count
        case 5 :
            count = childs3_2.count
        case 6:
            count = childsOthers.count
        default:
            count = 0
        }
        return count
    }
    
    
    func setup() {
        
        for subject in ResourceManager.subjects {
            
            switch (subject.grade, subject.semester) {
            case (1,1):
                childs1_1.append(subject.subjectName)
            case (1,2):
                childs1_2.append(subject.subjectName)
            case (2,1):
                childs2_1.append(subject.subjectName)
            case (2,2):
                childs2_2.append(subject.subjectName)
            case (3,1):
                childs3_1.append(subject.subjectName)
            case (3,2):
                childs3_2.append(subject.subjectName)
            default:
                childsOthers.append(subject.subjectName)
            }
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
