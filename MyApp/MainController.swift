//
//  MainController.swift
//  MyApp
//
//  Created by Juan Andonaire on 3/18/18.
//  Copyright © 2018 Juan Andonaire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadPosts()
        
    }
    
    func loadPosts(){
        Database.database().reference().child("sensor/humiditytemp").observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any]{
                
                let tempValue = dict["Temp"] as! String
                let humidityValue = dict["Humidity"] as! String 
                let post = Post(tempValue: tempValue, humidityValue: humidityValue)
                self.posts.append(post)
                print(self.posts)
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.detailTextLabel?.text = posts[indexPath.row].humidity
        //cell.detailTextLabel?.text = posts[indexPath.row].temp
        return cell
    }
    
    
    

    //SIGNING OUT
    @IBAction func signout(_ sender: Any) {
        self.performSegue(withIdentifier: "loggedout", sender: self)
        let logoutAlert = UIAlertController(title: "LOG OUT", message: "You have logged out successuflly", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
            
        }))
        self.present(logoutAlert, animated: true, completion: nil)
        do{
            try Auth.auth().signOut()
        } catch{
            //handle error
        }
    }
    
}
