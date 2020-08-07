//
//  ResultJson.swift
//  COVID-19-API
//
//  Created by Ryota Miyazaki on 2020/08/07.
//  Copyright © 2020 Ryota Miyazaki. All rights reserved.
//

import Foundation

struct ResultJson: Codable {
    
    let name: String
    let cases: Int
    let deaths: Int

    enum CodingKeys: String, CodingKey {
        case name = "name_ja"
        case cases
        case deaths
    }

}
