//
//  ViewController.swift
//  NoteApp
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data:[String] = []
    var selectedRow:Int = -1
    var updatedText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        self.title = "Notes"

        let buttonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNotes))
        self.navigationItem.rightBarButtonItem = buttonItem
        
        load()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedRow == -1 {
            return
        }
        
        data[selectedRow] = updatedText
        tableView.reloadData()
        save()
    }
    
    // MARK: - Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let tableViewCell : UITableViewCell = UITableViewCell()
        let tableViewCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        tableViewCell.textLabel?.text = data[indexPath.row]
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Selected Row \(indexPath.row)")
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "detailsegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController : DetailViewController = segue.destination as! DetailViewController
        let selectedRow:Int = tableView.indexPathForSelectedRow!.row
        detailViewController.detailViewControllerDelegate = self
        detailViewController.setText(txt: data[selectedRow])
        
    }

    
    @objc func addNotes() {
        let name : String = "Notes : \(data.count + 1)"
        data.insert(name, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        save()
        selectedRow = 0
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detailsegue", sender: nil)

    }
    
    //MARK: - Userdefault methods
    func load() {
        if let loadedData:[String] = UserDefaults.standard.value(forKey: "dataset") as? [String] {
            data = loadedData
            tableView.reloadData()
        }
    }
    
    func save() {
        UserDefaults.standard.set(data, forKey: "dataset")
    }
    
    func updateText(newText:String) {
        updatedText = newText
    }

}

