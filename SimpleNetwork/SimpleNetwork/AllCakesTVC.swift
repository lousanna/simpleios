import UIKit
import SwiftyJSON

class AllCakesTVC: UITableViewController {
    
    private var tableRows = [String]()
    
    var valueToPass:String?
    var myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableRows.removeAll()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)

        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        // todo Customize this url
        let task = session.dataTask(with: URL(string: "https://sinatralous.herokuapp.com/filelist?")!) { (data, response, error) in
            
            let json = JSON(data: data!)

            if let items = json.array {
                for item in items {
                    if let title = item["cake"].string {
                        self.tableRows.append(title)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CakeTableCell2", for: indexPath) as! CakeTableViewCell
        
        cell.configure(cakeName: tableRows[indexPath.row])
        
        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Segue to the second view controller
        self.performSegue(withIdentifier: "allsegue", sender: self)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

        let indexPath = tableView.indexPathForSelectedRow!
        valueToPass = tableRows[indexPath.row]
        
        let viewController = segue.destination as! NextViewController;
        viewController.passedValue = valueToPass
        viewController.identifier = segue.identifier
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
}
