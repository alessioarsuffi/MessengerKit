//
//  CustomIncomingTextWindCell.swift
//  MessengerKit_Example
//
//  Created by Alessio Arsuffi on 07/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MessengerKit

class CustomIncomingTextWindCell: MSGMessageCell {

    
	@IBOutlet weak var bubble: WindTextBubble!
	
	@IBOutlet weak var bubbleWidthConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var avatarView: UIImageView?
	
	var avatarGestureRecognizer: UITapGestureRecognizer!
	
	override open var message: MSGMessage? {
		didSet {
			guard let message = message,
				case let MSGMessageBody.text(body) = message.body else { return }
			
			bubble.text = body
			avatarView?.image = message.user.avatar
		}
	}
	
	override var style: MSGMessengerStyle? {
		didSet {
			guard let style = style as? WindStyle, let message = message else { return }
			bubble.linkTextAttributes = [NSAttributedString.Key.underlineColor: style.incomingLinkColor]
			bubble.linkTextAttributes = [NSAttributedString.Key.foregroundColor: style.incomingLinkColor]
			bubble.font = style.font
			bubble.textColor = message.user.isSender ? style.outgoingTextColor : style.incomingTextColor
		}
	}
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		let bubbleSize = bubble.calculatedSize(in: bounds.size)
		bubbleWidthConstraint.constant = bubbleSize.width
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		avatarView?.layer.cornerRadius = 20
		avatarView?.layer.masksToBounds = true
		
		avatarGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
		avatarView?.addGestureRecognizer(avatarGestureRecognizer)
		avatarView?.isUserInteractionEnabled = true
	}
	
	@objc func avatarTapped(_ sender: UITapGestureRecognizer) {
		guard let user = message?.user else { return }
		delegate?.cellAvatarTapped(for: user)
	}

}
