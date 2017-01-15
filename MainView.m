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
#import "NoteView.h"

#define facebookBlue [UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1.0]

NSString *cusTableCell = @"CusTableCell";


@interface MainView ()

@end

@implementation MainView

@synthesize noteTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteTitle = @"";
    self.noteBody = @"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.noteArray = [[defaults objectForKey:@"noteArray"] mutableCopy];
    
    [self addElements];
}//viewDidLoad

-(void)viewDidAppear:(BOOL)animated {
    [self.noteTableView reloadData];
    self.title = @"Noted!";
}//viewDidAppear

-(void) addElements {
    //custom nav bar stuff
    //self.logout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutPressed)];
    //new note button
    self.btn = [[UIBarButtonItem alloc]initWithTitle:@"New Note" style:UIBarButtonItemStyleDone target:self action:@selector(addNotePressed)];
    self.navigationItem.rightBarButtonItem = self.btn;
    //logout button
    //self.navigationItem.leftBarButtonItem = self.logout;
    //set title of app
    self.title = @"Noted!";
    
    //add table view method
    [self addtableView];
    
    [self checkForNotes];
    
}//addElements


//this method creates a label telling the user that no notes exist
-(void) checkForNotes {
    if (self.noteArray.count == 0) {
        NSLog(@"creating label");
        UILabel *noNotesLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.4, self.view.frame.size.width, self.view.frame.size.height * 0.2)];
        [noNotesLbl setTextAlignment:NSTextAlignmentCenter];
        [noNotesLbl setText:@"You currently have no notes saved!"];
        
        [self.view addSubview:noNotesLbl]; //add label to view
    }
}


-(void)addtableView {
    //tableview
    self.noteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 1.0) style:UITableViewStylePlain]; //style is temporary
    
    //register class
    [self.noteTableView registerClass:CustomTableCell.self forCellReuseIdentifier:cusTableCell];
    //set delegates and data source
    [self.noteTableView setDelegate:self];
    [self.noteTableView setDataSource:self];
    [self.noteTableView setBackgroundColor:[UIColor grayColor]];
    [self.noteTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //get items from locally saved list
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"noteTitle"];
    NSLog(@"From main Menu, saved item: %@",value);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.noteTableView addGestureRecognizer:tap];
    
    //addElements
    [self.view addSubview:self.noteTableView];
}//addTableView


//MARK: Create table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noteArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableCell *cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cusTableCell];
    
    [cell.cellTitle setText:[self.noteArray[indexPath.row] objectForKey:@"title"]];
        return cell;
}//cellForRowAtIndexPath

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NoteView *noteView = [segue destinationViewController];
    noteView.strBody = self.noteBody;
    noteView.strTitle = self.noteTitle;
}//prepare for segue


//detects taps on a cell
-(void) didTapOnTableView:(UIGestureRecognizer*) recognizer {
    CGPoint tapLocation = [recognizer locationInView:self.noteTableView];
    NSIndexPath *indexPath = [self.noteTableView indexPathForRowAtPoint:tapLocation];
    
    if (indexPath) { //we are in a tableview cell, let the gesture be handled by the view
        //NSLog(@"%@", [self.noteArray[indexPath.row] objectForKey:@"title"]);
        //NSLog(@"%@", [self.noteArray[indexPath.row] objectForKey:@"body"]);
        self.noteTitle = [self.noteArray[indexPath.row] objectForKey:@"title"];
        self.noteBody = [self.noteArray[indexPath.row] objectForKey:@"body"];
        
        [self performSegueWithIdentifier:@"toNote" sender:self];
    } else { // anywhere else, do what is needed for your case
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"touched something else than a cell");
    }//else
}//didTapOnTableView


//delete handler
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //NSLog(@"delete tapped");
        [self.noteArray removeObjectAtIndex:indexPath.row];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.noteArray forKey:@"noteArray"];
        [self.noteTableView reloadData];
        [self checkForNotes];
    }//if
}//delete handler

-(void) addNotePressed {
    //reset title and body strings to empty for a new note
    self.noteTitle = @"";
    self.noteBody = @"";
    [self performSegueWithIdentifier:@"toNote" sender:self];
}//addNotePressed


-(void) logoutPressed {
    NSLog(@"logout pressed");
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    //TODO: find a way to logout delete local notes and segue out to main view
}

@end
