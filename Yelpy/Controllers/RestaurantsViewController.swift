//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var restaurantsArray: [[String: Any?]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getAPIData()
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getAPIData(){
        API.getRestaurants(){(restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData()// reload data!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        print("restaurant name")
        print(restaurant["name"]!!)
        print("restaurant data")
        print(restaurant)
        //Unwrap Optional type to obtain the Array of Dictonary<String,Any> objects we need for processing
        let categories = restaurant["categories"] as! [[String: Any]]
        
        print("categories type")
        print(type(of:categories))
        var categoriesText = ""
        var index = 0
        for category in categories {
            if let title = category["title"]{
                if(index < categories.count - 1){
                    categoriesText += String(title as! String + ", ")
                }
                else{
                    categoriesText += title as! String
                }
                index += 1
            }
        }
        cell.label.text = restaurant["name"] as? String ?? ""
        cell.categoriesLabel.text = categoriesText
        cell.phoneLabel.text = restaurant["display_phone"] as? String ?? ""
        cell.ratingsCount.text = restaurant["review_count"] as? String ?? ""
        let ratingsCount = restaurant["review_count"] as! NSNumber
        cell.ratingsCount.text = ratingsCount.stringValue
        let rating = restaurant["rating"] as! NSNumber
        switch rating{
        case 0: cell.ratingImage.image = UIImage(named: "regular_0")
            break
        case 1:
            cell.ratingImage.image = UIImage(named: "regular_1")
            break
            
        case 1.5:
            cell.ratingImage.image = UIImage(named: "regular_1_half")
            break
        case 2:cell.ratingImage.image = UIImage(named: "regular_2")
            break
        case 2.5:
            cell.ratingImage.image = UIImage(named: "regular_2_half")
            break
        case 3:
            cell.ratingImage.image = UIImage(named: "regular_3")
            break
        case 3.5:
            cell.ratingImage.image = UIImage(named: "regular_3_half")
            break
        case 4:
            cell.ratingImage.image = UIImage(named: "regular_4")
            break
        case 4.5:
            cell.ratingImage.image = UIImage(named: "regular_4_half")
            break
        case 5:
            cell.ratingImage.image = UIImage(named: "regular_5")
            break
            
        default:
            break
        }
        if let imageUrlString = restaurant["image_url"] as? String{
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        return cell
    }
}


