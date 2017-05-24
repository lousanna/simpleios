import UIKit
import SwiftyJSON

class CakeTableViewController: UITableViewController {
    
    private var tableRows = [String]()
    private var rowID = [Int]()
    
    var valueToPass:String?
    var indexToPass:String?
    var myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableRows.removeAll()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        // todo Customize this url
        let task = session.dataTask(with: URL(string: "https://sinatralous.herokuapp.com/list?")!) { (data, response, error) in
            
            let json = JSON(data: data!)
            
            if let items = json.array {
                for item in items {
                    if let title = item["cake"].string {
                        self.tableRows.append(title)
                        let id = item["id"].int
                        self.rowID.append(id!)
                    }
                }
            }
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.myActivityIndicator.stopAnimating()
                self.myActivityIndicator.isHidden = true
            }
            
        }
        task.resume()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CakeTableCell", for: indexPath) as! CakeTableViewCell

        cell.configure(cakeName: tableRows[indexPath.row])

        return cell
    }

    
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Segue to the second view controller
        self.performSegue(withIdentifier: "mysegue", sender: self)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        valueToPass = tableRows[indexPath.row]
        indexToPass = String(describing: rowID[indexPath.row])
        
        let viewController = segue.destination as! EditViewController;
        viewController.passedValue = valueToPass
        viewController.identifier = indexToPass
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func combine(first: String?, last: String?) -> String {
        return [first, last].flatMap{$0}.joined(separator: "")
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let curr = String(describing: rowID[indexPath.row])

            let firstTodoEndpoint: String = combine(first: "https://sinatralous.herokuapp.com/list/",last: curr)

                print(firstTodoEndpoint)
                var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
                firstTodoUrlRequest.httpMethod = "DELETE"
            
                let session = URLSession.shared
                
                let task = session.dataTask(with: firstTodoUrlRequest) {
                    (data, response, error) in
                    guard let _ = data else {
                        print("Error")
                        return
                    }
                    print("DELETE ok")
                    
                    self.tableRows.remove(at: indexPath.row)
                    self.rowID.remove(at: indexPath.row)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                task.resume()

            
        }
    }
    

}
