//
//  NetworkUtils.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 30/10/16.
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
import AlamofireImage

func downloadImage(imageView: UIImageView, activityIndicator: UIActivityIndicatorView, urlString: String) {

    let placeholderImage: UIImage = UIImage.init(named: kContentPlaceholderImage)!
    
    activityIndicator.startAnimating()
    
    imageView.af_setImage(
        withURL: URL(string: urlString)!,
        placeholderImage: placeholderImage,
        //filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 20.0),
        filter: nil,
        imageTransition: .crossDissolve(0.2),
        completion: { [weak activityIndicator] (dataResponseImage) in
            
            activityIndicator?.stopAnimating()
        }
    )
}
