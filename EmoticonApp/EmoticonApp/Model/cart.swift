//
//  cart.swift
//  EmoticonApp
//
//  Created by 이준형 on 2021/01/19.
//  Copyright © 2021 이준형. All rights reserved.
//

import Foundation

struct UserDefault {
    
    static let db = UserDefaults.standard

    static func getData() -> Data? {
        return db.data(forKey: "histories") ?? nil
    }

    static func addData(_ dataArray: [History]) {
        if let data = try? PropertyListEncoder().encode(dataArray){
            UserDefault.db.set(data, forKey: "histories")
        }
    }
}

struct Cart {
    static var myEmoticons: [History] = {
        var array: [History] = []
        if let data = UserDefault.getData() {
            let dataArray = try! PropertyListDecoder().decode([History].self, from: data)
            array = dataArray
        }
        return array
    }()

     static var count: Int {
        self.myEmoticons.count
    }

    static func buyEmoticon(title: String, date: DateFormatter) {
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.myEmoticons.append(History(title: title, date:  date.string(from: Date())))
        UserDefault.addData(self.myEmoticons)
    }

    static func remove(index: Int) {
        self.myEmoticons.remove(at: index)
        NotificationCenter.default.post(name: NSNotification.Name("historyCellReload"), object: nil, userInfo: nil)
    }
    static func removeAll() {
        self.myEmoticons.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name("historyCellReload"), object: nil, userInfo: nil)
    }
    
    static subscript(index: Int) -> History {
        return self.myEmoticons[index]
    }
}

struct History: Codable {
    let title: String
    let date: String
}
