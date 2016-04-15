//
//  NewsTableViewController.swift
//  radaRSSNews
//
//  Created by Osadchy Dima on 4/13/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, FeedParserDelegate {

    @IBOutlet weak var menuButton:UIBarButtonItem!

    var feedParser: FeedParser?
    
    private struct Constants {
        static let NewsRadaURL = "http://rada.gov.ua/rss/news/Novyny"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.feedParser = FeedParser(feedURL: Constants.NewsRadaURL)
        self.feedParser?.delegate = self
        self.feedParser?.parse()
        
        
        //set up view controller
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 3
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
        
        // Configure the cell...
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "news0")
            cell.postTitleLabel.text = "В. Гройсман: Переконаний у тому, що усі виклики у країні будуть подолані, а ситуація буде стабілізована"
            cell.authorLabel.text = "Прес-секретар Голови Верховної Ради України"
            cell.authorImageView.image = UIImage(named: "author")
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "news1")
            cell.postTitleLabel.text = "Відбулося вечірнє пленарне засідання Верховної Ради України"
            cell.authorLabel.text = "Інформаційне управління"
            cell.authorImageView.image = UIImage(named: "authorRada")
            
        } else {
            cell.postImageView.image = UIImage(named: "news2")
            cell.postTitleLabel.text = "Представники бізнесу, депутатського корпусу та експертного середовища вважають за необхідне посилити позиції українських виробників на міжнародних ринках"
            cell.authorLabel.text = "Інформаційне управління"
            cell.authorImageView.image = UIImage(named: "authorRada")
            
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return NO if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return NO if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
}
