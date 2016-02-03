//
//  ViewController.h
//  Announcement!
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController

@property(strong, nonatomic) UILabel *title;
@property(strong,nonatomic) UIButton *loginButton, *altLoginButton;

//user
@property(strong,nonatomic) PFUser *user;

@end

