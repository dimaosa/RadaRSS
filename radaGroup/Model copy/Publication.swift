//
//  Publication.swift
//  radaRSSNews
//
//  Created by Osadchy Dima on 4/13/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation

enum PublicationType: String {
    case News           = "News"                        //Новини
    case Announcement   = "Announcement"                //Анонс
    case PlenarySession = "PlenarySession"              //Хід пленарних засідань
    case Bill           = "Bill"                        //Законопроект
    case Legislation    = "Legislation"                 //Законодавство
    
}

class Publication {
    
    let title:      String
    let link:       NSURL
    let pubDate:    NSDate
    let author:     String
    let guid:       NSURL
    
    let publicationType: PublicationType
    
    let dateCreated: NSDate
    
    init(
        title:      String,
        link:       NSURL,
        pubDate:    NSDate,
        author:     String,
        guid:       NSURL,
        publicationType: PublicationType){
        
        self.title = title
        self.link = link
        self.pubDate = pubDate
        self.author = author
        self.guid = guid
        
        self.publicationType = publicationType
        
        self.dateCreated = NSDate()
    }
    
}