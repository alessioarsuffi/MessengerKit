//
//  CustomIncomingBotWindCell.swift
//  MessengerKit_Example
//
//  Created by Alessio Arsuffi on 07/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MessengerKit

class CustomIncomingBotWindCell: MSGMessageCell {
	
	@IBOutlet weak var avatarView: UIImageView?
	@IBOutlet weak var textLabel: UILabel?
	@IBOutlet weak var containerView: UIView?
	@IBOutlet weak var actionsStackView: UIStackView?
	@IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
	
	var avatarGestureRecognizer: UITapGestureRecognizer!
	
	override open var message: MSGMessage? {
		didSet {
			guard let message = message,
				case let MSGMessageBody.custom(any) = message.body else { return }
			
			guard let botMessage = any as? BotMessage else {
				return
			}
			
			avatarView?.image = message.user.avatar
			textLabel?.text = botMessage.text
		}
	}
	
	override var style: MSGMessengerStyle? {
		didSet {
			guard let style = style as? WindStyle, let message = message else { return }
			
			if case let MSGMessageBody.custom(any) = message.body, let botMessage = any as? BotMessage {
				
				if let actionsStackView = actionsStackView {
					actionsStackView.arrangedSubviews.forEach {
						actionsStackView.removeArrangedSubview($0)
						$0.removeFromSuperview()
					}
				}
				
				botMessage.actions.forEach {
					let button = UIButton()
					button.addTarget(self, action: #selector(actionTapped(_:)), for: .touchUpInside)
					button.setTitle($0, for: .normal)
					button.setTitleColor(style.incomingBotActionTextColor, for: .normal)
					button.titleLabel?.numberOfLines = 0
					button.titleLabel?.textAlignment = .center
					actionsStackView?.addArrangedSubview(button)
				}
			}
		}
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
	
	@objc func actionTapped(_ sender: UIButton) {
		guard let message = message, let action = sender.currentTitle else { return }
		
//		delegate?.cellActionTapped(action: action, for: message)
	}
}
