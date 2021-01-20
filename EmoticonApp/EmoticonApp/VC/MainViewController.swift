//
//  TableViewController.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/18.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    private var mainAdImage: UIView!
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    
    private var myTableView: UITableView!
    private var cellHeight: CGFloat = CGFloat(100)
    private let numOfCell: CGFloat = 8
    private let data = emoticonData()
    
    private var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "cart.fill")
        button.style = .plain
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initAdView()
        initEmoticonTable()
    }
    
    
    func initNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.rightButton.target = self
        self.rightButton.action = #selector(buttonPressed)
        self.navigationController?.navigationBar.topItem?.title = "emoticon"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }
    
    func initAdView(){
        self.mainAdImage = UIView(frame: CGRect(x: 0, y: self.topbarHeight, width: screenWidth-20, height: 230))
        self.mainAdImage.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth, .flexibleHeight]
        self.mainAdImage.backgroundColor = UIColor(patternImage: UIImage(named: "pattern.png")! )
        self.view.addSubview(mainAdImage)
        self.mainAdImage.center.x = self.view.center.x
        setAdImage()
        setAdDescription()
        setAdTitle()
    }
    
    func initEmoticonTable(){
        let positionY = self.topbarHeight+mainAdImage.frame.height+20
        self.myTableView = UITableView(frame: CGRect(x: 0, y: positionY, width: self.screenWidth, height: self.screenHeight-positionY))
        myTableView.alwaysBounceVertical = false
        myTableView.showsVerticalScrollIndicator = false
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(EmoticonListTableViewCell.self, forCellReuseIdentifier: EmoticonListTableViewCell.cellIdentifier)
        view.addSubview(self.myTableView)
        cellHeight = CGFloat((self.screenHeight-positionY)/numOfCell)
    }
    
    func setAdImage(){
        let charSize = CGSize(width: self.mainAdImage.frame.width/2, height: 200)
        if let characterImage = UIImage(named: "basket") {
            let adImageView = UIImageView()
            adImageView.image = characterImage
            adImageView.frame.origin = CGPoint(x: self.mainAdImage.frame.width-charSize.width, y: self.mainAdImage.frame.height-charSize.height)
            adImageView.frame.size.width = charSize.width
            adImageView.frame.size.height = charSize.height
            adImageView.contentMode = .scaleAspectFit
            self.mainAdImage.addSubview(adImageView)
        }
    }
    
    private func setAdTitle() {
        let adTitle = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        adTitle.textAlignment = NSTextAlignment.left
        adTitle.text = "이벤트"
        adTitle.textColor = .blue
        adTitle.font = adTitle.font.withSize(25)
        adTitle.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        self.mainAdImage.addSubview(adTitle)
    }
    
    private func setAdDescription() {
        let adDescription = UILabel(frame: CGRect(x: 10, y: self.mainAdImage.frame.height/3, width: self.mainAdImage.frame.width/2, height: self.mainAdImage.frame.height/2))
        adDescription.textAlignment = NSTextAlignment.left
        adDescription.text = "친구 추가하면\n겨울맞이\n이모티콘 선물!"
        adDescription.numberOfLines = 3
        adDescription.font = adDescription.font.withSize(30)
        adDescription.sizeToFit()
        self.mainAdImage.addSubview(adDescription)
    }
    
    @objc private func buttonPressed() {
        let uvc = CartViewController()
        self.navigationController?.pushViewController(uvc, animated: true)
    }
}

extension MainViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: EmoticonListTableViewCell = tableView.dequeueReusableCell(withIdentifier: EmoticonListTableViewCell.cellIdentifier, for: indexPath) as? EmoticonListTableViewCell {
            cell.initEmoticonValue(indexPath: indexPath, cellHeight: cellHeight)
            return cell
        }   
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
        
    }
}

extension UIViewController {
    var topbarHeight: CGFloat {
        var statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

