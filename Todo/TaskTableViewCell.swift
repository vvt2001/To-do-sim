//
//  TaskTableViewCell.swift
//  Todo
//
//  Created by Vũ Việt Thắng on 13/04/2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    //create delegate
    var delegate: TaskTableViewCellDelegate?
    
    @IBOutlet weak var finishedButton: UIButton!
    @IBOutlet weak var importantButton: UIButton!
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var myDayLabel: UILabel!
    @IBOutlet weak var seperator1: UILabel!
    @IBOutlet weak var seperator2: UILabel!
    
    var task: Task!
    var listStore: ListStore!
    var isEditMode: Bool! = false
    var fromTasks: Bool! = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 0.1
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.backgroundColor = .white
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    @IBAction func changeFinished(_ sender: UIButton){
//        if self.finishedButton.imageView?.image == UIImage(systemName: "checkmark.circle"){
//            self.finishedButton.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
//        }
//        else {
//            self.finishedButton.imageView?.image = UIImage(systemName: "checkmark.circle")
//        }
        //call function for view controller to do
        //equal to viewcontroller.(func)
        if isEditMode == false{
            delegate?.taskTableViewCell(self, didTapFinishButtonWithTask: task)
        }
        else{
            delegate?.taskTableViewCell(self, didTapCheckButtonWithTask: task)
        }
    }
    @IBAction func changeImportant(_ sender: UIButton){
//        if !task.isImportant{
//            self.importantButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
//        }
//        else{
//            self.importantButton.setImage(UIImage(systemName: "star"), for: .normal)
//        }
        if isEditMode == false{
            delegate?.taskTableViewCell(self, didTapImportantButtonWithTask: task)
        }
    }
    
    func createCell(name: String){
        self.taskName.text = name
        if isEditMode == false{
            if task.getIsFinished(){
                self.finishedButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                //self.finishedButton.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
            }
            else{
                self.finishedButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
            if task.getIsImportant(){
                self.importantButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            else{
                self.importantButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
            importantButton.isHidden = false
        }
        else{
            if task.getIsSelected(){
                self.finishedButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            }
            else{
                self.finishedButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }
            importantButton.isHidden = true
        }
        if task.getDueDate() != nil{
            let dueDateDayOfWeek = task.getDueDate()!.dayofTheWeek
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yy"
            let dueDate = dateFormater.string(from: task.getDueDate()!)
            self.taskDueDateLabel.text = dueDateDayOfWeek + ", " + dueDate
        }
        else{
            self.taskDueDateLabel.text = ""
        }
        if task.getIsMyDay(){
            self.myDayLabel.text = "My Day"
        }
        else{
            self.myDayLabel.text = ""
        }
        
        if task.getListId() != ""{
            for list in listStore.allList{
                if list.getListID() == task.getListId(){
                    self.listNameLabel.text = list.getName()
                }
            }
        }
        else {
            self.listNameLabel.text = "Tasks"
        }
        
        if self.myDayLabel.text != "" && self.listNameLabel.text != ""{
            self.seperator1.text = "   |   "
        }
        else if self.myDayLabel.text != "" && self.taskDueDateLabel.text != ""{
            self.seperator1.text = "   |   "
        }
        else{
            self.seperator1.text = ""
        }
        if self.listNameLabel.text != "" && self.taskDueDateLabel.text != ""{
            self.seperator2.text = "   |   "
        }
        else{
            self.seperator2.text = ""
        }
    }
}

//create protocol to modify table through cell's button
//cell can't modify table on it's own, and view controller can't access button functions on the cells
protocol TaskTableViewCellDelegate {
    func taskTableViewCell(_ cell: TaskTableViewCell, didTapFinishButtonWithTask task: Task)
    func taskTableViewCell(_ cell: TaskTableViewCell, didTapImportantButtonWithTask task: Task)
    func taskTableViewCell(_ cell: TaskTableViewCell, didTapCheckButtonWithTask task: Task)
//    func taskTableViewCellDidTapFinishButton(_ cell: TaskTableViewCell)
//    func taskTableViewCell(didTapFinishButton cell: TaskTableViewCell)
}

