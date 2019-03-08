//
//  MSGWindStyle.swift
//  MessengerKit_Example
//
//  Created by Alessio Arsuffi on 07/03/2019.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import MessengerKit

struct WindStyle: MSGMessengerStyle {
	
	var collectionView: MSGCollectionView.Type = WindCollectionView.self
	
	var inputView: MSGInputView.Type = MSGImessageInputView.self
	
	var headerHeight: CGFloat = 0
	
	var footerHeight: CGFloat = 0
	
	var backgroundColor: UIColor = .lightText
	
	var inputViewBackgroundColor: UIColor = .white
	
	var font: UIFont = .preferredFont(forTextStyle: .body)
	
	var inputFont: UIFont = .systemFont(ofSize: 14)
	
	var inputPlaceholder: String = "Hello world..."
	
	var inputTextColor: UIColor = .darkText
	
	var inputPlaceholderTextColor: UIColor = .lightGray
	
	var outgoingTextColor: UIColor = .darkText
	
	var outgoingLinkColor: UIColor = .sendButtonChatEnabled
	
	var incomingTextColor: UIColor = .darkText
	
	var incomingLinkColor: UIColor = .sendButtonChatEnabled
	
	func size(for message: MSGMessage, in collectionView: UICollectionView) -> CGSize {
		var size: CGSize!
		
		switch message.body {
		case .text(let body):
			
			let bubble = WindTextBubble()
			bubble.text = body
			bubble.font = font
			let bubbleSize = bubble.calculatedSize(in: CGSize(width: collectionView.bounds.width, height: .infinity))
			size = CGSize(width: collectionView.bounds.width, height: bubbleSize.height)
			
			break
			
			
		case .emoji:
			
			size = CGSize(width: collectionView.bounds.width, height: 60)
			
			break
			
		case .custom(let any):
			
			if let botMessage = any as? BotMessage {
				size = CGSize(width: collectionView.bounds.size.width, height: botMessage.height)
			} else {
				size = CGSize(width: collectionView.bounds.width, height: 175)
			}
			break
			
		default:
			
			size = CGSize(width: collectionView.bounds.width, height: 175)
			
			break
		}
		
		return size
	}
	
	// Custom properties
	
	var incomingBotActionTextColor: UIColor = .windOrange
	var outgoingBotActionTextColor: UIColor = .windOrange
}

extension UIColor {
	
	static var windOrange: UIColor {
		return UIColor(red: 1.00, green: 0.42, blue: 0.00, alpha: 1.0)
	}
	
	static var windGrey: UIColor{
		return UIColor(red: 41.0/255.0, green:47.0/255.0, blue:54.0/255.0, alpha:1.0)
	}
	
	static var sendButtonChatEnabled: UIColor {
		return UIColor(red: 1.00, green: 0.42, blue: 0.00, alpha: 1.0)
	}
	
	static var sendButtonChatDisabled: UIColor {
		return UIColor(red:0.19, green:0.24, blue:0.57, alpha:0.2)
	}
	
	static var cardAction: UIColor {
		return UIColor(red:0.15, green:0.16, blue:0.53, alpha:1.0)
	}
}
