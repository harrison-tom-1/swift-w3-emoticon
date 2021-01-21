//
//  CartViewController.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/19.
//  Copyright © 2021 이준형. All rights reserved.
//

import UIKit

class CartViewController: UIViewController{
    var cleanButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Clean"
        button.style = .plain
        return button
    }()
    
    private var myHistoryTableView: UITableView!
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    private var cellHeight: CGFloat = CGFloat(100)
    private let numOfCellView: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initEmoticonTable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewReloadFunc), name: NSNotification.Name("historyCellReload"), object: nil)
    }
    
    func initNavigationBar(){
        self.cleanButton.target = self
        self.cleanButton.action = #selector(cleanButtonPressed)
        self.navigationItem.title = "History"
        self.navigationItem.rightBarButtonItem = cleanButton
    }
    
    func initEmoticonTable(){
        let positionY = self.topbarHeight
        self.myHistoryTableView = UITableView(frame: CGRect(x: 0, y: positionY, width: self.screenWidth, height: self.screenHeight-positionY))
        myHistoryTableView.alwaysBounceVertical = false
        myHistoryTableView.showsVerticalScrollIndicator = false
        myHistoryTableView.dataSource = self
        myHistoryTableView.delegate = self
        
        myHistoryTableView.translatesAutoresizingMaskIntoConstraints = false
        myHistoryTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
        self.view.addSubview(self.myHistoryTableView)
        cellHeight = CGFloat((self.screenHeight-positionY)/numOfCellView)
    }
    
    @objc private func cleanButtonPressed() {
        Cart.removeAll()
    }

    @objc func viewReloadFunc(){
        self.myHistoryTableView.reloadData()
    }
}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier, for: indexPath) as? HistoryTableViewCell {
            cell.initEmoticonValue(indexPath: indexPath, cellHeight: cellHeight)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            Cart.remove(index: indexPath.row)
            self.myHistoryTableView.reloadData()
        }
    }
}
