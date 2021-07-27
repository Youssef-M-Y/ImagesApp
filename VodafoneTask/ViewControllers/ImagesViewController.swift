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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ImagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ImagesCell
        return cell
    }
    
    
}
