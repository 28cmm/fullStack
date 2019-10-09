//
//  Post.swift
//  fullStack
//
//  Created by Yilei Huang on 2019-10-07.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import Foundation

struct Post: Decodable{
    let id: String
    let text: String
    let createdAt: Int
    let user: User
    let imageUrl:String
}

struct User:Decodable{
    let id: String
    let fullName: String
}

