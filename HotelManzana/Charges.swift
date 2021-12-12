//
//  Charges.swift
//  HotelManzana
//
//  Created by Olibo moni on 10/12/2021.
//

import Foundation

struct Charges{
    
    var numberOfNights: Int = 1
    var roomTypeTotal: Int
    var wifiTotal: Int {
        return numberOfNights * 10
    }
    var total: Int{
       return roomTypeTotal + wifiTotal
    }
}
