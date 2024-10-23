//
//  AppDelegate.swift
//  Candid8s
//
//  Created by Martin Ausilio
//

import MessageKit

struct UserMK: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
