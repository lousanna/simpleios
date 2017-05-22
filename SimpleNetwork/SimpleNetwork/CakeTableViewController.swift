import UIKit

class CakeTableViewController: UITableViewController {
    
    private var tableRows = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // todo Customize this url
        let task = session.dataTask(with: URL(string: "https://httpbin.org/get")!) { (data, response, error) in

            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let cakeDataArrayHash = json as? [Any] {
                cakeDataArrayHash.forEach({ (value) in
                    if let cakeDataHash = value as? [String:Any] {
                        // todo customize this
                        // self.tableRows.append(cakeDataHash["avalue"] as! String)
                    }
                })
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
