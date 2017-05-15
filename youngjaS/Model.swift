//
//  Member.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 6..
//  Copyright © 2017년 BWG. All rights reserved.
//

import ObjectMapper

class User: Mappable {
    var id: String?
    var username: String?
    var joinname: String?
    var type: String?
    var createdAt: String?
    var lastModified: String?
    var userEmails: [String]?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        joinname <- map["joinname"]
        type <- map["type"]
        createdAt <- map["createdAt"]
        lastModified <- map["lastModified"]
        userEmails <- map["userEmails"]
    }
}

class Member: Mappable {
    var embedded: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        embedded <- map["_embedded"]
    }
}

class CircleList: Mappable {
    var members: [Memberr]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        members <- map["_embedded.members"]
    }
}

class Memberr: Mappable {
    var memberId: String?
    var memberUserId: String?
    var circleId: String?
    var circleName: String?
    var circleDescription: String?
    var circleBackImageUrl: String?
    var circleMemberRole: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        memberId <- map["id"]
        memberUserId <- map["memberUserId"]
        circleId <- map["circle.id"]
        circleName <- map["circle.name"]
        circleDescription <- map["circle.description"]
        circleBackImageUrl <- map["circle.backgroundImage.thumbnailUrl"]
        circleMemberRole <- map["role"]
    }
}

class NewsList: Mappable {
    var articles: [Article]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        articles <- map["_embedded.articles"]
    }
}

class UserMe: Mappable {
    var userEmails: [UserEmail]?
    var id: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        userEmails <- map["userEmails"]
    }
}

class Image: Mappable {
    var imageId: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        imageId <- map["imageId"]
    }
}

class UserEmail: Mappable {
    var email: String?
    var userId: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        email <- map["id.email"]
        userId <- map["id.userId"]
    }
}

class Article: Mappable {
    var articleId: String?
    
    var profileName: String?
    var profileImageThumbnailUrl: String?
    var circleId: String?
    
    var thumbnail: String?
    var text: String?
    var circleName: String?
    var createdAt: String?
    var commentCount: Int?
    var feelingGoodCount: Int?
    var feelingGoodByMe: Bool?
    var isNotice: Bool?
    var articleWriterId: String?
    
    var imageContents: [ImageContent]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        articleId <- map["id"]
        
        profileName <- map["profile.name"]
        profileImageThumbnailUrl <- map["profile.profileImage.thumbnailUrl"]
        
        thumbnail <- map["thumbnail"]
        text <- map["textContent.text"]
        circleId <- map["textContent.circle.id"]
        circleName <- map["textContent.circle.name"]
        createdAt <- map["textContent.createdAt"]
        commentCount <- map["commentCount"]
        feelingGoodCount <- map["feelingGoodCount"]
        feelingGoodByMe <- map["feelingGoodByMe"]
        isNotice <- map["notice"]
        articleWriterId <- map["textContent.user.id"]
        
        imageContents <- map["imageContents"]
    }
}

class ImageContent: Mappable {
    var seq: Int?
    var thumbnailUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        seq <- map["seq"]
        thumbnailUrl <- map["imageContent.thumbnailUrl"]
    }
}

class Page: Mappable {
    var size: Int?
    var totalElements: Int?
    var totalPages: Int?
    var number: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        size <- map["page.size"]
        totalElements <- map["page.totalElements"]
        totalPages <- map["page.totalPages"]
        number <- map["page.number"]
    }
}
