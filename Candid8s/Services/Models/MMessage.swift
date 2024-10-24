//
//  AppDelegate.swift
//  Candid8s
//
//  Created by Martin Ausilio
//

import UIKit
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {

    var sender: MessageKit.SenderType
    let content: String
    var sentDate: Date
    let id: String?

    var messageId: String {
        return id ?? UUID().uuidString
    }

    var kind: MessageKit.MessageKind {
        return .text(content)
    }

    init(user: MUser, content: String) {
        self.content = content
        sender = UserMK(senderId: user.id, displayName: user.userName)
        sentDate = Date()
        id = nil
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentData = data["created"] as? Timestamp else { return nil }
        guard let senderID = data["senderID"] as? String else { return nil }
        guard let senderUserName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }

        self.id = document.documentID
        self.sentDate = sentData.dateValue()
        sender = UserMK(senderId: senderID, displayName: senderUserName)
        self.content = content
    }

    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
            ]
        return rep
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }

    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}
