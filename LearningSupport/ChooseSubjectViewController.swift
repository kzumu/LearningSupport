//
//  ChooseSubjectViewController.swift
//  LearningSupport
//
//  Created by Kazumasa Shimomura on 2016/12/05.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit
import AccordionMenuSwift

class ChooseSubjectViewController: AccordionTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }

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
    
    func setup() {
        
        var childs1_1:[String] = []
        var childs1_2:[String] = []
        var childs2_1:[String] = []
        var childs2_2:[String] = []
        var childs3_1:[String] = []
        var childs3_2:[String] = []
        var childsOthers: [String] = []
        
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
        
        let parent1_1 = Parent(state: .collapsed, childs: childs1_1, title: SemesterName.grade1_1)
        let parent1_2 = Parent(state: .collapsed, childs: childs1_2, title: SemesterName.grade1_2)
        let parent2_1 = Parent(state: .collapsed, childs: childs2_1, title: SemesterName.grade2_1)
        let parent2_2 = Parent(state: .collapsed, childs: childs2_2, title: SemesterName.grade2_2)
        let parent3_1 = Parent(state: .collapsed, childs: childs3_1, title: SemesterName.grade3_1)
        let parent3_2 = Parent(state: .collapsed, childs: childs3_2, title: SemesterName.grade3_2)
        let parentOther = Parent(state: .collapsed, childs: childsOthers, title: "その他")
        
        self.dataSource = [parent1_1, parent1_2, parent2_1, parent2_2, parent3_1, parent3_2, parentOther]
        self.numberOfCellsExpanded = .several
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
