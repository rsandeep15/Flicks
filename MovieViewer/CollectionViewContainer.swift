//
//  CollectionViewContainer.swift
//  MovieViewer
//
//  Created by Sandeep Raghunandhan on 2/5/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let movie = movies![indexPath.row]
        let poster_path = movie["poster_path"] as! String
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        
        let imageUrl = URL(string: baseUrl + poster_path)
        
        cell.movie.setImageWith(imageUrl!)

        return cell
    }
    
}
