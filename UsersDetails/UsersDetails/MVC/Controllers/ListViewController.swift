//
//  ViewController.swift
//  UsersDetails
//
//  Created by Surabhi Gupta on 7/11/19.
//  Copyright © 2019 Surabhi Gupta. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    private var login:String?
    private var name = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        self.navigationItem.title = Constants.title
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchingUsers()
    }
    
    private func registerNibs() {
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellName)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
        cell.textLabel?.text = name[indexPath.row]
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: Constants.main, bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.detailsVc) as? DetailsViewController
        vc?.username = name[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //MARK: Network handling
    func fetchingUsers() {
        APIHandler.networkCall(with: Constants.baseUrl) { (response) in
            switch response {
            case .success(let data):
                if let array = data as? Array<Dictionary<String,Any>> {
                    for object in array {
                        if let myname = object["login"] as? String {
                            self.name.append(myname)
                            self.listTableView.reloadData()
                        }
                    }
                }
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}

