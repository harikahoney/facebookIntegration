//
//  ViewController.swift
//  facebookIntegration
//
//  Created by Sagi Harika on 22/01/20.
//  Copyright © 2020 Sagi Harika. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare
class ViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn(_ sender: Any) {
        let loginManager=LoginManager()
        
        loginManager.logIn(permissions: [.publicProfile,.userFriends], viewController: self) { (result) in
            self.loginResult(result: result)
        }
    }
    
    func loginResult(result:LoginResult)
        
    {
        switch result {
    case .cancelled:
            print("login cancelled")
            
    case .failed(let error):
                       print("login failed")
case .success(let granted,let declined,let letaccesstoken):
    var target = storyboard?.instantiateViewController(identifier: "facebook") as! SecondViewController
    
    present(target, animated: true, completion: nil)
    
    
            print("login success")
        }
    }
}

