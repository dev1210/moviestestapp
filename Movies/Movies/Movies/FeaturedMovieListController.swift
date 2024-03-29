//
//  FeaturedMovieListController.swift
//  Movies
//
//  Created by iosdeveloper on 12/18/18.
//  Copyright © 2018 MobileDevTest. All rights reserved.
//

import UIKit

class FeaturedMoviesListController: UIViewController , UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    var featuredMovies : [MovieInfo] =  [MovieInfo]()
    var pageViewController : UIPageViewController!
    @IBOutlet var pageControl : UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func loadPageController(){
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageControl.numberOfPages = featuredMovies.count

        let pageContentViewController = self.viewControllerAtIndex(index: 0)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController.view.frame = self.view.bounds
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        self.view.bringSubviewToFront(self.pageControl)
    }
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers.first as? FeaturedMovieContentController {
            self.pageControl.currentPage = vc.pageIndex
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! FeaturedMovieContentController).pageIndex!
        index =  index + 1
        if(index >= self.featuredMovies.count){
            return nil
        }
        return self.viewControllerAtIndex(index: index)
        
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! FeaturedMovieContentController).pageIndex!
        if(index <= 0){
            return nil
        }
        index = index - 1
        return self.viewControllerAtIndex(index: index)
        
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((self.featuredMovies.count == 0) || (index >= self.featuredMovies.count)) {
            return nil
        }
        if let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "FeaturedMovieInfo") as? FeaturedMovieContentController {
            pageContentViewController.pageIndex = index
            pageContentViewController.movieInfo = self.featuredMovies[index]
            return pageContentViewController
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return featuredMovies.count
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
