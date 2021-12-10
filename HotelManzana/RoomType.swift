//
//  RoomType.swift
//  HotelManzana
//
//  Created by Olibo moni on 10/12/2021.
//

import Foundation

struct RoomType: Equatable{
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var shortName: String
    var price: Int 
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penhouse Suite", shortName: "PHS", price: 309)
        ]
    }
    
}
