//
//  News.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

public struct News: CustomDebugStringConvertible {
    
    var guid: Int?
    var title: String?
    var pubDate: String?
    var imagePath: String?
    var description: String?
    var link: String?
    var category: String?
    
    public var debugDescription: String {
        return "Guid : \(guid), Title: \(title), PubDate: \(pubDate), ImagePath: \(imagePath), Description: \(description), Link: \(link), Category: \(category)"
    }
}
