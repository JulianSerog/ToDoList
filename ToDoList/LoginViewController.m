//
//  ViewController.m
//  Announcement!
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "LoginViewController.h"
#define facebookBlue [UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0]


@interface ViewController ()

@end

@implementation ViewController

@synthesize title, loginButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addElements];
    
    
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
    
    //add to view
    [self.view addSubview:self.title];
    [self.view addSubview:self.loginButton];
    
    
}//addElements


-(void)nextView
{
    [self performSegueWithIdentifier:@"next" sender:self];
}//nextView









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
