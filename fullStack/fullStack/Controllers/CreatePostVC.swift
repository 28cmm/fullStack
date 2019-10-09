//
//  CreatePostVC.swift
//  fullStack
//
//  Created by Yilei Huang on 2019-10-07.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import LBTATools
import Alamofire
import JGProgressHUD

extension CreatePostVC: UITextViewDelegate{
    
}
class CreatePostVC: UIViewController {
    
    let selectedImage: UIImage
    weak var homeController: HomeController?
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    init(selectedImage:UIImage){
        self.selectedImage = selectedImage
        super.init(nibName: nil, bundle:nil)
        imageView.image = selectedImage
    }
       
       lazy var postButton = UIButton(title: "Post", titleColor: .white, font: .boldSystemFont(ofSize: 14), backgroundColor: #colorLiteral(red: 0.1127949134, green: 0.5649430156, blue: 0.9994879365, alpha: 1), target: self, action: #selector(handlePost))
       
       let placeholderLabel = UILabel(text: "Enter your post body text...", font: .systemFont(ofSize: 14), textColor: .lightGray)
       
       let postBodyTextView = UITextView(text: nil, font: .systemFont(ofSize: 14))
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //here is the layout of our UI
        postButton.layer.cornerRadius = 5
        
        view.stack(imageView.withHeight(300),
                   view.stack(postButton.withHeight(40),
                              placeholderLabel,
                              spacing: 16).padLeft(16).padRight(16),
                   UIView(),
                   spacing: 16)
        
        // setup UITextView on top of placeholder label, UITextView does not have a placeholder property
        view.addSubview(postBodyTextView)
        postBodyTextView.backgroundColor = .clear
        postBodyTextView.delegate = self
        postBodyTextView.anchor(top: placeholderLabel.bottomAnchor, leading: placeholderLabel.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: -25, left: -6, bottom: 0, right: 16))
    }
    
    @objc fileprivate func handlePost(){
        
    }

    

}
