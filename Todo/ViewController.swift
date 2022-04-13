//
//  ViewController.swift
//  To Do Clone
//
//  Created by Vũ Việt Thắng on 08/04/2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet var email: UILabel!
    @IBOutlet var selectionTable: UITableView!
    @IBOutlet var newList: UIButton!
    @IBOutlet var addListField: UITextField!
    
    var listStore: ListStore!
    let taskStore = TaskStore()
    var listArr = [List]()
    
    @IBAction func addList(_ sender: UIButton){
        let newList = listStore.createList(name: addListField.text)
        var indexPath = IndexPath()
        
        if let index = listStore.allList.firstIndex(of: newList){
            indexPath = IndexPath(row: index, section: 1)
        }
        selectionTable.insertRows(at: [indexPath], with: .automatic)
        listArr.append(newList)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        email.text = "thangvv@solarapp.asia"
        selectionTable.delegate = self
        selectionTable.dataSource = self
        self.selectionTable.register(UINib(nibName: "SelectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SelectionTableViewCell")
        
        selectionTable.rowHeight = 60
        //selectionTable.estimatedRowHeight = 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionTableViewCell", for: indexPath) as! SelectionTableViewCell
        if indexPath.section == 0{
            cell.createOptionCell(index: indexPath.row)
        }
        else{
            cell.createListCell(name: listStore.allList[indexPath.row].name, taskCount: "\(listStore.allList[indexPath.row].unfinishedTask.count)")
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 5
        }
        else{
            return listStore.allList.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row{
            case 0:
                print("myday")
                let myDayViewController = MyDayViewController(nibName: "MyDayViewController", bundle: .main)
//                let taskStore = TaskStore()
                myDayViewController.taskStore = taskStore
                
                navigationController?.pushViewController(myDayViewController, animated: true)
                
//            case 4:
//                print("alltask")
//                let TasksViewController = TaskViewController
            default:
                print("wrong")
            }
        }
        else{
            let listViewController = ListViewController(nibName: "ListViewController", bundle: .main)
            listViewController.list = listArr[indexPath.row]
            navigationController?.pushViewController(listViewController, animated: true)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "" : "Lists"
    }
}
