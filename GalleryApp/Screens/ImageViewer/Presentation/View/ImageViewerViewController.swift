//
//  ImageViewerViewController.swift
//  GalleryApp
//
//  Created by Mohamed Kotb on 15/09/2025.
//

import UIKit
import Kingfisher

class ImageViewerViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    let imageUrl: URL
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupGestureRecognizers()
        loadImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerImage()
    }

    // MARK: - Setup
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
    }
    
    private func setupGestureRecognizers() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
    }
    
    private func loadImage() {
        // Using Kingfisher to load remote image
        image.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "placeholder"))
        image.contentMode = .scaleAspectFit
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }

    private func centerImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = image.frame.size
        
        let verticalInset = imageSize.height < scrollViewSize.height
            ? (scrollViewSize.height - imageSize.height) / 2
            : 0
        
        let horizontalInset = imageSize.width < scrollViewSize.width
            ? (scrollViewSize.width - imageSize.width) / 2
            : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalInset,
                                               left: horizontalInset,
                                               bottom: verticalInset,
                                               right: horizontalInset)
    }

    
    // MARK: - Zooming
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let pointInView = gesture.location(in: image)
        
        if scrollView.zoomScale == 1 {
            // Zoom in
            let newZoomScale: CGFloat = 2.0
            let scrollViewSize = scrollView.bounds.size
            
            let width = scrollViewSize.width / newZoomScale
            let height = scrollViewSize.height / newZoomScale
            let originX = pointInView.x - (width / 2.0)
            let originY = pointInView.y - (height / 2.0)
            
            let rectToZoom = CGRect(x: originX, y: originY, width: width, height: height)
            scrollView.zoom(to: rectToZoom, animated: true)
        } else {
            // Reset to normal
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func shareBtn(sender: Any) {
        guard let imageToShare = image.image else { return }
        
        let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    @IBAction func closeBtn(sender: Any) {
        dismiss(animated: true)
    }
}
