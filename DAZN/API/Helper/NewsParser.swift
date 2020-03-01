//
//  NewsParser.swift
//  DAZN
//
//  Created by erdem on 29.02.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

final class NewsParser: NSObject {
    var xmlParser: XMLParser?
    var news: [News] = []
    var xmlText = ""
    var currentNews: News?
    
    public var error: Swift.Error? {
        return xmlParser?.parserError
    }
    
    init(with data: Data) {
        xmlParser = XMLParser(data: data)
    }
    
    func parse() -> [News]{
        xmlParser?.delegate = self
        xmlParser?.parse()
        return news
    }
}

extension NewsParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        xmlText = ""
        
        switch elementName {
        case "item":
            currentNews = News()
        case "enclosure":
            if let imagePath = attributeDict["url"] {
                 currentNews?.imagePath = imagePath
             }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "guid":
            if let guid = Int(xmlText){
                currentNews?.guid = guid
            }
        case "title":
            currentNews?.title = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        case "pubDate":
            currentNews?.pubDate = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        case "description":
            currentNews?.description = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        case "link":
            currentNews?.link = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        case "category":
            currentNews?.category = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        case "item":
            if let news = currentNews {
                  self.news.append(news)
              }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
}
