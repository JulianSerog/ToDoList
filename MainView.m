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
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.1, self.view.frame.size.width, self.view.frame.size.height * 0.9) style:UITableViewStylePlain]; //style is temporary
    [self.tableView setBackgroundColor:[UIColor grayColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched]; //TODO: figure out how to change style
    
    //addnoteButton
    self.addNoteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.1)];
    [self.addNoteButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.addNoteButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    //[self.addNoteButton.layer setBorderWidth:1.0];
    [self.addNoteButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.addNoteButton setTitle:@"Add a Note" forState:UIControlStateNormal];
    [self.addNoteButton addTarget:self action:@selector(addNotePressed) forControlEvents:UIControlEventTouchUpInside];
    
    //testing a table cell
    UITableViewCell *testCell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height * 0.05, self.tableView.frame.size.width, self.tableView.frame.size.height * 0.1)];
    [testCell setBackgroundColor:[UIColor blackColor]];
    [self.tableView addSubview:testCell];
    
    //addElements
    [self.view addSubview:self.addNoteButton];
    [self.view addSubview:self.tableView];

   }//addElements

//TODO:implement
-(void)addNotes
{
    
}


-(void) addNotePressed
{
    NSLog(@"addNotePressed");
    [self performSegueWithIdentifier:@"toNote" sender:self];
}



@end
