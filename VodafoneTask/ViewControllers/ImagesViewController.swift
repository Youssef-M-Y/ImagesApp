//
//  ImagesViewController.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/27/21.
//

import UIKit
import Kingfisher

class ImagesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "ImagesCell"
    var imagesResponse = [ImageModel]()
    var page = 1
    var selectedImage: ImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData(page: Int){
        DispatchQueue.global().async {
            ApiRequest(page: "\(page)") {[weak self] (response, data) in
                let decoder = JSONDecoder()
                do{
                    let imagesResponse = try decoder.decode([ImageModel].self, from: data!)
                    self?.imagesResponse.append(contentsOf: imagesResponse)
                    DispatchQueue.main.sync {
                        self?.tableView.reloadData()
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
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
            let url = URL(string:imagesResponse[indexPath.row - indexPath.row/6].downloadURL)
            cell.myImage.kf.setImage(with: url)
            cell.authorName.text = imagesResponse[indexPath.row - indexPath.row/6].author
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if imagesResponse.count == 0{
            return
        }
        if(indexPath.row  == imagesResponse.count - 1){
            self.page += 1
            self.getData(page: self.page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedImage = imagesResponse[indexPath.row - indexPath.row/6]
        performSegue(withIdentifier: "toImageDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ImageDetailsViewController
        destination.selectedImage = selectedImage
    }
    
}
