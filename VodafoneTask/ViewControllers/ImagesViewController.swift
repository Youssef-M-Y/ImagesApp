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
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getData(page: page)
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData(page: Int){
        ApiRequest(method: "GET", url: "https://picsum.photos/v2/list?page=\(page)&limit=10") {[weak self] (response, data) in
            if response.statusCode/100 == 2{
                let decoder = JSONDecoder()
                do{
                    let imagesResponse = try decoder.decode([ImageModel].self, from: data!)
                    self?.imagesResponse.append(contentsOf: imagesResponse)
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
        images = []
        
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
        return imagesResponse.count + imagesResponse.count/5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! ImagesCell
        if (indexPath.row + 1) % 6 == 0{
            cell.myImage.image = #imageLiteral(resourceName: "ad placeholder")
            cell.authorName.text = ""
        }
        else {
            cell.myImage.image = images[indexPath.row - indexPath.row/6]
            cell.authorName.text = imagesResponse[indexPath.row - indexPath.row/6].author
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row - indexPath.row/6 == imagesResponse.count - 1){
            self.page += 1
            self.getData(page: self.page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
