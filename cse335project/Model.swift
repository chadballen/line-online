//
//  Model.swift
//  cse335project
//
//  Created by cballen3 on 11/19/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import Foundation
import Firebase

class Model {
    
    // Handler Function Body
    func LoadReviewTable(snapshot: DataSnapshot) -> [Review] {
        var newList: [Review] = []
        
        // For each item in the list
        for item in snapshot.children {
            
            let data = item as! DataSnapshot
            let review = data.value as! [String:AnyObject]
            
            // create review
            let aReview = Review()
            aReview.lineName = review["name"] as! String
            aReview.lineDescription = review["description"] as! String
            aReview.lineTimePosted = review["timePosted"] as! String
            aReview.lineDuration = review["timeDuration"] as! String
            aReview.lineHasImage = review["hasImage"] as! String
            aReview.lineImagePath = review["imagePath"] as! String
            
            print(aReview.lineName)
            print(aReview.lineDescription)
            print(aReview.lineTimePosted)
            print(aReview.lineDuration)
            
            // bottom to top
            newList.insert(aReview, at: 0)
            
        }
        
        return newList
    }
    
    
    
    
    
    
    
}
