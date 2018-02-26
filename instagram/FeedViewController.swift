//
//  FeedViewController.swift
//  instagram
//
//  Created by Michael Fletes on 2/25/18.
//  Copyright © 2018 Michael Fletes. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        
        
        // fetch data asynchronously
        
        /*query?.findObjectsInBackground(block: { (posts: [Post], error: Error?) in
            if let posts = posts {
                // do something with the data fetched
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        })*/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onUpload(_ sender: Any) {
    
    let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        self.present(vc, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [String : Any]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            let post = Post()
            
            // get the current user and assign it to "author" field. "author" field is now of Pointer type
            post.author = PFUser.current()!
            
            // Do something with the images (based on your use case)
            //post.postUserImage(editedImage, "caption", PFBooleanResultBlock)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismiss(animated: true, completion: nil)
        }
    }
    
    

}
