//
//  swift
//  ElephantTestingGround
//
//  Created by Lionel Yu on 11/27/22.
//

import Foundation

class Model {
//    static let shared: Model = Model()
    var stringArray: [String] = []
    var activeArray: [Item] = []
    var inactiveArray: [Item] = []
    var savedItems: [Item] = []
    var projectArray: [Project] = []
    var uniqueNumCounter: Int = 0
    
    var completeRate = 2
    var dailyRate = 0
    var insertArray: [Item] = []
    
    let calendar = Calendar.current
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ActiveItems.plist")
    let inactiveFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("InactiveItems.plist")
    let saveFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("SavedItems.plist")
    let projectsFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Projects.plist")
    

    init() {
        
        
        
        loadItems()
//        activeArray =
//        [
//            Item(title: "First Item", timeDone: Date(), project: "Wix", uniqueNum: 1, status: "Active"),
//            Item(title: "Second Item", timeDone: Date(), project: "Piano", uniqueNum: 2, status: "Active"),
//            Item(title: "Third Item", timeDone: Date(), project: "None", uniqueNum: 3, status: "Active"),
//            Item(title: "Fourth Item", timeDone: Date(), project: "None", uniqueNum: 4, status: "Active"),
//            Item(title: "Fifth Item", timeDone: Date(), project: "None", uniqueNum: 5, status: "Active"),
//            Item(title: "Sixth Item", timeDone: Date(), project: "Cleaning", uniqueNum: 6, status: "Active"),
//            Item(title: "Seventh Item", timeDone: Date(), project: "None", uniqueNum: 7, status: "Active"),
//            Item(title: "Eighth Item", timeDone: Date(), project: "None", uniqueNum: 8, status: "Active"),
//            Item(title: "Nineth Item", timeDone: Date(), project: "None", uniqueNum: 9, status: "Active")
//        ]
//
//        inactiveArray =
//        [
//            Item(title: "Tenth Item", timeDone: Date(), project: "None", uniqueNum: 10, status: "Inact"),
//            Item(title: "Eleventh Item", timeDone: Date(), project: "None", uniqueNum: 11, status: "Inact"),
//            Item(title: "Twelveth Item", timeDone: Date(), project: "Piano", uniqueNum: 12, status: "Inact"),
//            Item(title: "Thirteenth Item", timeDone: Date(), project: "None", uniqueNum: 13, status: "Inact"),
//            Item(title: "Fourteenth Item", timeDone: Date(), project: "Piano", uniqueNum: 14, status: "Inact"),
//            Item(title: "Fifteenth Item", timeDone: Date(), project: "Piano", uniqueNum: 15, status: "Inact")
//        ]
////
//        projectArray =
//        [
//            Project(name: "None", completed: false, priority: 100000, cycle: false, deadline: nil),
//            Project(name: "Piano", completed: false, priority: 3, cycle: false, deadline: nil),
//            Project(name: "Cleaning", completed: false, priority: 3, cycle: true, deadline: nil),
//            Project(name: "Wix", completed: false, priority: 3, cycle: true, deadline: nil)
//        ]
//
//
//        let date1 = calendar.date(byAdding: .day, value: -1, to: Date())
//        let date2 = calendar.date(byAdding: .day, value: -2, to: Date())
//        let date3 = calendar.date(byAdding: .day, value: -3, to: Date())
//        let date4 = calendar.date(byAdding: .day, value: -4, to: Date())
//        savedItems =
//
//        [
//            Item(title: "21 Item", timeDone: date2!, project: "None", uniqueNum: 21, status: "Inact"),
//            Item(title: "22 Item", timeDone: date1!, project: "None", uniqueNum: 22, status: "Inact"),
//            Item(title: "23 Item", timeDone: date1!, project: "None", uniqueNum: 23, status: "Inact"),
//            Item(title: "24 Item", timeDone: date1!, project: "None", uniqueNum: 24, status: "Inact"),
//            Item(title: "25 Item", timeDone: date2!, project: "None", uniqueNum: 25, status: "Inact"),
//            Item(title: "26 Item", timeDone: date2!, project: "None", uniqueNum: 26, status: "Inact"),
//            Item(title: "27 Item", timeDone: date2!, project: "None", uniqueNum: 27, status: "Inact"),
//            Item(title: "28 Item", timeDone: date3!, project: "None", uniqueNum: 28, status: "Inact"),
//            Item(title: "29 Item", timeDone: date3!, project: "None", uniqueNum: 29, status: "Inact"),
//            Item(title: "30 Item", timeDone: date4!, project: "None", uniqueNum: 30, status: "Inact")
//
//        ]
     
//
        uniqueNumCounter = activeArray.count + inactiveArray.count + savedItems.count
        calculateCompleteRate()
        calculateDailyRate()
        
    }
    
    
    func calculateCompleteRate() {
        var oneArray: [Int] = []
        var limitCounter = 0
        let currentCount = savedItems.count
//        print(savedItems[currentCount-1])
        
        let reversedArray = Array(savedItems.reversed())
        
        
        
        for randItem in reversedArray {
            if limitCounter < 30 {
                if let checkNil = randItem.timeDone {
                    let components = calendar.dateComponents([.day], from: checkNil)
                    oneArray.append(components.day!)
//                    print(checkNil)
                    limitCounter += 1
                } else {
                    limitCounter += 1
                }
            }
        }

        let mappedItems = oneArray.map { ($0, 1)}
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)

