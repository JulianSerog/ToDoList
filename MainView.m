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


@interface MainView ()

@end



@implementation MainView

@synthesize tableView, addNoteButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteTitle = @"";
    self.noteBody = @"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.noteArray = [[defaults objectForKey:@"noteArray"] mutableCopy];
    
    [self addElements];
}//viewDidLoad


-(void) addElements
{
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.1, self.view.frame.size.width, self.view.frame.size.height * 0.9) style:UITableViewStylePlain]; //style is temporary
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
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
    
    
    //get items from locally saved list
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"noteTitle"];
    NSLog(@"From main Menu, saved item: %@",value);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.tableView addGestureRecognizer:tap];
    
    //addElements
    [self.view addSubview:self.addNoteButton];
    [self.view addSubview:self.tableView];

}//addElements


//MARK: Create table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.noteArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //do stuff
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [self.noteArray[indexPath.row] objectForKey:@"title"];
    
    return cell;
}//cellForRowAtIndexPath

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NoteView *noteView = [segue destinationViewController];
    noteView.strBody = self.noteBody;
    noteView.strTitle = self.noteTitle;
}


//detects taps on a cell
-(void) didTapOnTableView:(UIGestureRecognizer*) recognizer
{
    CGPoint tapLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    
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


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //NSLog(@"delete tapped");
        [self.noteArray removeObjectAtIndex:indexPath.row];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.noteArray forKey:@"noteArray"];
        [self.tableView reloadData];
    }//if
}//delete handler


-(void) addNotePressed
{
    //NSLog(@"addNotePressed");
    [self performSegueWithIdentifier:@"toNote" sender:self];
}



@end
