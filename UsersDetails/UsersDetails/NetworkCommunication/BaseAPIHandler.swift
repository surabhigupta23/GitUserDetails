//
//  BaseAPIHandler.swift
//  UsersDetails
//
//  Created by Surabhi Gupta on 7/11/19.
//  Copyright © 2019 Surabhi Gupta. All rights reserved.
//

import Foundation
import Alamofire

enum ApiStatus {
    case success(Any)
    case error(Error)
}

class APIHandler {
    
    //Image handling
    static func fetchImageFromURL(imageView:UIImageView, url:String) {
        //The image to download
        guard let remoteURLImage = URL(string: url) else {
            print("Image not available")
            return
        }
        //Use alamofire to download the image
        Alamofire.request(remoteURLImage).responseData { (response) in
            if response.error == nil
            {
                //Show the downloaded image
                if let data = response.data {
                    imageView.image = UIImage (data: data)
                }
            }
        }
    }
    
    //MARK: Network handling
    static func networkCall(with url: String, completionHanlder : @escaping (ApiStatus)->Void ) {
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                completionHanlder(ApiStatus.success(data))
            case .failure(let error):
                completionHanlder(ApiStatus.error(error))
            }
        }
    }
}
