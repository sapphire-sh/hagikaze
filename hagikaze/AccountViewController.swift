//
//  AccountViewController.swift
//  hagikaze
//
//  Created by sapphire on 12/28/16.
//  Copyright © 2016 sapphire. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableViewAccounts: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(AccountManager.sharedInstance.accounts?.count)
		return (AccountManager.sharedInstance.accounts?.count)!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableViewAccounts.dequeueReusableCell(withIdentifier: "accountCell")! as UITableViewCell
		cell.textLabel?.text = AccountManager.sharedInstance.accounts?[indexPath.row].username
		return cell
	}

}
