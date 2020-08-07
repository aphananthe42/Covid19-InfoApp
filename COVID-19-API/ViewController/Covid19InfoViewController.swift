//
//  ViewController.swift
//  COVID-19-API
//
//  Created by Ryota Miyazaki on 2020/08/06.
//  Copyright © 2020 Ryota Miyazaki. All rights reserved.
//

import UIKit

class Covid19InfoViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(TableViewCell.loadNib(), forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        }
    }
    
    var prefecturesList: [(name:String, cases: Int, deaths: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        pullCovidInfo()
    }
    
    private func pullCovidInfo() {
        pullDate()
        guard let req_url = URL(string: "https://covid19-japan-web-api.now.sh/api/v1/prefectures") else { return }
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            session.finishTasksAndInvalidate()
            do {
                self.prefecturesList.removeAll()
                let decoder = JSONDecoder()
                let json = try decoder.decode([ResultJson].self, from: data!)
                _ = json.map { self.prefecturesList.append(($0.name, $0.cases, $0.deaths)) }
                print(self.prefecturesList)
                self.tableView.reloadData()
            } catch {
                print("エラーが出ました:\(error)")
            }
        })
        task.resume()
    }
    
    private func pullDate() {
        let dt = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MdHHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        dateLabel.text = "\(dateFormatter.string(from: dt))時点"
    }

    @IBAction func reloadButton(_ sender: Any) {
        pullCovidInfo()
    }
    
}

extension Covid19InfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prefecturesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configure(name: prefecturesList[indexPath.row].name, cases: prefecturesList[indexPath.row].cases, deaths: prefecturesList[indexPath.row].deaths)
        cell.backgroundColor = .white
        return cell
    }
    
}
