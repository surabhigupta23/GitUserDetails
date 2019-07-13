
import Foundation

class UserModel {
	let avatar_url : String?
	let name : String?
	let company : String?
	let blog : String?
	let location : String?
	let email : String?
    

    init(from Dict: Dictionary<String,Any>) {
        self.avatar_url = Dict["avatar_url"] as? String ?? ""
        self.name = Dict["name"] as? String ?? ""
        self.company = Dict["company"] as? String ?? ""
        self.blog = Dict["blog"] as? String ?? ""
        self.location = Dict["location"] as? String ?? ""
        self.email = Dict["email"] as? String ?? ""
    }
    
}
