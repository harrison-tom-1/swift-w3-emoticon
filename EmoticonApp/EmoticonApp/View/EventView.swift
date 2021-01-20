//
//  EventView.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/20.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class EventView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth, .flexibleTopMargin]
        initUI()
        self.sizeToFit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initUI(){
        self.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth, .flexibleHeight]
        self.backgroundColor = UIColor(patternImage: UIImage(named: "pattern.png")! )
        
        setAdImage()
        setAdDescription()
        setAdTitle()
        
    }
    func setAdImage(){
        let charSize = CGSize(width: self.frame.width/2, height: 200)
        if let characterImage = UIImage(named: "basket") {
            let adImageView = UIImageView()
            adImageView.image = characterImage
            adImageView.frame.origin = CGPoint(x: self.frame.width-charSize.width, y: self.frame.height-charSize.height)
            adImageView.frame.size.width = charSize.width
            adImageView.frame.size.height = charSize.height
            adImageView.contentMode = .scaleAspectFit
            self.addSubview(adImageView)
        }
    }
    
    private func setAdTitle() {
        let adTitle = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        adTitle.textAlignment = NSTextAlignment.left
        adTitle.text = "이벤트"
        adTitle.textColor = .blue
        adTitle.font = adTitle.font.withSize(25)
        adTitle.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        self.addSubview(adTitle)
    }
    
    private func setAdDescription() {
        let adDescription = UILabel(frame: CGRect(x: 10, y: self.frame.height/3, width: self.frame.width/2, height: self.frame.height/2))
        adDescription.textAlignment = NSTextAlignment.left
        adDescription.text = "친구 추가하면\n겨울맞이\n이모티콘 선물!"
        adDescription.numberOfLines = 3
        adDescription.font = adDescription.font.withSize(30)
        adDescription.sizeToFit()
        self.addSubview(adDescription)
    }
}