        var numerator = 0
        var denominator = 0
        var averageRate: Double = 0

        for (day, itemsDone) in counts {
            if itemsDone > 1 {
                denominator += 1
                numerator = numerator + itemsDone
            }
        }
        print(numerator)
        print(denominator)

        if denominator == 0 {
            averageRate = 10
        } else {
            averageRate = Double(numerator)/Double(denominator)
        }

        if averageRate < 6 {
            averageRate = 6
        }
        completeRate = Int(averageRate)
    }
    
    
    func calculateDailyRate() {
        var tempVar = 0
        for randItem in savedItems {
            if let whatIsDate = randItem.timeDone {
                let newVar = Calendar.current.isDateInToday(whatIsDate)
                if newVar {
                    tempVar += 1
                }
            }
            
        }
        
        dailyRate = tempVar
        

        
        
        
    }
    
    
    
    func addItemNoneProject(itemTitle: String) {
        uniqueNumCounter += 1
        let newItem = Item(title: itemTitle, timeDone: Date(), project: "None", uniqueNum: uniqueNumCounter, status: "Inact")
        inactiveArray.append(newItem)
    }
    

    func undoAddItem() {
        var currentCount = inactiveArray.count - 1
        inactiveArray.remove(at: currentCount)
        currentCount = inactiveArray.count - 1
        saveItems()
        uniqueNumCounter -= 1
    }
    

    
    
    
    
    
    
    
    
    
    
    func activateNextItem() {
        for indx in projectArray {
            let filteredActiveArray = activeArray.filter({ $0.project == indx.name})
            let filteredInactiveArray = inactiveArray.filter({ $0.project == indx.name})
            
            var indexHighest: Float = 0
            
            if filteredActiveArray.count == 0 {
                indexHighest = 0
            } else {
                let levelCheck = activeArray.firstIndex { $0.project == indx.name }
                indexHighest = Float(levelCheck!)
            }
            
            let level = (Float(activeArray.count) / Float(indx.priority)) * Float(filteredActiveArray.count)
            let finalLevel = Float(activeArray.count) - level
            
            if filteredActiveArray.count >= indx.priority || filteredInactiveArray.count == 0 || indexHighest >= finalLevel {
                print("Nothing was added for \(indx.name) with priority \(indx.priority)")
            } else {
                let currentIndex = inactiveArray.firstIndex { $0.uniqueNum == filteredInactiveArray[0].uniqueNum }
                inactiveArray[currentIndex!].status = "Active"
                let itemAdded = inactiveArray[currentIndex!]
                activeArray.append(itemAdded)
                inactiveArray.remove(at: currentIndex!)
                print("we added item \(itemAdded.title) from project \(indx.name) with priority \(indx.priority)")
            }
            
        }
    }
    
    
    func completeItem(uniqueNumba: Int) {
        let currentIndex = activeArray.firstIndex { $0.uniqueNum == uniqueNumba }
        
        
        let currentProjectOfItem = activeArray[currentIndex!].project
        let currentProjectIndex = projectArray.firstIndex { $0.name == currentProjectOfItem}
        let cycleOfProject = projectArray[currentProjectIndex!].cycle
        
        if cycleOfProject {
            activeArray[currentIndex!].status = "Inactive"
            inactiveArray.append(activeArray[currentIndex!])
        } else {
            print("none")
        }
        activeArray[currentIndex!].status = "Done"
        activeArray[currentIndex!].timeDone = Date()
        savedItems.append(activeArray[currentIndex!])
        activeArray.remove(at: currentIndex!)

//        print(activeArray[currentIndex!].title)
//        print(activeArray[currentIndex!].timeDone)
    }
    
    
    
    func uncompleteItem() {
        let currentSavedItemsCount = savedItems.count
        activeArray.insert(savedItems[(currentSavedItemsCount - 1)], at: 0)
        savedItems.remove(at: (currentSavedItemsCount - 1))
        activeArray[0].status = "Active"
        saveItems()
    }
    

    
    func insertProject(deadline: Date, proj: String) {
        var tempArray: [Item] = []
        for everyItem in inactiveArray {
            if everyItem.project == proj {
                tempArray.append(everyItem)
            }
        }
        
        let timeToCompletion = CalendarHelper().numberOfDaysBetween(Date(), and: deadline) - 1
//        print(timeToCompletion)
        let totalTasksUntilComp = timeToCompletion * completeRate
//        print(totalTasksUntilComp)

        let numbTasksProject = tempArray.count
//        let firstItemInsert = totalTasksUntilComp / numbTasksProject
//        print(firstItemInsert)
//        let secondItemInsert = (totalTasksUntilComp / numbTasksProject) * 2
//        print(secondItemInsert)

        var tempCounter = 1
        for insertItem in tempArray {
            var newItem = insertItem
            let insertIndx = totalTasksUntilComp / numbTasksProject * tempCounter
            if insertIndx < activeArray.count {
                newItem.status = "Active"
                activeArray.insert(newItem, at: insertIndx)
                tempCounter += 1
                print(insertIndx)
                
                let firstIndx = inactiveArray.firstIndex { $0.uniqueNum == newItem.uniqueNum}
                inactiveArray.remove(at: firstIndx!)
                
                
            } else {
                print("no more")
            }
        }

    }
    
    
    func insertProjectByPriority(priority: Int, proj: String) {

        let filteredActiveArray = activeArray.filter({ $0.project == proj})
        let filteredInactiveArray = inactiveArray.filter({ $0.project == proj})
        
        var indexHighest: Float = 0
        
        if filteredActiveArray.count == 0 {
            indexHighest = 0
        } else {
            // check where the last item
            let levelCheck = activeArray.lastIndex { $0.project == proj }
            indexHighest = Float(levelCheck!)
        }

        let rateOfInsertion = Float(activeArray.count) / Float(priority)
        var counter = 1
        
        for item in filteredInactiveArray {
            if indexHighest >= Float(activeArray.count) {
                print("Not adding anymore items for \(proj) with priority \(priority)")
            } else {
                let currentIndex = inactiveArray.firstIndex { $0.uniqueNum == item.uniqueNum }
                inactiveArray[currentIndex!].status = "Active"
                let itemAdded = inactiveArray[currentIndex!]
                activeArray.insert(itemAdded, at: Int(indexHighest + rateOfInsertion))
                inactiveArray.remove(at: currentIndex!)
                indexHighest = indexHighest + (rateOfInsertion * Float(counter))
                counter += 1
            }
        }
        
        
    }
    
    
    
    func insertProjectByHaste(haste: Int, proj: String) {
        var tempArray: [Item] = []
        for everyItem in inactiveArray {
            if everyItem.project == proj {
                tempArray.append(everyItem)
            }
        }
        

//        let numbTasksProject = tempArray.count
//        let firstItemInsert = totalTasksUntilComp / numbTasksProject
//        print(firstItemInsert)
//        let secondItemInsert = (totalTasksUntilComp / numbTasksProject) * 2
//        print(secondItemInsert)

        var tempCounter = 1
        for insertItem in tempArray {
            var newItem = insertItem
            let insertIndx = completeRate * tempCounter * haste
            if insertIndx < activeArray.count {
                newItem.status = "Active"
                activeArray.insert(newItem, at: insertIndx)
                tempCounter += 1
                print(insertIndx)
                
                let firstIndx = inactiveArray.firstIndex { $0.uniqueNum == newItem.uniqueNum}
                inactiveArray.remove(at: firstIndx!)
                
                
            } else {
                print("no more")
            }
        }

    }

    
    func connectLevel(proj: String) {
        let lastIndx = activeArray.lastIndex { $0.project == proj }
        var tempArray: [Item] = []
        for everyItem in inactiveArray {
            if everyItem.project == proj {
                tempArray.append(everyItem)
            }
        }
        var tempCounter = 1
        for insertItem in tempArray {
            var newItem = insertItem
            let insertIndx = lastIndx! + (completeRate * tempCounter)
            if insertIndx < activeArray.count {
                newItem.status = "Active"
                activeArray.insert(newItem, at: insertIndx)
                tempCounter += 1
                print(insertIndx)
                
                let firstIndx = inactiveArray.firstIndex { $0.uniqueNum == newItem.uniqueNum}
                inactiveArray.remove(at: firstIndx!)
                
            } else {
                print("no more")
            }
        }
    }
    
    
    func splitAndKick(currentItem: Item, currentIndx: Int) {
        let currentProject = currentItem.project
        activeArray[currentIndx].status = "Complete"
        activeArray.remove(at: currentIndx)
        
        var tempItem = currentItem
        tempItem.uniqueNum = uniqueNumCounter + 1

        for tempNum in 1...activeArray.count {
            let currentCounter = tempNum - 1
            let nextItem: Item
            if activeArray[currentCounter].project == currentProject {
                nextItem = activeArray[currentCounter]
                activeArray[currentCounter] = tempItem
                tempItem = nextItem
            }
            
            inactiveArray.insert(tempItem, at: 0)
            
        }
    }
    
    
    func snipAndQuick(chosenItem: Item) {
        let currentProject = chosenItem.project

        let indexOfChosen = activeArray.firstIndex { $0.uniqueNum == chosenItem.uniqueNum }

        activeArray[indexOfChosen!].status = "Discarded"
        savedItems.append(chosenItem)

        let totalProjArray = activeArray.filter({ $0.project == currentProject})

        let totalProjArrayMinusChosen = totalProjArray.filter({ $0.uniqueNum != chosenItem.uniqueNum})
//        print(totalProjArrayMinusChosen)

        var newCounter = 0

        for tempNum in 1...activeArray.count {
            let currentCounter = tempNum - 1
            if (activeArray[currentCounter].project == currentProject) && (newCounter < totalProjArrayMinusChosen.count) {
                activeArray[currentCounter] = totalProjArrayMinusChosen[newCounter]
                newCounter += 1
            } else if (activeArray[currentCounter].project == currentProject) && (newCounter == totalProjArrayMinusChosen.count) {
                activeArray.remove(at: currentCounter)
                break
            }
        }

    }
    
    

    
    
    func discardProject(proj: String) {
        let changeMeArray = activeArray.filter({ $0.project == proj})
        for countMe in changeMeArray {
            var tempItem = countMe
            tempItem.status = "Active then Discarded"
            savedItems.append(tempItem)
        }

        let newFilteredArray = activeArray.filter({ $0.project != proj})
        activeArray = newFilteredArray

        let changeMeArray2 = inactiveArray.filter({ $0.project == proj})
        for countMe in changeMeArray2 {
            var tempItem = countMe
            tempItem.status = "Inact then Discarded"
            savedItems.append(tempItem)
        }

        let newFilteredArray2 = inactiveArray.filter({ $0.project != proj})
        inactiveArray = newFilteredArray2
        
        projectArray = projectArray.filter({ $0.name != proj})
    }
    
    
    
    
    //MARK: - FILE MANAGEMENT FUNCTIONS
    
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                activeArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding")
            }
        }
        
        if let data = try? Data(contentsOf: inactiveFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                inactiveArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding")
            }
        }
        
        if let data = try? Data(contentsOf: saveFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                savedItems = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding")
            }
        }
        
        if let data = try? Data(contentsOf: projectsFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                projectArray = try decoder.decode([Project].self, from: data)
            } catch {
                print("error decoding")
            }
        }
        
        if activeArray.count == 0 {
            let newItem = Item(title: "Placeholder", timeDone: Date(), project: "None", uniqueNum: uniqueNumCounter, status: "None")
            uniqueNumCounter += 1
            activeArray.append(newItem)
        } else {
            saveItems()
        }
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(activeArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array")
        }
        
        do{
            let data = try encoder.encode(inactiveArray)
            try data.write(to: inactiveFilePath!)
        } catch {
            print("error encoding item array")
        }

        do{
            let data = try encoder.encode(savedItems)
            try data.write(to: saveFilePath!)
        } catch {
            print("error encoding item array")
        }
        
        do{
            let data = try encoder.encode(projectArray)
            try data.write(to: projectsFilePath!)
        } catch {
            print("error encoding item array")
        }
        
        print("items saved")
        
    }
    
    //MARK: - backup plist
    
    func backupPlistFiles() {
        let dateVar = Date.now.formatted(date: .abbreviated, time: .standard)
        let docuDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let musicDir = FileManager.default.urls(for: .musicDirectory, in: .allDomainsMask).first
        
        let d = musicDir!.path + "/" + dateVar
        do {
            try FileManager.default.createDirectory(atPath: d, withIntermediateDirectories: true, attributes: nil)
            print("Folder created \(d)")
        } catch (let error) {
            print("SHITS FUCKED \(error)")
        }
        
//        let musicDestURL = URL(fileURLWithPath: d)
        
        
        let pListArray = ["/ActiveItems.plist",
                          "/InactiveItems.plist",
                          "/SavedItems.plist",
                          "/Projects.plist"
        ]
        
        for eachFile in pListArray {
            let bbag = docuDir!.path + "/" + eachFile
            let bbagDest = URL(fileURLWithPath: bbag)
            let dbag = musicDir!.path + "/" + dateVar + eachFile
            let dbagDest = URL(fileURLWithPath: dbag)
            let saveStatus = self.secureCopyItem(at: bbagDest, to: dbagDest)
            if saveStatus {
                print("All Files Copied")
            }
            
        }
        
    }
    
    open func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
        } catch (let error) {
            print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
            return false
        }
        return true
    }
    

    
    
    
    
    //MARK: - TESTING FUNCTIONS
    func checkTimeDone(uniqueNumba: Int) {
        let currentIndex = savedItems.firstIndex { $0.uniqueNum == uniqueNumba }
        print(savedItems[currentIndex!].timeDone)
        
    }
    
    
    
    
}


