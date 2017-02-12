//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Sandeep Raghunandhan on 2/7/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        titleLabel.text = title
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        
        navItem.title = title
        
        if let poster_path = movie["poster_path"] as? String {
            let baseUrl = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseUrl + poster_path)
            let imageRequest = NSURLRequest(url: imageUrl!)
            self.posterImageView.setImageWith(imageRequest as URLRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) in
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    // animate the appearance of the image
                    self.posterImageView.alpha = 0.0
                    self.posterImageView.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.posterImageView.alpha = 1.0
                    })
                } else {
                    self.posterImageView.image = image
                }
                
            }, failure: { (imageRequest, imageResponse, error) in
                // TODO error handling
            })
            posterImageView.setImageWith(imageUrl!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
