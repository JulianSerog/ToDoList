//
//  CustomLoginViewController.h
//  ToDoList
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CustomLoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property(strong, nonatomic) UILabel *viewLabel;
@property(strong, nonatomic) UITextField *username, *email, *password;
@property(strong, nonatomic,readwrite) PFUser *user;
@property(strong, nonatomic) UIButton *signUp, *loginButton;
@end
