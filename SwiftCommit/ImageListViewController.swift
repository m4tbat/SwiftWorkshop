//
//  ViewController.swift
//  SwiftCommit
//
//  Created by Matteo Battaglio on 18/03/15.
//  Copyright (c) 2015 Matteo Battaglio. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var images: [UIImage]? = []
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrls = ["http://pngimg.com/upload/apple_PNG4939.png",
            "http://pngimg.com/upload/banana_PNG842.png",
            "http://pngimg.com/upload/cherry_PNG3091.png",
            "http://pngimg.com/upload/lemon_PNG3874.png",
            "http://pngimg.com/upload/raspberry_PNG5074.png"]
        
        let session = NSURLSession.sharedSession()
        
        let completionHandler = { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            self.images?.append(UIImage(data: data)!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        
        imageUrls.map() { imageUrl in
            session.dataTaskWithURL(NSURL(string: imageUrl)!, completionHandler: completionHandler).resume()
        }
        
    }

    // MARK: Table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ImageCell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        cell.contentImageView.image = images?[indexPath.row] ?? nil
        return cell
    }

}

