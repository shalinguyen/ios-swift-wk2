//
//  movieDetailsViewController.swift
//  rottentomatoes
//
//  Created by Shali Nguyen on 9/14/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailPosterView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailSynopsisLabel: UILabel!
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    @IBOutlet weak var detailContainerView: UIView!
    
    var movie: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var posters = movie["posters"] as NSDictionary
        var lowResPosterURL = posters["thumbnail"] as String
        var hiResPosterUrl = lowResPosterURL.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        
        var movieTitle = movie["title"] as String
        var synopsis = movie["synopsis"] as String
        var synopsisSize = detailSynopsisLabel.sizeThatFits
        
        
        
        detailTitleLabel.text = movieTitle
        detailSynopsisLabel.text = synopsis
        detailSynopsisLabel.numberOfLines = 0;
        detailSynopsisLabel.sizeToFit()
        
        
        
        
        detailPosterView.setImageWithURL(NSURL(string: lowResPosterURL))
        detailPosterView.setImageWithURL(NSURL(string: hiResPosterUrl))
        
        
        //detailContainerView.frame.height = CGSize(synopsisSize.height + 200)
        
        //detailScrollView.contentSize = CGSize(width: 320, height: 1000)
        
        detailScrollView.contentSize = CGSizeMake(detailContainerView.frame.size.width, detailSynopsisLabel.frame.height + 365)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
