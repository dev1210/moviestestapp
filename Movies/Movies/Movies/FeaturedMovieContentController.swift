//
//  FeaturedMovieContentController.swift
//  Movies
//
//  Created by iosdeveloper on 12/17/18.
//  Copyright © 2018 MobileDevTest. All rights reserved.
//

import UIKit

class FeaturedMovieContentController: UIViewController {

    @IBOutlet var img_poster: UIImageView!
    @IBOutlet var lbl_title: UILabel!
    var pageIndex: Int!
    var movieInfo: MovieInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.text = movieInfo.title
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
    @IBAction func getstureRecognized(){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetails") as? MovieDetailsViewController {
            vc.movieInfo = movieInfo
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
