//
//  ImageDetailsViewController.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/30/21.
//

import UIKit

class ImageDetailsViewController: UIViewController {
    var selectedImage: ImageModel?
    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureImageAndAuthor()
    }
    
    func configureImageAndAuthor(){
        let url = URL(string: selectedImage!.downloadURL)
        fullImage.kf.setImage(with: url)
        authorName.text = selectedImage?.author
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    

}
