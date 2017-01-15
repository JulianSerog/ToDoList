//
//  ViewController.m
//  Announcement!
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "LoginViewController.h"
#define facebookBlue [UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0]


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize title, loginButton, altLoginButton, user, tableView, logo, logoView;
    

-(void)viewWillAppear:(BOOL)animated
{
    [self checkFacebook];
}//viewWillAppear


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
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(checkFacebook) userInfo:nil repeats:YES];
    
}


-(void) addElements
{
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    //label
    self.viewTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.10)];
    [self.viewTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewTitle setText:@"Login To Continue!"];
    [self.viewTitle setAlpha:0.35];
    [self.viewTitle setBackgroundColor:[UIColor blackColor]];
    [self.viewTitle setTextColor:[UIColor whiteColor]];
    

    //other login in button
    self.altLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0, self.view.frame.size.height * 0.8, self.view.frame.size.width , self.view.frame.size.height * 0.1)];
    //self.altLoginButton.frame = loginButton.frame;
    [self.altLoginButton setTitle:@"Create an account/Sign in without facebook" forState:UIControlStateNormal];
    [self.altLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.altLoginButton addTarget:self action:@selector(toCustomLogin) forControlEvents:UIControlEventTouchUpInside];
    
    //logo
    self.logoView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .30, self.view.frame.size.height * 0.2, self.view.frame.size.width * 0.4, self.view.frame.size.height * 0.3)];
    self.logo = [UIImage imageNamed:@"logo.png"];
    [self.logoView setImage:self.logo];
    
    
    //FBLoginButton
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"]; //TODO: implement permissions
    [self.loginButton setFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.7, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.1)];
    
    //add to view
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.title];
    //[self.view addSubview:self.loginButton];  //TODO: get original login button working
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

-(void)startFBLogin
{
    //TODO: complete
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"public_profile", @"email", @"friends", nil];
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *FBuser, NSError *error) {
    if (!FBuser)
    {
        NSLog(@"Uh oh. The user cancelled the Facebook login.");
    }//user is not valid
    else if (FBuser.isNew)
    {
        NSLog(@"User signed up and logged in through Facebook!");
        //lastly, switch views
        [self performSegueWithIdentifier:@"nextView" sender:self];
    }//elseif user is new
    else
    {
        NSLog(@"User logged in through Facebook!");
        //lastly, switch views
        [self performSegueWithIdentifier:@"nextView" sender:self];

    }//else - user logged in through fb button
}];
}//startFBLogin


-(void)checkFacebook
{
    if([FBSDKAccessToken currentAccessToken]){
        [self performSegueWithIdentifier:@"toTable1" sender:self];
    }//if
}//checkFacebook




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
