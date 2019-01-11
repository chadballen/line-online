//
//  Review.swift
//  cse335project
//
//  Created by cballen3 on 11/19/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import Firebase
import Foundation

class Review {
    
    var lineName: String?
    var lineDuration: String?
    var lineTimePosted: String?
    var lineDescription: String?
    var lineHasImage: String?
    var lineImagePath: String?
    
    // default initializer
    init() { }
    
    // initializer that creates a new message
    init(ln: String, ld: String, ltp: String, ldd: String, lhi: String, lip: String) {
        lineName = ln
        lineDuration = ld
        lineTimePosted = ltp
        lineDescription = ldd
        lineHasImage = lhi
        lineImagePath = lip
    }
    
    // Helper method that producdes a set of key value pairs -- for use with firebase
    func GetReview() -> Any {
        
        return [
            "name" : lineName!,
            "timeDuration": lineDuration!,
            "timePosted": lineTimePosted!,
            "description": lineDescription!,
            "hasImage": lineHasImage!,
            "imagePath": lineImagePath!
        ]
        
    }
    
}
