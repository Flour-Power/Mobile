//
//  WSVViewController.swift
//  FlourPower
//
//  Created by Kelly Robinson on 3/1/16.
//  Copyright © 2016 Kelly Robinson. All rights reserved.
//

import UIKit
import WebKit

class WSVViewController: UIViewController, WKNavigationDelegate {
    
    var recipe: Recipe!
    var webView : WKWebView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    
    func webView(webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webView(webView: WKWebView,
                 didFinishNavigation navigation: WKNavigation){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: WKWebView,
                 decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse,
                                                   decisionHandler: ((WKNavigationResponsePolicy) -> Void)){
        
        print(navigationResponse.response.MIMEType)
        
        decisionHandler(.Allow)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        webView = WKWebView()
        containerView.addSubview(webView)
        print(containerView.bounds.width)
        
        guard let url = NSURL(string: recipe.recipeSourceURL ?? "") else { return }
        
        webView.loadRequest(NSURLRequest(URL: url))
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let frame = CGRectMake(0, 0, self.containerView.bounds.width, self.containerView.bounds.height)
        self.webView.frame = frame
        
    }
    
}




