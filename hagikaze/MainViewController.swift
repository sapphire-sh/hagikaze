//
//  MainViewController.swift
//  hagikaze
//
//  Created by sapphire on 12/12/2018.
//  Copyright © 2018 sapphire. All rights reserved.
//

import UIKit
import OAuthSwift

let oauth = OAuth1Swift(
    consumerKey: "",
    consumerSecret: "",
    requestTokenUrl: "https://api.twitter.com/oauth/request_token",
    authorizeUrl: "https://api.twitter.com/oauth/authorize",
    accessTokenUrl: "https://api.twitter.com/oauth/access_token"
)

class MainViewController: UIViewController {
    @IBOutlet var screenNameLabel: UIView!
    @IBAction func signInClicked(_ sender: Any) {
        print("1234")
        let handle = oauth.authorize(
            withCallbackURL: URL(string: "hagikaze://oauth-callback/twitter")!,
            success: { credential, response, parameters in
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                print(parameters["user_id"])
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
