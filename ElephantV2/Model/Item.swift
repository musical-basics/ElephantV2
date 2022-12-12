//
//  Item.swift
//  ElephantTestingGround
//
//  Created by Lionel Yu on 11/27/22.
//

import Foundation

struct Item: Codable {

    var title: String
    var timeDone: Date?
    var project: String
    var uniqueNum: Int
    var status: String

    
    func timeString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func checkCycle(projectName: String, checkArray: [Project]) -> Bool {
        if let projectIndex = checkArray.firstIndex { $0.name == projectName } {
            return checkArray[projectIndex].cycle
        }
        return false
    }
    
}


