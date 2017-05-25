//
//  NextViewController.swift
//  SimpleNetwork
//
//  Created by Lousanna Cai on 5/23/17.
//  Copyright © 2017 missiondata. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    @IBOutlet weak var cakeName: UILabel!
    
    // This variable will hold the data being passed from the Table
    var passedValue:String!
    var identifier:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if passedValue != nil {
            print(passedValue)
        } else {
            passedValue = "N/A"
        }
        
        print(identifier)
        
        cakeName.text = passedValue
    }

    @IBAction func goBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goAdd(_ sender: UIButton) {
        
        let firstTodoEndpoint: String = "https://sinatralous.herokuapp.com/list/" + passedValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        print(firstTodoEndpoint)
        var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
        firstTodoUrlRequest.httpMethod = "POST"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: firstTodoUrlRequest) {
            (data, response, error) in
            guard let _ = data else {
                print("Error")
                return
            }
            print("Added ok")

        }
        task.resume()
        self.dismiss(animated: true, completion: nil)
    }
}
