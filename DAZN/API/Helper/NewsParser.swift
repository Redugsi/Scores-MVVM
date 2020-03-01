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
        if elementName == "item" {
            currentNews = News()
        }
        
        if elementName == "enclosure" {
            if let imagePath = attributeDict["url"] {
                currentNews?.imagePath = imagePath
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "guid" {
            if let guid = Int(xmlText){
                currentNews?.guid = guid
            }
        }
        
        if elementName == "title" {
            currentNews?.title = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if elementName == "pubDate" {
            currentNews?.pubDate = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if elementName == "description" {
            currentNews?.description = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if elementName == "link" {
            currentNews?.link = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if elementName == "category" {
            currentNews?.category = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if elementName == "item" {
            if let news = currentNews {
                self.news.append(news)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
}
