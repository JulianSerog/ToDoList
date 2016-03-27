//
//  ViewController.m
//  Announcement!
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>

#define facebookBlue [UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0]


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize title, loginButton, altLoginButton, user;
    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addElements];
    
    
    //user = []
    
    
    //test for parse
    /*
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
    NSLog(@"%@",[testObject description]);
     */
    
}


-(void) addElements
{
    //label
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.10)];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.title setText:@"Login To Continue!"];
    [self.title setBackgroundColor:[UIColor blackColor]];
    [self.title setTextColor:[UIColor whiteColor]];
    
    //button
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.7, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.1)];
    [loginButton setBackgroundColor:facebookBlue];
    [loginButton setTitle:@"Login with facebook" forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 5;
    [loginButton addTarget:self action:@selector(nextView) forControlEvents:UIControlEventTouchUpInside];
    
    //other login in button
    self.altLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.8, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.1)];
    //self.altLoginButton.frame = loginButton.frame;
    [self.altLoginButton setTitle:@"Create an account" forState:UIControlStateNormal];
    [self.altLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.altLoginButton addTarget:self action:@selector(toCustomLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    //add to view
    [self.view addSubview:self.title];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.altLoginButton];
    
    
}//addElements


-(void)nextView
{
    [self performSegueWithIdentifier:@"toTable1" sender:self];
}//nextView
-(void)toCustomLogin
{
    [self performSegueWithIdentifier:@"customLogin" sender:self];
}//toCustomLogin

//MARK: startFBLogin
/*
-(void)startFBLogin
{
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}//startFBLogin
*/






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
