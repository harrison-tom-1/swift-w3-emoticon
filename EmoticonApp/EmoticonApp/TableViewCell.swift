//
//  TableViewCell.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/19.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var emoticonTitle: UILabel!
    @IBOutlet weak var emoticonBuyBtn: UIButton!
    @IBOutlet weak var emoticonAuthor: UILabel!
    @IBOutlet weak var emoticonImage: UIImageView!
    let data = emoticonData()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initEmoticonValue(indexPath : IndexPath){
        self.emoticonBuyBtn.setTitle("구매", for: .normal) 
        self.emoticonImage!.image = UIImage(named: data.list[indexPath.row]["image"]!)
        self.emoticonTitle?.text = data.list[indexPath.row]["title"]!
        self.emoticonAuthor?.text = data.list[indexPath.row]["author"]!
    }
}

