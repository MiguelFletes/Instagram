//
//  PhotoDetailsViewController.swift
//  instagram
//
//  Created by Michael Fletes on 2/26/18.
//  Copyright © 2018 Michael Fletes. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBAction func backButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didBack"), object: nil)
    }
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    var newPhoto: UIImage!
    var newCaption: String = ""
    var newLikes: String = ""
    var newAuthor: String = ""
    var newTimeStamp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photo.image = newPhoto
        authorLabel.text = newAuthor
        timeStampLabel.text = newTimeStamp
        captionLabel.text = newCaption
        likesLabel.text = newLikes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
