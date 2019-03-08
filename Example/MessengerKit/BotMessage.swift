//
//  BotMessage.swift
//  MessengerKit_Example
//
//  Created by Alessio Arsuffi on 07/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import CoreGraphics

struct BotMessage {
	
	var text: String
	var actions: [String]
	
	var height: CGFloat {
		var result: CGFloat = 30
		actions.forEach { _ in
			result += 50.0 + 10.0
		}
		
		print("botMessage height: \(result)")
		return result
	}
}
