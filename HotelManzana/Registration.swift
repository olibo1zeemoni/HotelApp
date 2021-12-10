//
//  Registration.swift
//  HotelManzana
//
//  Created by Olibo moni on 09/12/2021.
//

import Foundation

struct Registration{
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfChildren: Int
    var numberOfAdults: Int
    
    var wifi: Bool
    var roomType: RoomType
    var charges: Charges
}


