//
//  ViewController.swift
//  Hadi-Note-App
//
//  Created by Hadi on 26/05/2021.
//

import UIKit

class ViewController: UIViewController, DataChange {
    
    func onChangeData() {
        fetchData()
    }
    

    @IBOutlet weak var uiTableView: UITableView!
    
    var data:[Note] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiTableView.dataSource = self
        uiTableView.delegate = self
        
        fetchData()
    }

    @IBAction func btnAddNote(_ sender: UIButton) {
      move(note: nil)
    }
    
    fileprivate func fetchData(){
        do{
            self.data = try context.fetch(Note.fetchRequest())
            DispatchQueue.main.async {
                self.uiTableView.reloadData()
            }

        }catch{
            
        }
    }
    
    func move(note:Note?){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewC = storyBoard.instantiateViewController(withIdentifier: "AddNote") as! AddNoteViewController
        viewC.onChange = self
        viewC.note = note
               present(viewC, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        let text = data[indexPath.row].title
        cell.textLabel?.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        move(note: data[indexPath.row])
        

    }
    
    // to delete the item
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {return}
        let lineToRemove = self.data[indexPath.row]
        do{
            try self.context.delete(lineToRemove)
        }catch{
            
        }
        self.fetchData()
    }

    
    
}

