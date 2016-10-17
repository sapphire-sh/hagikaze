//
//  TimelineViewController.swift
//  hagikaze
//
//  Created by sapphire on 10/17/16.
//  Copyright © 2016 sapphire. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	
	var tweets: [TWTRTweet] = [] {
		didSet {
			tableView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
			let client = TWTRAPIClient(userID: userID)
			let parameters: [String: String] = [:]
			let request = client.urlRequest(withMethod: "GET", url: "https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: parameters, error: nil)
			client.sendTwitterRequest(request, completion: { (res, data, err) in
				if err != nil {
					print(err)
				}
				
				do {
					let json: Any = try JSONSerialization.jsonObject(with: data!, options: [JSONSerialization.ReadingOptions.mutableContainers])
					if let jsonArray = json as? NSArray {
						let tweets = TWTRTweet.tweets(withJSONArray: jsonArray as? [Any])
						self.tweets = tweets as! [TWTRTweet]
					}
				}
				catch let jsonError as NSError {
					print("json error: \(jsonError.localizedDescription)")
				}
			})
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tweets.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "timelineTweet", for: indexPath)
		
		let tweet = tweets[indexPath.row]
		
		do {
			let data = try Data(contentsOf: URL(string: tweet.author.profileImageURL)!)
			cell.imageView?.image = UIImage(data: data)
		}
		catch let err as NSError {
			print(err.localizedDescription)
		}
		
		cell.textLabel?.text = tweet.text
		cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
		cell.textLabel?.numberOfLines = 0
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}
