//
//  Category.swift
//  TodoeyRealm
//
//  Created by Leonard Groves on 9/15/22.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    
    // The following creates a variable that can be used as a relationship property between the Category class and the Item class. It's counterpart is created in the Item class.
    
    // The format is List<DataType>, where List is a Realm datatype, like an array, and <DataType> is the data type of the variables the list contains.
    
    // Each Category has a one-to-many relationship with a list of items.
    let items = List<Item>()
}
