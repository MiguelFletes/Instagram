//
//  UploadViewController.swift
//  instagram
//
//  Created by Michael Fletes on 2/25/18.
//  Copyright © 2018 Michael Fletes. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var upload: UIImageView!
    @IBOutlet weak var caption: UITextField!
    
    
    @IBAction func onCancel(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
    }
    @IBAction func onShare(_ sender: Any) {
        
        let post = Post()
        post.author = PFUser.current()!
        
        Post.postUserImage(image: upload.image, withCaption: caption.text) { (user, Error) in
            if (user != nil) {
                NotificationCenter.default.post(name: NSNotification.Name("didShare"), object: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        upload.isUserInteractionEnabled = true
        upload.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
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
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        upload.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
