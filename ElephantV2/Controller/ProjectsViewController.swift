//
//  ProjectsViewController.swift
//  Elephant-V1
//
//  Created by Lionel Yu on 11/18/22.
//

import UIKit

class ProjectsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var projectDropdown: UIPickerView!
    @IBOutlet weak var projectItemsTable: UITableView!
    
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ActiveItems.plist")
    let inactiveFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("InactiveItems.plist")
    let saveFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("SavedItems.plist")
    let projectsFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Projects.plist")
    
    var activeArray: [Item] = []
    var inactiveArray: [Item] = []
    var savedItems: [Item] = []
    var projectSelected = ""
    var filteredArray: [Item] = []
    var filteredInactiveArray: [Item] = []
    
    var removeNoneProjects: [Project] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        projectDropdown.delegate = self
        projectDropdown.dataSource = self
        
        projectItemsTable.delegate = self
        projectItemsTable.dataSource = self
        
//        categoSelected = "None"
//
//        filteredArray = model.itemArray.filter({ $0.catego == "None"})
//        filteredInactiveArray = model.inactiveArray.filter({ $0.catego == "None"})
//        filteredArray = filteredArray + filteredInactiveArray
        
        removeNoneProjects = model.projectArray.filter({ $0.name != "None"})
        
        self.projectItemsTable.reloadData()
    }
    
//MARK: PICKER VIEW METHODS
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return removeNoneProjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return removeNoneProjects[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        self.categoryTextField.text = model.projectArray[row].name
//        categoSelected = model.projectArray[row].name
        projectSelected = removeNoneProjects[row].name
        
        filteredArray = model.activeArray.filter({ $0.project == projectSelected})
        filteredInactiveArray = model.inactiveArray.filter({ $0.project == projectSelected})
        filteredArray = filteredArray + filteredInactiveArray
        self.projectItemsTable.reloadData()
    }

//MARK: TABLE VIEW METHODS

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        removeNoneProjects = filteredArray.filter({ $0.catego != "None"})
        return filteredArray.count
//        return model.itemArray.count
//        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectItemsTable.dequeueReusableCell(withIdentifier: "projectItems", for: indexPath)
        cell.textLabel?.text = filteredArray[indexPath.row].title
        if filteredArray[indexPath.row].status == "Active" {
            cell.textLabel?.textColor = UIColor.black
        } else {
            cell.textLabel?.textColor = UIColor.red
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var textField = UITextField()
        let alert = UIAlertController(title: "Edit Current Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Edit This Item", style: .default) { (action) in
            
            var newItem = self.filteredArray[indexPath.row]
            newItem.title = textField.text!
            self.filteredArray[indexPath.row] = newItem
            
            if newItem.status == "Inact" {
                let indexSelected = model.inactiveArray.firstIndex { $0.uniqueNum == newItem.uniqueNum}
                model.inactiveArray[Int(indexSelected!)] = newItem
            } else {
                let indexSelected = model.activeArray.firstIndex { $0.uniqueNum == newItem.uniqueNum}
                model.activeArray[Int(indexSelected!)] = newItem
            }

            self.saveItems()
//            self.filteredArray = model.itemArray.filter{ $0.catego == self.categoSelected}
            self.projectItemsTable.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = self.filteredArray[indexPath.row].title
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

//MARK: - Bar Button
    
    
    
    
    
    
//MARK: - FIRST 3 BUTTONS
    
    @IBAction func addProjectPressed(_ sender: UIButton) {
        // Create alert controller
        let alertController = UIAlertController(title: "Add New Project", message: "Begin an empty project here.", preferredStyle: .alert)

        // add textfield at index 0
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Project Name"
        })

        // add textfield at index 1
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "What is the Priority (1-5)"
        })
        
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Is This A Cycle? Y/N"
        })

        // Alert action confirm
        let confirmAction = UIAlertAction(title: "Add Project", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            var tempName = alertController.textFields?[0].text
            var tempPriority = alertController.textFields?[1].text
            var tempCycle = alertController.textFields?[1].text
            var myCycle = false
            if tempCycle == "Y" {
                myCycle = true
            }
            var tempProject = Project(name: tempName!, completed: false, priority: Int(tempPriority!)!, cycle: myCycle, deadline: nil)
            
            model.projectArray.append(tempProject)
            self.removeNoneProjects.append(tempProject)
            self.saveItems()
            
            self.projectDropdown.reloadAllComponents()
            
            
        })
        alertController.addAction(confirmAction)
        
        // Alert action cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            print("Cancelled")
        })
        alertController.addAction(cancelAction)

        // Present alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func editPriority(_ sender: UIButton) {
        // Create alert controller
        let alertController = UIAlertController(title: "Edit Priority", message: "Please enter new priority.", preferredStyle: .alert)

        // add textfield at index 0
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            
            var newItem = self.projectSelected
            var projectIndex = model.projectArray.firstIndex { $0.name == newItem}
            var currentPriority = model.projectArray[projectIndex!].priority
            textField.placeholder = "Current Priority is \(currentPriority)"
        })

        // Alert action confirm
        let confirmAction = UIAlertAction(title: "Edit Priority", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            var newItem = self.projectSelected
            var projectIndex = model.projectArray.firstIndex { $0.name == newItem}
            
            var tempPriority = alertController.textFields?[0].text
            model.projectArray[projectIndex!].priority = Int(tempPriority!)!
            print(model.projectArray[projectIndex!].priority)
            self.saveItems()
            self.projectDropdown.reloadAllComponents()
        })
        alertController.addAction(confirmAction)
        
        // Alert action cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            print("Cancelled")
        })
        alertController.addAction(cancelAction)

        // Present alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func addItemProj(_ sender: UIButton) {
        
        var textField = UITextField()
