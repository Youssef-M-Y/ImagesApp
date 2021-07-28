//
//  ImagesViewController.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/27/21.
//

import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "ImagesCell"
    var imagesResponse = [ImageModel]()
    var images: [UIImage] = [] {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var count: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getData()
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData(){
        ApiRequest(method: "GET", url: "https://picsum.photos/v2/list?page=1&limit=10") {[weak self] (response, data) in
            if response.statusCode/100 == 2{
                let decoder = JSONDecoder()
                do{
                    let imagesResponse = try decoder.decode([ImageModel].self, from: data!)
                    self?.imagesResponse = imagesResponse
                    self?.loadImages()
                    print(self?.imagesResponse)
                }
                catch{
                    print(error.localizedDescription)
                }
            }
            else {
                print(response)
            }
        }
    }
    
    private func loadImages(){
        let group = DispatchGroup()
        
        group.enter()
        for imageResponse in imagesResponse{
            images.append(HelperMethods.loadImage(urlString: imageResponse.downloadURL))
        }
        group.leave()
        
    }
}

extension ImagesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count + images.count/5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! ImagesCell
        if (indexPath.row + 1) % 6 == 0{
            cell.myImage.image = #imageLiteral(resourceName: "ad placeholder")
        }
        else {
            cell.myImage.image = images[indexPath.row - indexPath.row/6]
        }
        
        return cell
    }
    
    
}
