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
    private let allEmoticonData = emoticonData()
    
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

        NotificationCenter.default.addObserver(self, selector: #selector(buyBtnPressed(_:)), name: NSNotification.Name("buyEmoticonNotification"), object: nil)

    }
    
    @objc func buyBtnPressed(_ notification: Notification){
        guard let emoticonName: String = notification.userInfo?["name"] as? String else { return }
        
        var date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        Cart.buyEmoticon(title: emoticonName, date: DateFormatter())
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
        self.mainAdImage = EventView(frame: CGRect(x: 0, y: self.topbarHeight, width: screenWidth-20, height: 230))
        self.mainAdImage.center.x = self.view.center.x
        self.view.addSubview(mainAdImage)
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
        return allEmoticonData.size()
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

