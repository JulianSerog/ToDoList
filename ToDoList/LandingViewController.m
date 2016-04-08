//
//  LandingViewController.m
//  ToDoList
//
//  Created by Esa Serog on 2/3/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

//this view is used to determine which view to enter whether user is new or not.

#import "LandingViewController.h"

@interface LandingViewController ()

@end

@implementation LandingViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO]; //MARK: you must use this special parent method if you want to completely skip this view - used for login views
    [self checkFacebook];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        //login to notes page
        [self performSegueWithIdentifier:@"start" sender:self];
        
    }
    else
    {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    
    // Do any additional setup after loading the view.

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)checkFacebook
{
    if([FBSDKAccessToken currentAccessToken]){
        [self performSegueWithIdentifier:@"start" sender:self];
    }//if
}//checkFacebook


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
