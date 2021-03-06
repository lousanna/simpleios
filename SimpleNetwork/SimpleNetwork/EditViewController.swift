//
//  EditViewController.swift
//  SimpleNetwork
//
//  Created by Lousanna Cai on 5/23/17.
//  Copyright © 2017 missiondata. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var cakeName: UILabel!
    
    @IBOutlet weak var EditButton: UIButton!
    // This variable will hold the data being passed from the Table
    @IBOutlet weak var editText: UITextField!
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
        editText.text = passedValue
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func goEdit(_ sender: UIButton) {

        let jsonIn: [[String:Any]] = [["id": identifier,
                                         "cake": editText.text!]]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonIn, options: [])
        
        let firstTodoEndpoint: String = "https://sinatralous.herokuapp.com/upload?"

        var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
        firstTodoUrlRequest.httpMethod = "POST"
        firstTodoUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        firstTodoUrlRequest.httpBody = jsonData
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.dismiss(animated: true, completion: nil)
        })

    }

    @IBAction func finishedEdit(_ sender: UITextField) {
        
        self.goEdit(EditButton)
    }
}

