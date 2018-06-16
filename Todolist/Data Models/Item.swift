//
//  Data Models.swift
//  Todolist
//
//  Created by Supapat on 12/6/2561 BE.
//  Copyright © 2561 Supapat. All rights reserved.
//

import Foundation

class Item :Codable{
    var title : String = ""
    var done : Bool = false
}