//        let testVar2 = searchIndex(name: filteredArray[indexPath.row].uniqueNum, searchArray: model.theArray)
        let alert = UIAlertController(title: "Add Item To This Project", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item To This Project", style: .default) { (action) in
            
            model.uniqueNumCounter += 1
            let tempTitle = textField.text!
            
            var newItem = Item(title: tempTitle, timeDone: Date(), project: self.projectSelected, uniqueNum: model.uniqueNumCounter, status: "Inact")
            
            
            model.inactiveArray.append(newItem)
            self.filteredArray = model.activeArray.filter{ $0.project == self.projectSelected} + model.inactiveArray.filter{ $0.project == self.projectSelected}
            self.saveItems()
            self.projectItemsTable.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Item Here"
            textField = alertTextField
        }
        alert.addAction(action)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            print("Cancelled")
        })
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
//MARK: - SECOND 3 ITEMS HERE
    
    //insert project deadline
//    var textField = UITextField()
    
    
    @IBAction func insertDeadlineProject(_ sender: UIButton) {
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.timeZone = .current
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        
        
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: "", preferredStyle: .alert)
        
        alert.view.addSubview(myDatePicker)
        
        
        let action = UIAlertAction(title: "Set Deadline To This Project", style: .default) { (action) in
            
//            print(myDatePicker.date)
            print(self.projectSelected)
            let newDate = myDatePicker.date
            model.insertProject(deadline: newDate, proj: self.projectSelected)
            
            model.saveItems()
            self.projectItemsTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    //connect level
    
    
    @IBAction func connectLevels(_ sender: UIButton) {
        model.connectLevel(proj: projectSelected)
        self.projectItemsTable.reloadData()
        model.saveItems()
        
    }
    
    
    
    //discard project
    
    @IBAction func discardProject(_ sender: UIButton) {
        model.discardProject(proj: projectSelected)
        self.projectItemsTable.reloadData()
        model.saveItems()
    }
    
    

    
    
//MARK: - Special Functions
//
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do{
//                model.itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("error decoding")
//            }
//        }
//
//        if let data = try? Data(contentsOf: inactiveFilePath!) {
//            let decoder = PropertyListDecoder()
//            do{
//                model.inactiveArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("error decoding")
//            }
//        }
//
//        if let data = try? Data(contentsOf: saveFilePath!) {
//            let decoder = PropertyListDecoder()
//            do{
//                model.savedItems = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("error decoding")
//            }
//        }
//
//        if let data = try? Data(contentsOf: projectsFilePath!) {
//            let decoder = PropertyListDecoder()
//            do{
//                model.projectArray = try decoder.decode([Project].self, from: data)
//            } catch {
//                print("error decoding")
//            }
//        }
//
//        if model.itemArray.count == 0 {
//            let newItem = Item(title: "Placeholder", done: true, catego: "None", uniqueNum: 99999, status: "Active")
//            model.itemArray.append(newItem)
//        } else {
//            saveItems()
//        }
//    }
    
    //MARK: SAVED ITEMS
    func saveItems() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(model.activeArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array")
        }
        
        do{
            let data = try encoder.encode(model.inactiveArray)
            try data.write(to: inactiveFilePath!)
        } catch {
            print("error encoding item array")
        }

        do{
            let data = try encoder.encode(model.savedItems)
            try data.write(to: saveFilePath!)
        } catch {
            print("error encoding item array")
        }
        
        do{
            let data = try encoder.encode(model.projectArray)
            try data.write(to: projectsFilePath!)
        } catch {
            print("error encoding item array")
        }
        
//        self.projectItemsTable.reloadData()
    }
    
    
    
}
