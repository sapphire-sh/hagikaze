//
//  AccountManager.swift
//  hagikaze
//
//  Created by sapphire on 12/28/16.
//  Copyright © 2016 sapphire. All rights reserved.
//

import Foundation
import Accounts
import Social

class AccountManager {
	static let sharedInstance = AccountManager()
	private init() {
		accounts = nil
	}
	
	var accounts: [ACAccount]?
}
