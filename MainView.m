//
//  MainView.m
//  ToDoList
//
//  Created by Esa Serog on 3/25/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "MainView.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>

#define facebookBlue [UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0]


@interface MainView ()

@end



@implementation MainView

@synthesize tableView, addNoteButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addElements];
    
    
}//viewDidLoad


-(void) addElements
{
    //addbutton
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.1, self.view.frame.size.width, self.view.frame.size.height * 0.9) style:UITableViewStylePlain]; //style is temporary
    self.addNoteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.1)];
    
    [self.addNoteButton setBackgroundColor:[UIColor blueColor]];
    [self.addNoteButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.addNoteButton setTitle:@"Add a Note" forState:UIControlStateNormal];
    [self.addNoteButton addTarget:self action:@selector(addNotePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.addNoteButton.layer setCornerRadius:4.0];
    
    
    
    [self.view addSubview:self.addNoteButton];
    [self.view addSubview:self.tableView];
}//addElements


-(void) addNotePressed
{
    NSLog(@"addNotePressed");
    [self performSegueWithIdentifier:@"toNote" sender:self];
}



@end
