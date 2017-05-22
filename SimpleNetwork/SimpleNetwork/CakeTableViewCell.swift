import UIKit

class CakeTableViewCell: UITableViewCell {

    @IBOutlet weak var cakeNameLabel: UILabel!
    
    func configure(cakeName:String) -> Void {
        cakeNameLabel.text = cakeName
    }
    
}
