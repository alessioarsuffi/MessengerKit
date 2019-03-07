//
//  WindCollectionView.swift
//  MessengerKit_Example
//
//  Created by Alessio Arsuffi on 07/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MessengerKit

class WindCollectionView: MSGImessageCollectionView {
	
	override func registerCells() {
		super.registerCells()
		
		register(UINib(nibName: "CustomOutgoingTextWindCell", bundle: nil), forCellWithReuseIdentifier: "outgoingText")
		register(UINib(nibName: "CustomIncomingTextWindCell", bundle: nil), forCellWithReuseIdentifier: "incomingText")
	}
	
}
