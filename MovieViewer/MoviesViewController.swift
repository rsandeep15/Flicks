//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Sandeep Raghunandhan on 1/31/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    
    var movies: [NSDictionary]?
    var filteredMovies: [NSDictionary]?
    var endpoint: String? = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        searchBar.delegate = self
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.white
        refreshControl.tintColor = UIColor.purple
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        initialFetch()
        
        
    }
    
    // When the app is launch, perform a network fetch to get an initial set of movies
    func initialFetch() {
        // Network Request Snippet
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint!)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        MBProgressHUD.showAdded(to:self.view, animated:true)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.movies = dataDictionary["results"] as? [NSDictionary]
                    self.collectionView.reloadData()
                    self.filteredMovies = self.movies
                }
            }
            
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }
        task.resume()
    }
    
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint!)?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            // ... Use the new data to update the data source ...
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.movies = dataDictionary["results"] as? [NSDictionary]
                    self.filteredMovies = self.movies
                    
                    // Reload the tableView now that there is new data
                    self.collectionView.reloadData()
                    
                    // Tell the refreshControl to stop spinning
                    refreshControl.endRefreshing()
                }
            }
        }
        task.resume()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Decides how many collection view cells to generate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let filteredMovies = filteredMovies {
            return filteredMovies.count
        }
        else {
            if let movies = movies {
                return movies.count
            }
            else {
                return 0
            }
        }
    }
    
    // Associates a cell with an index on the CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let movie = filteredMovies![indexPath.row]
        
        // No need to modify selection style of UICollection cell
        
        if let poster_path = movie["poster_path"] as? String {
            let baseUrl = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseUrl + poster_path)
            let imageRequest = NSURLRequest(url: imageUrl!)
            
            // Set the image associated with the cell
            cell.movie.setImageWith(imageRequest as URLRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) in
                if imageResponse != nil {
                    cell.movie.alpha = 0.0
                    cell.movie.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        cell.movie.alpha = 1.0
                    })
                } else {
                    cell.movie.image = image
                }
                
            }, failure: { (imageRequest, imageResponse, error) in
                print("An error occurred in retrieving the images")
            })
            
            
        }
        
        
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter movies by the search query. Matches the start of words in the movie titles
        filteredMovies = searchText.isEmpty ? movies : movies?.filter({ (item: NSDictionary) -> Bool in
            let title = item["title"] as! String
            let words = title.lowercased().components(separatedBy: " ")
            for index in 0...(words.count-1){
                // Look at the beginnings of every word, and return true as soon as a match is found
                let match = words[index].hasPrefix(searchText.lowercased())
                if (match){
                    return match
                }
            }
            // If no matches, return false
            return false
        })
        collectionView.reloadData()
    }
    
    // Prepares the cell on the view to transition to a detailed view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let movie = filteredMovies![(indexPath?.row)!] as NSDictionary
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
    }
    
}
