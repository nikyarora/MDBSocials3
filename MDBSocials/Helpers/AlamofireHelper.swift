//
//  AlamofireHelper.swift
//  MDBSocials
//
//  Created by Niky Arora on 3/14/18.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class AlamofireHelper {
    
    static func getPosts() -> Promise<[Post]> {
        return Promise { fufill, error in
            Alamofire.request("https://mdbsocials2.herokuapp.com/posts").responseJSON { response in
                if let response = response.result.value {
                    let json = JSON(response)
                    var postArray: [Post] = []
                    for val in json {
                        if let result = val.1.dictionaryObject {
                            if let post = Post(JSON: result){
                                postArray.append(post)
                            }
                        }
                    }
                    fufill(postArray)
                }
            }
        }
    }
    
    static func getUserWithId(id: String) -> Promise<UserModel> {
        return Promise { fulfill, error in
            Alamofire.request("https://mdbsocials2.herokuapp.com/user/\(id)").responseJSON { response in
                if let response = response.result.value {
                    let json = JSON(response)
                    if let result = json.dictionaryObject {
                        if let user = UserModel(JSON: result){
                            fulfill(user)
                        }
                    }
                }
            }
        }
    }
}
