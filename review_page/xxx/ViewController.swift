//
//  ViewController.swift
//  xxx
//
//  Created by Yan Cheng Cheok on 14/08/2024.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var scrollViewHeight: NSLayoutConstraint!
    
    @IBOutlet var views: [UIView]!
    
    @IBOutlet var stackViews: [UIStackView]!
    
    @IBOutlet var labels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        
        updateScrollViewHeight(for: 0)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(">>>> scrollView.contentOffset.x \(scrollView.contentOffset.x)")
        print(">>>> scrollView.frame.width \(scrollView.frame.width)")
        
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        updateScrollViewHeight(for: pageIndex)
    }
    
    func updateScrollViewHeight(for pageIndex: Int) {
        guard pageIndex < stackViews.count else { return }
        let label = stackViews[pageIndex]
        
        
        // systemLayoutSizeFittingSize vs. sizeThatFits
        // https://tingyishih.medium.com/paginated-scroll-view-with-partial-previous-next-page-visible-655159fcdd50
        let size = label.systemLayoutSizeFitting(CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        
        print(">>>> size \(size)")
        
        UIView.animate(withDuration: 0.3) {
            self.scrollViewHeight?.constant = size.height + 40 // Add some padding
            self.view.layoutIfNeeded()
        }
    }
}

