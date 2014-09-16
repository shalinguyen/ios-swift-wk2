//
//  TableViewController.swift
//  rottentomatoes
//
//  Created by Shali Nguyen on 9/9/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    var movies: [NSDictionary] = []
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.networkErrorLabel.hidden = true
        
        loadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        var movie = movies[indexPath.row]
        
        cell.movieTitleLabel.text = movie["title"] as String
        cell.synopsisTitle.text = movie["synopsis"] as String
        
        var posterDictionary = movie["posters"] as NSDictionary
        var posterUrl = posterDictionary["thumbnail"] as String
        
        cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        
        return cell
    }
    
    func loadData() {
        self.activityIndicatorView.startAnimating()
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=6sjv63ep77dg75rctjv8qvsc&limit=20&country=us"
        var request = NSURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            println(response)
            if (error == nil) {
                var objects = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                self.movies = objects["movies"] as [NSDictionary]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicatorView.stopAnimating()
            } else {
                self.networkErrorLabel.hidden = false
            }
        }
    }
    
    func refresh(sender:AnyObject)
    {
        self.networkErrorLabel.hidden = true
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if segue.identifier == "movieDetailView" {
            let selectedMovie = self.movies[self.tableView.indexPathForSelectedRow()!.row]
            let movieDetailsViewController = segue.destinationViewController as MovieDetailsViewController
            
            movieDetailsViewController.movie = selectedMovie
        }
    }
}
