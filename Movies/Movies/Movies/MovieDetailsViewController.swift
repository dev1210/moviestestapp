//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by iosdeveloper on 12/18/18.
//  Copyright © 2018 MobileDevTest. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet var img_poster: UIImageView!
    var movieInfo: MovieInfo!
    @IBOutlet var lbl_Rating: UILabel!
    @IBOutlet var txt_Description: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieInfo.title
        lbl_Rating.text = "\(movieInfo.votePercentage!)" + " (\(movieInfo.voteCount!) votes)"
        txt_Description.text = movieInfo.overview
        
        if let image = self.movieInfo.posterImage{
            self.img_poster.image = image
        }else{
            APIHelper.getImageWithPath(movieInfo.posterImagePath) { (result, error, response) in
                if let image = result as? UIImage {
                    self.img_poster.image = image
                    self.movieInfo.posterImage = image
                }
            }
        }
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
