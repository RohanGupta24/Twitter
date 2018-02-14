//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import AssetsLibrary

class TweetCell: UITableViewCell {
    
    @IBOutlet var authorTextLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet var favoriteCountLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var retweetCountLabel: UILabel!
    @IBOutlet var tweetButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    var counterFavorite = 0
    var counterRetweet = 0
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            //print(tweetTextLabel.text)
            authorTextLabel.text =  tweet.user.screenName!
            profileImage.af_setImage(withURL: URL(string: tweet.profileUrl)!)
            dateLabel.text = tweet.createdAtString
            retweetCountLabel.text = String(describing: tweet.retweetCount)
            let favoriteText = String(describing: tweet.favoriteCount)
            favoriteCountLabel.text = favoriteText

            if tweet.retweeted == true {
                tweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            }
            else {
                tweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
            if tweet.favorited == true {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }
            else {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
            //profileImage
            //profileImage.image = tweet.
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        counterRetweet += 1
        if(counterRetweet % 2 == 0) {
            tweet.retweeted = true
            tweet.retweetCount += 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        refreshData()
    }
    @IBAction func didTapLike(_ sender: Any) {
        counterFavorite += 1
        if(counterFavorite % 2 == 0) {
            tweet.favorited = true
            tweet.favoriteCount += 1
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        refreshData()
    }
    
    func refreshData() {
        tweetTextLabel.text = tweet.text
        authorTextLabel.text = tweet.user.screenName!
        let favoriteText = String(describing: tweet.favoriteCount)
        favoriteCountLabel.text = favoriteText
        retweetCountLabel.text = String(describing: tweet.retweetCount)
        if tweet.favorited == true {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }
        else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        
        if tweet.retweeted == true {
            tweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }
        else {
            tweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        
        
    }
}
