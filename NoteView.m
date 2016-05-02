//
//  NoteView.m
//  ToDoList
//
//  Created by Esa Serog on 3/27/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "NoteView.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>


#define viewWidth self.view.frame.size.width
#define viewHeight self.view.frame.size.height



@interface NoteView ()

@end



@implementation NoteView



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addUI];
    self.instanceOfMainView = [[MainView alloc] init];
    
}//viewDidLoad



-(void)addUI
{
    //textfield title
    self.noteTitle = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight * 0.1)];
    [self.noteTitle setBackgroundColor:[UIColor lightGrayColor]];
    [self.noteTitle.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.noteTitle.layer setBorderWidth:1];
    [self.noteTitle setTextAlignment:NSTextAlignmentCenter];
    [self.noteTitle setDelegate:self];
    [self.noteTitle setTextColor:[UIColor whiteColor]];
    [self.noteTitle setText:self.strTitle];
    if ([self.strTitle isEqualToString:@""])
        [self.noteTitle setPlaceholder:@"untitled note"]; //only add placeholder if it is a new note
    [self.view addSubview:self.noteTitle];
    
    //done button
    self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight * 0.9, viewWidth, viewHeight * 0.1)];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor blackColor]];
    [self.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneButton];
    
    
    //textfield
    self.noteBody = [[UITextView alloc] initWithFrame:CGRectMake(0, viewHeight * 0.1, viewWidth, viewHeight * 0.8)];
    [self.noteBody setDelegate:self];
    [self.noteBody setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
    [self.noteBody.layer setBorderWidth:1];
    [self.noteBody.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [self.noteBody setText:self.strBody];
    [self.view addSubview:self.noteBody];

    
    
    
    //placeholder label
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight * 0.4, viewWidth, viewHeight * 0.1)];
    [self.placeholder setTextAlignment:NSTextAlignmentCenter];
    [self.placeholder setTextColor:[UIColor blackColor]];
    [self.placeholder setAlpha:0.5];
    [self.placeholder setText:@"Add a note"];
    if ([self.strBody isEqualToString:@""])
        [self.view addSubview:self.placeholder]; //only add to subview if it is a new note
    
    
    
    
}//addUI


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.placeholder removeFromSuperview];
}//textViewDidBeginEditing



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}//textFieldDidBeginEditing


-(void)parseNote
{
    //used for trimming strings
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    [self.noteTitle.text stringByTrimmingCharactersInSet:charSet];
    [self.noteBody.text stringByTrimmingCharactersInSet:charSet];
    
    //check if valid name and contents
    if ( ![self.noteTitle.text isEqualToString:@""] && ![self.noteBody.text isEqualToString:@""])
    {
        NSLog(@"valid note1: Title: %@ Body: %@", self.noteTitle.text, self.noteBody.text);
        [self saveNoteWithTitle:self.noteTitle.text contents:self.noteBody.text];
    }//if - title is default, but body is not
    else if(![self.noteBody.text isEqualToString:@""] && [self.noteTitle.text isEqualToString:@""])
    {
        [self saveNoteWithTitle:@"Untitled Note" contents:self.noteBody.text];
    }
    else
    {
        NSLog(@"Not a valid note, must have a valid title or some text in the body");
    }//not a valid note -- test
}//parseNote

//TODO: fix method
-(void)saveNoteWithTitle:(NSString *)noteTitle contents:(NSString *)noteBody
{
    PFObject *PFnote = [PFObject objectWithClassName:@"PFnote"];
    
    PFnote[@"title"] = noteTitle;
    PFnote[@"contents"] = noteBody;
    
    //save locally first
    [PFnote pinInBackground];
    NSDictionary *noteValues = @{@"title" : noteTitle, @"body" : noteBody}; //create dictionary to store note values
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if ([[[defaults dictionaryRepresentation] allKeys] containsObject:@"noteArray"])
    {
        //append the new note onto the array
        NSMutableArray *tempArray = [[defaults objectForKey:@"noteArray"] mutableCopy];
        [tempArray addObject:noteValues];
        NSArray *addedArray = tempArray;
        [defaults setObject:addedArray forKey:@"noteArray"];
    }//if
    else
    {
        //create notearray
        NSArray *noteArray = [[NSArray alloc] initWithObjects:noteValues, nil];
        NSLog(@"Title: %@\nBody: %@", noteTitle, noteBody);
        [defaults setObject:noteArray forKey:@"noteArray"]; //store archived array
        [defaults synchronize];
    }//else
    
    //TODO: implement this laterattempt to upload to cloud
    /*
    [PFnote saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            // The object has been saved.
            NSLog(@"Succeeded in saving note to the backend!");
        }//if succeeded in background
        else
        {
            // There was a problem, check error.description and save eventually
            [PFnote saveEventually];
            NSLog(@"%@",error);
        }//else - if there was an error
    }]; //block
     */
}//saveNoteWithTitle



-(void) doneButtonPressed
{
    //should segue out of view, and change the title of the NoteView to the note object title
    //or if the string != "untitled note" && not white space/empty set it to the newly set title
    [self parseNote];
    [self performSegueWithIdentifier:@"toMainView" sender:self];
}//doneButtonPressed


//TODO: load in and save note functionality


@end

