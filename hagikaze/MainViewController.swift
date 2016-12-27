//
//  MainViewController.swift
//  hagikaze
//
//  Created by sapphire on 12/27/16.
//  Copyright © 2016 sapphire. All rights reserved.
//

import UIKit
import Accounts
import Social

class MainViewController: UIViewController {
	@IBOutlet weak var buttonSignIn: UIButton!
	
	@IBAction func onClickSignIn(_ sender: Any) {
		let accountStore = ACAccountStore()
		let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
		
		accountStore.requestAccessToAccounts(with: accountType, options: nil, completion: { error in
			let accounts = accountStore.accounts(with: accountType) as! [ACAccount]
			AccountManager.sharedInstance.accounts = accounts
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: "SegueToAccount", sender: nil)
			}
		})
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
