//
//  ImageViewController.swift
//  ScreenShot
//
//  Created by 伊藤 翔 on 2019/02/01.
//  Copyright © 2019 aryzae. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard touches.count == 1 else { return }
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Public Method
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

}
