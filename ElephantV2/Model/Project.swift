//
//  Project.swift
//  ElephantTestingGround
//
//  Created by Lionel Yu on 11/27/22.
//

import Foundation

class Project: Codable {
    var name: String
    var completed: Bool
    var priority: Int
    var cycle: Bool
    var deadline: Date?
    
//    var itemArray: [Item]?
    
    init(name: String, completed: Bool, priority: Int, cycle: Bool, deadline: Date?) {
        self.name = name
        self.completed = completed
        self.priority = priority
        self.cycle = cycle
        self.deadline = deadline
    }
    
    func nextItem(item: Item) -> Item
    {
        
        return item
    }
    
    
    
}

