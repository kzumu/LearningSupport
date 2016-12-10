//
//  ResourceManager.swift
//  LearningSupport
//
//  Created by Kazumasa Shimomura on 2016/12/05.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import Foundation
import JAYSON

class ResourceManager {
    
    static var subjects: [Subject] = []
    
    static func getJson() {
        let path : String = Bundle.main.path(forResource: "subjectInfo", ofType: "json")!
        let fileHandle : FileHandle = FileHandle(forReadingAtPath: path)!
        let data  = fileHandle.readDataToEndOfFile()
        
        let json = try! JAYSON(data: data)
        
        for i in 0..<json.array!.count {
            let subjectName = json[i]["subjectName"].string!
            let grade = json[i]["grade"].double!
            let semester = json[i]["semester"].double!
            
            subjects.append(Subject(subjectName: subjectName, grade: Int(grade), semester: Int(semester)))
        }
        
        print("--------------------load--------------------------")
        for i in 0..<subjects.count {
            print("科目名 : \(subjects[i].subjectName)\t\t学年 : \(subjects[i].grade)\t\t学期 : \(subjects[i].semester)")
        
        }
        print("--------------------load--------------------------")
    }
    
}

struct SemesterName {
    static let grade1_1 = "1年前期"
    static let grade1_2 = "1年後期"
    static let grade2_1 = "2年前期"
    static let grade2_2 = "2年後期"
    static let grade3_1 = "3年前期"
    static let grade3_2 = "3年後期"
}
