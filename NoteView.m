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
    [self loadNote]; //load note if one is available
    
    
    //textfield title
    self.viewTitle = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight * 0.1)];
    //[self.viewTitle setPlaceholder:@"untitled note"];
    [self.viewTitle setText:@"Untitled Note"]; //MARK: might have to change later on
    [self.viewTitle setBackgroundColor:[UIColor lightGrayColor]];
    [self.viewTitle.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.viewTitle.layer setBorderWidth:1];
    [self.viewTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewTitle setTextColor:[UIColor whiteColor]];
    
    
    //done button
    self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight * 0.9, viewWidth, viewHeight * 0.1)];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor blackColor]];
    [self.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton.layer setCornerRadius:4.0];
    
    
    //textfield
    self.noteTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, viewHeight * 0.1, viewWidth, viewHeight * 0.8)];
    self.noteTextView.delegate = self;
    [self.noteTextView setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
    [self.noteTextView.layer setBorderWidth:1];
    [self.noteTextView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    
    
    
    
    //placeholder label
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight * 0.4, viewWidth, viewHeight * 0.1)];
    [self.placeholder setTextAlignment:NSTextAlignmentCenter];
    [self.placeholder setTextColor:[UIColor blackColor]];
    [self.placeholder setAlpha:0.5];
    [self.placeholder setText:@"Add a note"];
    
    
    
    [self.view addSubview:self.viewTitle];
    [self.view addSubview:self.doneButton];
    [self.view addSubview:self.noteTextView];
    [self.view addSubview:self.placeholder];
}//addUI


- (BOOL)textViewDidBeginEditing:(UITextView *)textView
{
    [self.placeholder removeFromSuperview];
    return TRUE;
}

//-(void)textViewPressed
//{
//    [self.view willRemoveSubview:self.placeholder];
//}//textViewPressed

//loads note from parse -- maybe store locally?
-(void)loadNote
{
    //TODO: implement
}//loadNote
-(void)saveNote
{
    //used for trimming strings
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    [self.viewTitle.text stringByTrimmingCharactersInSet:charSet];
    [self.noteTextView.text stringByTrimmingCharactersInSet:charSet];
    
    //check if valid name and contents
    if ([self.noteTextView isEqual:@""] && ![self.noteTextView.text isEqualToString:@""])
    {
        self.note.noteTitle = self.viewTitle.text;
        self.note.contents = self.noteTextView.text;
        NSLog(@"valid note: Title: %@ Body: %@", self.viewTitle.text, self.noteTextView.text);
        //TODO: upload to parse
    }//if - title is default, but body is not
    else if(![self.viewTitle.text isEqualToString:@""] && [self.noteTextView.text isEqualToString:@""])
    {
        self.note.noteTitle = self.viewTitle.text;
        self.note.contents = self.noteTextView.text;
        NSLog(@"valid note: Title: %@ Body: %@", self.viewTitle.text, self.noteTextView.text);
    }//body is default but title is not
    else if(![self.viewTitle.text isEqualToString:@"untitled note"] && ![self.viewTitle.text isEqualToString:@""] && ![self.noteTextView.text isEqualToString:@""])
    {
        self.note.noteTitle = self.viewTitle.text;
        self.note.contents = self.noteTextView.text;
        NSLog(@"valid note: Title: %@ Body: %@", self.viewTitle.text, self.noteTextView.text);
    }//neither title or body are defaults
    else
    {
        NSLog(@"Not a valid note, must have a valid title or some text in the body");
    }//not a valid note -- test
}//saveNote


-(void) doneButtonPressed
{
    //should segue out of view, and change the title of the NoteView to the note object title
    //or if the string != "untitled note" && not white space/empty set it to the newly set title
    [self saveNote];
    [self performSegueWithIdentifier:@"toMainView" sender:self];
}//doneButtonPressed


//TODO: load in and save note functionality


@end

