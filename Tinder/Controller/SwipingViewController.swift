//
//  SwipingViewController.swift
//  Tinder
//
//  Created by We//Yes on 09/03/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import UIKit
import SDWebImage

class SwipingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var controllers = [UIViewController]();
    
    var stackCards: CardViewModel! {
        didSet {
            controllers = stackCards.imageNames.map({ (imageUrl) -> UIViewController in
                let photo = PhotoControllerViewController(imageUrl: imageUrl);
                return photo;
            })
            
//            controllers = [
//            PhotoControllerViewController(imageUrl: UIImage(named: "woman")),
//             PhotoControllerViewController(imageUrl: UIImage(named: "woman")),
//              PhotoControllerViewController(imageUrl: UIImage(named: "woman")),
//               PhotoControllerViewController(imageUrl: UIImage(named: "woman")),
//                PhotoControllerViewController(imageUrl: UIImage(named: "woman")),
//                 PhotoControllerViewController(imageUrl: UIImage(named: "woman")), PhotoControllerViewController(imageUrl: UIImage(named: "woman")),
//            ];
//
            print(stackCards.imageNames);
            
            setViewControllers([controllers.first!], direction: .forward, animated: true);
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad();
        dataSource = self;
        
        // Do any additional setup after loading the view.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where:{$0 === viewController}) ?? 0;
        if index == 0 { return nil };
        return controllers[index - 1];
    };
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where:{$0 === viewController}) ?? 0;
        if index == controllers.count - 1 { return nil };
        return controllers[index + 1];
    }
}

class PhotoControllerViewController: UIViewController {
    var imageView = UIImageView(image: UIImage(named: "woman"));
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.addSubview(imageView);
        self.imageView.fillSuperview();
        self.imageView.contentMode = .scaleAspectFill;
        
    };
    
    init(imageUrl: String?) {
//        self.imageView.image = imageUrl
        if let imageUrl = imageUrl {
            print("DSDADSDSA", imageUrl)
            self.imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "woman"), options: .continueInBackground);
        };
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
