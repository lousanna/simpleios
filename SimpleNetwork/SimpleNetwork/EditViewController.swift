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
        
        cakeName.text = passedValue
        editText.text = passedValue
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func goEdit(_ sender: UIButton) {
        
        let firstTodoEndpoint: String = "https://sinatralous.herokuapp.com/list/" + identifier + "/" + editText.text!
        
        var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint.replacingOccurrences(of: " ", with: "%20"))!)
        print(firstTodoEndpoint)
        firstTodoUrlRequest.httpMethod = "PUT"
        
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

