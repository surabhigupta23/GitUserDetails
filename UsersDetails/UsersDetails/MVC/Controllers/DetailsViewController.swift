//
//  DetailsViewController.swift
//  UsersDetails
//
//  Created by Surabhi Gupta on 7/12/19.
//  Copyright © 2019 Surabhi Gupta. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var username:String?
    var userDetails:UserModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserDetails()
    }
    
    private func updateUI() {
        
        userNameLabel.text = username
        locationLabel.text = userDetails?.location
        APIHandler.fetchImageFromURL(imageView: avatarImageView, url: (userDetails?.avatar_url)!)
        avatarImageView.layer.cornerRadius = 8.0
        avatarImageView.clipsToBounds = true
        blogLabel.text = userDetails?.blog
        companyNameLabel.text = userDetails?.company

    }
    
    
    func getUserDetails() {
        APIHandler.networkCall(with: "\(Constants.baseUrl)/\(username ?? "")") { (response) in
            switch response {
            case .success(let data):
                if let Object = data as? Dictionary<String,Any> {
                    self.userDetails = UserModel(from: Object)
                    self.updateUI()
                }
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}
