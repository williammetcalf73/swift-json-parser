//
// Created by Jbara Omar on 14/12/2017.
// Copyright (c) 2017 Brogrammers. All rights reserved.
//

import Foundation

enum DataMapperError: Error {
    case errorReadingFile
}

class DataMapper {

    static let instance = DataMapper()

    private init() {
    }

    var events: [Event] {
        get {
            guard let filePath = Bundle.main.url(forResource: "events", withExtension: "json") else {
                return []
            }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Event].self, from: data)
        }
    }

    var categories: [Category] {
        get {
            guard let filePath = Bundle.main.url(forResource: "categories", withExtension: "json") else {
                return []
            }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Category].self, from: data)
        }
    }

    var places: [Place] {
        get {
            guard let filePath = Bundle.main.url(forResource: "places", withExtension: "json") else {
                return []
            }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Place].self, from: data)
        }
    }

    func getElement<T: IdProtocol>(withId id: Int) -> T? {
        let filename = "\(String(describing: T.self).lowercased())s"
        guard let filePath = Bundle.main.url(forResource: filename, withExtension: "json") else { return nil }
        let data = try! Data(contentsOf: filePath)
        let elements = try! JSONDecoder().decode([T].self, from: data)
        return elements.filter({ (element) in
            return element.id == id
        }).first
    }

}