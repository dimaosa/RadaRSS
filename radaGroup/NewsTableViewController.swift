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

    var parser: FeedParser?
    var entries: [FeedItem]?
    private struct Constants {
        static let NewsRadaURL = "http://rada.gov.ua/rss/news/Novyny"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()

        entries = []
        loadData()
        
        
        //set up view controller
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUpTableView()
        
    }
    func setUpTableView() {
        
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
    }
    
    func loadData() {
        // start parsing feed
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            self.parser = FeedParser(feedURL: Constants.NewsRadaURL)
            self.parser?.delegate = self
            self.parser?.parse()
        })
        
    }
    
    // MARK: - FeedParserDelegate methods
    
    func feedParser(parser: FeedParser, didParseChannel channel: FeedChannel) {
        // Here you could react to the FeedParser identifying a feed channel.
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            print("Feed parser did parse channel \(channel)")
        })
    }
    
    func feedParser(parser: FeedParser, didParseItem item: FeedItem) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            print("Feed parser did parse item \(item.feedTitle)")
            self.entries?.append(item)
            print(self.entries?.count)
        })
    }
    
    func feedParser(parser: FeedParser, successfullyParsedURL url: String) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if (self.entries?.count > 0) {
                print("All feeds parsed.")
                self.tableView.reloadData()
            } else {
                print("No feeds found at url \(url).")
            }
        })
    }
    
    func feedParser(parser: FeedParser, parsingFailedReason reason: String) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            print("Feed parsed failed: \(reason)")
            self.entries = []
        })
    }
    
    func feedParserParsingAborted(parser: FeedParser) {
        print("Feed parsing aborted by the user")
        self.entries = []
    }
    
    
    // MARK: - UITableViewDelegate/DataSource methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return entries?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
        let item = entries![indexPath.row]

        //image
        cell.postImageView.image = UIImage(named: "rada")
        cell.postTitleLabel.text = item.feedTitle ?? "Untitled feed"
        cell.authorLabel.text = item.feedAuthor ?? ""
        cell.authorImageView.image = UIImage(named: "author")
        print("------------- \(item.feedPubDate)")
        cell.dateLabel.text = item.feedPubDate?.dateStringWithFormat("HH:mm dd-MM-yyyy") ?? "a long time ago"
        
//        
//        // subtitle
//        if let subtitleLabel = cell.viewWithTag(3) as? UILabel {
//            subtitleLabel.text = item.feedContentSnippet ?? item.feedContent?.stringByDecodingHTMLEntities() ?? ""
//        }
//        
//
//        // Configure the cell...
//        if indexPath.row == 0 {
//            cell.postImageView.image = UIImage(named: "news0")
//            cell.postTitleLabel.text = "В. Гройсман: Переконаний у тому, що усі виклики у країні будуть подолані, а ситуація буде стабілізована"
//            cell.authorLabel.text = "Прес-секретар Голови Верховної Ради України"
//            cell.authorImageView.image = UIImage(named: "author")
//            
//        } else if indexPath.row == 1 {
//            cell.postImageView.image = UIImage(named: "news1")
//            cell.postTitleLabel.text = "Відбулося вечірнє пленарне засідання Верховної Ради України"
//            cell.authorLabel.text = "Інформаційне управління"
//            cell.authorImageView.image = UIImage(named: "authorRada")
//            
//        } else {
//            cell.postImageView.image = UIImage(named: "news2")
//            cell.postTitleLabel.text = "Представники бізнесу, депутатського корпусу та експертного середовища вважають за необхідне посилити позиції українських виробників на міжнародних ринках"
//            cell.authorLabel.text = "Інформаційне управління"
//            cell.authorImageView.image = UIImage(named: "authorRada")
//            
//        }
//        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let feedItem = entries?[indexPath.row] {
            if let url = NSURL(string: feedItem.feedLink ?? "") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return NO if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */
    
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
