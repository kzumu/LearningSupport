//
//  Subject.swift
//  LearningSupport
//
//  Created by Kazumasa Shimomura on 2016/12/05.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import Foundation

class Subject {
    var subjectName: String
    var grade: Int
    var semester: Int
    
    init(subjectName: String, grade: Int, semester: Int) {
        self.subjectName = subjectName
        self.grade = grade
        self.semester = semester
    }
}
