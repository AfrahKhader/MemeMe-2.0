//
//  SentMemeDetailView.swift
//  ImagePickerExperment
//
//  Created by Afrah kheder on 28/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class SentMemeDetailView : UIViewController {
    
    @IBOutlet weak var imageDetail: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageDetail!.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
  

}

