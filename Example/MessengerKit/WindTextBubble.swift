//
//  WindTextBubble.swift
//  MessengerKit_Example
//
//  Created by Alessio Arsuffi on 07/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class WindTextBubble: UITextView {
	
	override var canBecomeFirstResponder: Bool {
		return false
	}
	
	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}
	
	init() {
		super.init(frame: .zero, textContainer: nil)
		setupView()
	}
	
	fileprivate func setupView() {
		
		backgroundColor = .white
		
		//        layer.cornerRadius = 22
		//        layer.masksToBounds = true
		//        layer.borderWidth = 1
		//        layer.borderColor = UIColor.white.cgColor
		
		isEditable = false
		isSelectable = true // TODO: Check that links are tappable
		dataDetectorTypes = [.flightNumber, .calendarEvent, .address, .phoneNumber, .link, .lookupSuggestion]
		isUserInteractionEnabled = true
		delaysContentTouches = true
		font = UIFont.systemFont(ofSize: 14)
		translatesAutoresizingMaskIntoConstraints = false
		textContainerInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
		textContainer.lineFragmentPadding = 0
		
		linkTextAttributes = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single]
		
	}
	
	
	func calculatedSize(in size: CGSize) -> CGSize {
		// a: 40 + b: 16 + c: 16 + d: 8
		// a: image size, b: left margin bubble, c: right margin avatar, d: space between avatar and bubble
		return sizeThatFits(CGSize(width: size.width - 80, height: .infinity))
	}
	
	// Disables text selection
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		
		guard let pos = closestPosition(to: point) else {
			return false
		}
		
		guard let range = tokenizer.rangeEnclosingPosition(pos, with: .character,
														   inDirection: UITextDirection(rawValue: UITextLayoutDirection.left.rawValue)) else {
															return false
		}
		
		let startIndex = offset(from: beginningOfDocument, to: range.start)
		
		return attributedText.attribute(.link, at: startIndex, effectiveRange: nil) != nil
	}
	
}
