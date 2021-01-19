//
//  TableViewController.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/18.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var basketImage: UIImageView!
    @IBOutlet var emoticonTable: UITableView!
    let data = emoticonData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adView.backgroundColor = UIColor(patternImage: UIImage(named: "pattern.png")!)
        basketImage.image = UIImage(named: "basket.png")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.size()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = emoticonTable.dequeueReusableCell(withIdentifier: "tableview_cell", for: indexPath) as! TableViewCell
        cell.initEmoticonValue(indexPath: indexPath)
        return cell
    }
}
