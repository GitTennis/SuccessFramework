//
//  BaseWebViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 06/11/16.
//  Copyright © 2016 Gytenis Mikulėnas 
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

import UIKit

class BaseWebViewController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView?
    
    override func prepareUI() {
        
        super.prepareUI()
        
        self.webView?.scalesPageToFit = true
    }
    
    // MARK: UIWebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
     
        self.viewLoader?.showScreenActivityIndicator(containerView: webView)
     
        return true
     }
     
     func webViewDidFinishLoad(_ webView: UIWebView) {
     
        self.viewLoader?.hideScreenActivityIndicator(containerView: webView)
     }
     
     func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
     
        self.viewLoader?.hideScreenActivityIndicator(containerView: webView)
     }
}
