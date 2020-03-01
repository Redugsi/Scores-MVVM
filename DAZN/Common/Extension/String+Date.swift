//
//  String+Date.swift
//  DAZN
//
//  Created by erdem on 1.03.2020.
//  Copyright © 2020 redugsi. All rights reserved.
//

import Foundation

extension String {
  func toReadableDate(withFormat format: String = "yyyy-MM-dd") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      return nil
    }
    
    let toDateFormatter = DateFormatter()
    toDateFormatter.dateFormat = "dd MMM yyyy"
    return toDateFormatter.string(from: date)
  }
}
