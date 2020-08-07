//
//  TableViewCell.swift
//  COVID-19-API
//
//  Created by Ryota Miyazaki on 2020/08/06.
//  Copyright © 2020 Ryota Miyazaki. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "tableViewCell"

    @IBOutlet weak var prefectureLabel: UILabel!
    @IBOutlet weak var casesLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prefectureLabel.text = nil
        casesLabel.text = nil
        deathsLabel.text = nil
    }

    func configure(name: String, cases: Int, deaths: Int) {
        prefectureLabel.text = name
        casesLabel.text = "感染者数:\(String(cases))"
        deathsLabel.text = "死亡者数:\(String(deaths))"
        if Double(cases) * 0.026 < Double(deaths) {
            prefectureLabel.textColor = .purple
            casesLabel.textColor = .purple
            deathsLabel.textColor = .purple
        } else {
            prefectureLabel.textColor = .black
            casesLabel.textColor = .black
            deathsLabel.textColor = .black
        }
    }
    
    static func loadNib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
}
