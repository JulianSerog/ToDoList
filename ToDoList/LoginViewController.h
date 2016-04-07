//
//  ViewController.h
//  Announcement!
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController

@property(strong, nonatomic) UILabel *title;
@property(strong,nonatomic) UIButton *loginButton, *altLoginButton;
@property(strong, nonatomic) UIImage *logo;
@property(strong, nonatomic) UITableViewController *tableView;
@property(strong, nonatomic) UIImageView *logoView;
//user
@property(strong, nonatomic,readwrite) PFUser *user;
@end

