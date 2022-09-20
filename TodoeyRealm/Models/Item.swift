//
//  Item.swift
//  TodoeyRealm
//
//  Created by Leonard Groves on 9/15/22.
//

import Foundation
import RealmSwift
import SwipeCellKit

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var timeStamp: Date?
    
    // LinkingObjects is an auto-updating container type. It represents zero or more objects that are linked to its owning model object through a property relationship.
    // LinkingObjects defines the inverse relationship of Items.
    // Each Item has an inverse relationship to a Category, which we are calling the parentCategory.
    // LinkingObjects(fromType: Element, property: String)
    // fromType: Category.self  --> Category is the class, .self is the type.
    // property: "items" --> items is the variable that was created in the Category class that ties the Caegory class to the Item class.
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
