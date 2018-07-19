//
//  ReviewsTableViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var reviewsTableViewController: UITableView!
    @IBOutlet weak var yelpButton: UIButton!
    @IBOutlet weak var viewForYelpButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsTableViewController.delegate = self
        reviewsTableViewController.dataSource = self
        
        initializeYelpButtonView()
    }
    
    // MARK: - IBActions
    
    @IBAction func yelpButtonTapped(_ sender: Any) {
        openURL(urlStr: "http://www.yelp.com")
        print("yelp button tapped")
    }
    
    // MARK: - Properties
    var reviews: Reviews?
    
    func initializeYelpButtonView() {
        
        viewForYelpButton.clipsToBounds = true
        viewForYelpButton.layer.masksToBounds = false
        viewForYelpButton.layer.shadowRadius = 7.0
        viewForYelpButton.layer.shadowColor = UIColor.lightGray.cgColor
        viewForYelpButton.layer.shadowOpacity = 0.4
        viewForYelpButton.layer.shadowOffset = CGSize.zero
        viewForYelpButton.layer.shouldRasterize = true
    }
    
    func openURL(urlStr: String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
}

extension ReviewsViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        
        // Configure the cell...
        
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
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
