//
//  ViewController.h
//  Announcement!
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>


@interface LoginViewController : UIViewController

@property(strong, nonatomic) UILabel *title;
@property(strong,nonatomic) UIButton *altLoginButton;
@property(strong, nonatomic) UITableViewController *tableView;
@property(strong, nonatomic) UIImage *logo;
@property(strong, nonatomic) UIImageView *logoView;
@property(strong, nonatomic) FBSDKLoginButton *loginButton;
//user
@property(strong, nonatomic,readwrite) PFUser *user;
@end

