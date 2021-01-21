//
//  TableViewCell.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/19.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class EmoticonListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "EmoticonListTableViewCell"
    private var emoticonImg: UIImageView?
    private var emoticonName: UILabel?
    private var emoticonAuthor: UILabel?
    private var buyBtn: UIButton?
    
    private let allEmoticonData = emoticonData()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        emoticonImg = UIImageView()
        emoticonImg?.contentMode = .scaleAspectFit
        
        emoticonName = UILabel()
        emoticonName?.font = UIFont.systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        emoticonName?.contentMode = .top
        
        emoticonAuthor = UILabel()
        emoticonAuthor?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .light)
        emoticonAuthor?.contentMode = .top
        
        buyBtn = UIButton()
        buyBtn?.setTitle("구매", for: .normal)
        buyBtn?.setTitleColor(.blue, for: .normal)
        buyBtn?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        if let imageView = emoticonImg { contentView.addSubview(imageView) }
        if let label = emoticonName { contentView.addSubview(label) }
        if let label = emoticonAuthor {  contentView.addSubview(label) }
        if let button = buyBtn { contentView.addSubview(button) }
    }
    
    private func setHeight(height: CGFloat) {
        emoticonImg?.frame.size = CGSize(width: height, height: height)
        
        emoticonName?.frame.size.height = height / 2
        emoticonName?.frame.origin = CGPoint(x: height, y: 0)
        emoticonName?.frame.size = CGSize(width: self.frame.width-height, height: height / 2)
        
        emoticonAuthor?.frame.size.height = height / 2
        emoticonAuthor?.frame.origin = CGPoint(x: height, y: height/2)
        emoticonAuthor?.frame.size = CGSize(width: self.frame.width-height, height: height / 2)
        
        buyBtn?.frame.size.height = height / 2
        buyBtn?.frame.origin = CGPoint(x: self.frame.width - height*1.5, y: 10)
        buyBtn?.frame.size = CGSize(width: height, height: height/2)
    }
    
    public func initEmoticonValue(indexPath : IndexPath, cellHeight : CGFloat){
        self.emoticonImg?.image = UIImage(named: allEmoticonData.list[indexPath.row]["image"]!)
        self.emoticonName?.text = allEmoticonData.list[indexPath.row]["title"] ?? ""
        self.emoticonAuthor?.text = allEmoticonData.list[indexPath.row]["author"] ?? ""
        self.selectionStyle = .none
        self.setHeight(height: cellHeight)
    }
    
    @objc func buttonPressed(){
        if let name = emoticonName {
            let userInfo: [AnyHashable: Any] = ["name":name.text!]
            NotificationCenter.default.post(name: NSNotification.Name("buyEmoticonNotification"), object: nil, userInfo: userInfo)
        }
        
    }
}
