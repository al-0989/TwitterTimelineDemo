//
//  ViewController.swift
//  TwitterTimelineDemo
//
//  Created by An La on 2016-04-23.
//  Copyright © 2016 An La. All rights reserved.
//

import UIKit
import TwitterKit
import Fabric

class ViewController: UIViewController {

    var logInButton: TWTRLogInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDemo()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDemo() {
        logInButton = TWTRLogInButton(logInCompletion: { session, error in
            let client = TWTRAPIClient()
            client.loadUserWithID(session!.userID) { (user, error) -> Void in
                if let user = user {
                    let userVC = UserTimelineViewController(screenName: user.screenName)
                    self.presentViewController(userVC, animated: true, completion: nil)
                }
            }
        })
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    } // End of loadDemo()

}

// The following is just a special view controller created by Twitter for us to use. It is basically a table view
class UserTimelineViewController : TWTRTimelineViewController, TWTRTweetViewDelegate {
    
    convenience init(screenName: String){
        let dataSource = TWTRUserTimelineDataSource(screenName: screenName, APIClient: TWTRAPIClient())
        self.init(dataSource: dataSource)
    }
    
    func tweetView(tweetView: TWTRTweetView, didSelectTweet tweet: TWTRTweet) {
        print("Selected tweet with ID: \(tweet.tweetID)")
    }
}