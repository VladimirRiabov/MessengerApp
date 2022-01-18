//
//  Message.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import Foundation
import SwiftUI

enum MessageType: String {
    case sent
    case received
}

struct Message: Hashable {
    let text: String
    let type: MessageType
    let created: Date //date to sort messages by date
}
