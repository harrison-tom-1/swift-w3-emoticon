//
//  HistoryTableViewCell.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/20.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "HistoryTableViewCell"
    
    private var emoticonName: UILabel?
    private var time: UILabel?
    
    let data = emoticonData()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        emoticonName = UILabel()
        emoticonName?.font = UIFont.systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        emoticonName?.contentMode = .top
        
        time = UILabel()
        time?.font = UIFont.systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        time?.contentMode = .top
        
        if let label = emoticonName { contentView.addSubview(label) }
        if let label = time { contentView.addSubview(label) }
    }
    
    func setHeight(height: CGFloat) {
        emoticonName?.frame.size.height = height / 2
        emoticonName?.frame.origin = CGPoint(x: 10 , y: 0)
        emoticonName?.frame.size = CGSize(width: self.frame.width-height, height: height / 2)
        
        time?.frame.size.height = height / 2
        time?.frame.origin = CGPoint(x: self.frame.width/2 + height/2, y: 0)
        time?.frame.size = CGSize(width: height*3, height: height / 2)
    }
    
    func initEmoticonValue(indexPath : IndexPath, cellHeight : CGFloat){
        self.emoticonName?.text = Cart.myEmoticons[indexPath.row].title
        self.time?.text = Cart.myEmoticons[indexPath.row].date
        self.selectionStyle = .none
        self.setHeight(height: cellHeight)
    }
}
