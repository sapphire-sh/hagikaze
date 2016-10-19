//
//  TimelineViewController.swift
//  hagikaze
//
//  Created by sapphire on 10/17/16.
//  Copyright © 2016 sapphire. All rights reserved.
//

import UIKit
import TwitterKit
import Kingfisher

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	var refreshControl: UIRefreshControl!
	
	var client: TWTRAPIClient?
	
	var tweets: [TWTRTweet] = [] {
		didSet {
			tableView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
		tableView.addSubview(refreshControl)
		
		if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
			client = TWTRAPIClient(userID: userID)
			
			fetchHomeTimeline()
		}
    }

	func fetchHomeTimeline() {
		var parameters: [String: String] = [:]
		if self.tweets.count > 0 {
			parameters["since_id"] = self.tweets.first?.tweetID
		}
		let request = client?.urlRequest(withMethod: "GET", url: "https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: parameters, error: nil)
		client?.sendTwitterRequest(request!, completion: { (res, data, err) in
			if err != nil {
				print(err)
			}
			
			do {
				let json: Any = try JSONSerialization.jsonObject(with: data!, options: [JSONSerialization.ReadingOptions.mutableContainers])
				if let jsonArray = json as? NSArray {
					var tweets = TWTRTweet.tweets(withJSONArray: jsonArray as? [Any]) as! [TWTRTweet]
					tweets.append(contentsOf: self.tweets)
					self.tweets = tweets
				}
			}
			catch let jsonError as NSError {
				print("json error: \(jsonError.localizedDescription)")
			}
		})
	}

	func refresh() {
		fetchHomeTimeline()
		refreshControl.endRefreshing()
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTweet", for: indexPath)
		
		let tweet = tweets[indexPath.row]
		
		let profileImageView = cell.viewWithTag(100) as! UIImageView?
		let screenNameLabel = cell.viewWithTag(101) as! UILabel?
		let textLabel = cell.viewWithTag(102) as! UILabel?
		
		let url = URL(string: tweet.author.profileImageURL)
		profileImageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
			let cell = tableView.cellForRow(at: indexPath)
			if cell != nil {
				tableView.reloadRows(at: [indexPath], with: .automatic)
				profileImageView?.contentMode = UIViewContentMode.scaleAspectFit
			}
		})
		
		screenNameLabel?.text = "@" + tweet.author.screenName
		
		textLabel?.text = tweet.text
		textLabel?.sizeToFit()
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}
