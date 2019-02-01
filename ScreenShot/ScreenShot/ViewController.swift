//
//  ViewController.swift
//  ScreenShot
//
//  Created by aryzae on 2019/02/01.
//  Copyright © 2019 aryzae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var teaGreenView: UIView!
    @IBOutlet weak var tuscanView: UIView!
    @IBOutlet weak var neonCarrotView: UIView!
    @IBOutlet weak var burntOrangeView: UIView!
    @IBOutlet weak var smokeyTopazView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Private Method
    @IBAction private func touchUpInsideVC(_ sender: UIButton) {
        let image = screenShot(size: view.bounds.size, view: view)
        presentImageViewController(image)
    }

    @IBAction private func touchUpInsideScrollView(_ sender: UIButton) {
        let image = screenShot(size: scrollView.contentSize, view: contentView)
        presentImageViewController(image)
    }

    @IBAction private func touchUpInsideCutAndPaste(_ sender: UIButton) {
        let teaGreenViewImage = screenShot(size: teaGreenView.bounds.size, view: teaGreenView)
        let neonCarrotViewImage = screenShot(size: neonCarrotView.bounds.size, view: neonCarrotView)
        let smokeyTopazViewImage = screenShot(size: smokeyTopazView.bounds.size, view: smokeyTopazView)
        let image = mergeImages([teaGreenViewImage, neonCarrotViewImage, smokeyTopazViewImage])
        presentImageViewController(image)
    }

    private func presentImageViewController(_ image: UIImage?) {
        guard let viewController = UIStoryboard(name: "ImageViewController", bundle: .main).instantiateInitialViewController() as? ImageViewController else { return }
        present(viewController, animated: true) {
            viewController.setImage(image)
        }
    }

    private func screenShot(size: CGSize, view: UIView) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    private func mergeImages(_ images: [UIImage?]) -> UIImage? {
        let _images = images.compactMap { $0 }
        let width = _images.max(by: { $0.size.width > $1.size.width })?.size.width ?? 0
        let height = _images.reduce(0.0, { $0 + $1.size.height })
        let canvasSize = CGSize(width: width, height: height)
        // make image
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(canvasSize)
        // draw
        var offset: CGPoint = .zero
        _images.forEach { image in
            let rect = CGRect(origin: offset, size: image.size)
            image.draw(in: rect)
            offset.y += image.size.height
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
