//
//  ViewController.swift
//  hagikaze
//
//  Created by sapphire on 10/16/16.
//  Copyright © 2016 sapphire. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let logInButton = TWTRLogInButton { (session, error) in
			if session != nil {
				self.performSegue(withIdentifier: "SegueToTimeline", sender: self)
			}
			else {
				NSLog("Login error: %@", error!.localizedDescription);
			}
		}
		
		logInButton.center = self.view.center
		self.view.addSubview(logInButton)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

