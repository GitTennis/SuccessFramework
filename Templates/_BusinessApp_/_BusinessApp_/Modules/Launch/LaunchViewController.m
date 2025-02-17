//
//  LaunchViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
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

#import "LaunchViewController.h"
#import "ConnectionStatusLabel.h"
#import "UIView+Autolayout.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)dealloc {
    
    [self.reachabilityManager removeServiceObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.reachabilityManager = [[ReachabilityManager alloc] init];
    [self.reachabilityManager addServiceObserver:self];
    
    [self prepareUI];
}

- (void)prepareUI {
    
    // Use and set the same launch image as screen background image
    NSString *launchImageName = [self launchImageNameForOrientation:self.interfaceOrientation];
    _backgroundImageView.image = [UIImage imageNamed:launchImageName];
}

#pragma mark - Protected -

#pragma mark ReachabilityManagerObserver

- (void)internetDidBecomeOn {
    
    ConnectionStatusLabel *label = (ConnectionStatusLabel *)[self.view viewWithTag:kConnectionStatusLabelTag];
    [label removeFromSuperview];
}

- (void)internetDidBecomeOff {
    
    ConnectionStatusLabel *label = (ConnectionStatusLabel *)[self.view viewWithTag:kConnectionStatusLabelTag];
    
    if (!label) {
        
        ConnectionStatusLabel *label = [[ConnectionStatusLabel alloc] init];
        [self.view addSubview:label];
        
        CGFloat margin = self.view.bounds.size.width * 0.1f;
        
        [label viewAddLeadingSpace:margin containerView:self.view];
        [label viewAddTrailingSpace:-margin containerView:self.view];
        [label viewAddTopSpace:margin containerView:self.view];
    }
}

#pragma mark - Private -

// Used from: http://stackoverflow.com/a/27797958/597292
- (NSString *)launchImageNameForOrientation:(UIInterfaceOrientation)orientation {
    
    CGSize viewSize = self.view.bounds.size;
    NSString *viewOrientation = @"Portrait";
    
    // Adjust for landscape mode
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        
        // Remove later when iOS 7 is not needed.
        if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
            
            viewSize = CGSizeMake(viewSize.height, viewSize.width);
        }
        
        viewOrientation = @"Landscape";
    }
    
    // Extract loaded launch images
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    // Loop through loaded launch images
    for (NSDictionary *dict in imagesDict) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        // Return if launch image is found in loaded plist
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            
            return dict[@"UILaunchImageName"];
    }
    
    return nil;
}

@end
