//
//  FeedViewController.swift
//  instagram
//
//  Created by Michael Fletes on 2/25/18.
//  Copyright © 2018 Michael Fletes. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableFeed: UITableView!
    var posts: [PFObject]?
    var i: [UIImage] = []
    var captions: [String] = []
    var likes: [String] = []
    var times: [String] = []
    var authors: [String] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFeed.dataSource = self
        // Do any additional setup after loading the view.
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableFeed.insertSubview(refreshControl, at: 0)
        fetchData()
    }
    
    func fetchData(){
        
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts: [PFObject]?, error: Error?) in
            if posts != nil {
                // do something with the data fetched
                self.posts = posts
                self.tableFeed.reloadData()
                self.refreshControl.endRefreshing()
                for post in posts! {
                    // access the object as a dictionary and cast type
                    print(post.value(forKey: "caption") as! String)
                    //post.value(forKey: "image") as! UIImage
                    
                }
            } else {
                // handle error
                print(error?.localizedDescription as Any)
            }
            } as? ([PFObject]?, Error?) -> Void)
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(posts != nil){
            return (posts?.count)!
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("indexPath: ", indexPath)
        if(posts != nil) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! tableCell
            
            let post = posts![indexPath.row]
            let caption = post.value(forKey: "caption")
            captions.append(caption as! String)
            let picture = post.value(forKey: "media") as! PFFile
            //let author = post.value(forKey: "_p_author") as! PFFile
            //print(author)
            //post.author = PFUser.current()
            
            //authors.append(author as! String)
            
            //let like = post.value(forKey: "likesCount")
            //likes.append(like as! String)
            
            //let time = post.value(forKey: "_created_at")
            //times.append(time as! String)
            
            if(picture != nil) {
                picture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                    let image = UIImage(data: imageData!)
                    if image != nil {
                        cell.photoView.image = image
                        self.i.append(image!)
                        //self.tableFeed.reloadData()
                    }
                })
            }
            
            cell.captionLabel.text = caption as! String
            
            return cell
        }
        //cell.caption.text = "nothing"
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! tableCell
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Sends the Photo that what clicked
        let destinationViewController = segue.destination as! PhotoDetailsViewController
        //let cell;.photoView.image = image
        let index = tableFeed.indexPathForSelectedRow?.row
        destinationViewController.newPhoto = self.i[index!]
        destinationViewController.newCaption = self.captions[index!]
        //destinationViewController.newTimeStamp = self.times[index!]
        //destinationViewController.newAuthor = self.authors[index!]
        //destinationViewController.newLikes = self.likes[index!]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        /*PFUser.logOutInBackground { (error) in
         // PFUser.current() will now be nil
         }*/
    }
    
    @IBAction func onCompose(_ sender: Any) {
        //self.performSegue(withIdentifier: "composeSegue", sender: nil)
        NotificationCenter.default.post(name: NSNotification.Name("upload"), object: nil)
    }
    
    
    
}
