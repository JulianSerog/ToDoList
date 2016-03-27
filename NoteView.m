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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
    
}//viewDidLoad



-(void)addUI
{
    [self loadNote];
    
    //label
    self.viewTitle = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight * 0.1)];
    [self.viewTitle setPlaceholder:@"untitled note"];
    [self.viewTitle setBackgroundColor:[UIColor lightGrayColor]];
    [self.viewTitle.layer setCornerRadius:4.0];
    [self.viewTitle setTextAlignment:NSTextAlignmentCenter];
    [self.viewTitle setTextColor:[UIColor whiteColor]];
    
    
    //done button
    self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight * 0.9, viewWidth, viewHeight * 0.1)];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor blackColor]];
    [self.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton.layer setCornerRadius:4.0];
    
    
    //textfield
    self.noteTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, viewHeight * 0.1, viewWidth, viewHeight * 0.8)];
    [self.noteTextField setPlaceholder:@"Enter your note here!"];
    [self.noteTextField setTextAlignment:NSTextAlignmentCenter];
    [self.noteTextField addTarget:self action:@selector(changeTextAlignment) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:self.viewTitle];
    [self.view addSubview:self.doneButton];
    [self.view addSubview:self.noteTextField];
}//addUI

-(void)changeTextAlignment
{
    [self.noteTextField setTextAlignment:NSTextAlignmentLeft];
}//changeTextAlignment


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
    [self.noteTextField.text stringByTrimmingCharactersInSet:charSet];
    
    //check if valid name and contents
    if ([self.viewTitle isEqual:@""] && ![self.noteTextField.text isEqualToString:@""])
    {
        self.note.noteTitle = self.viewTitle.text;
        self.note.contents = self.noteTextField.text;
        //TODO: upload to parse
    }//if - title is default, but body is not
    else if(![self.viewTitle.text isEqualToString:@""] && [self.noteTextField.text isEqualToString:@""])
    {
        self.note.noteTitle = self.viewTitle.text;
        self.note.contents = self.noteTextField.text;
    }//body is default but title is not
    else if(![self.viewTitle.text isEqualToString:@"untitled note"] && ![self.viewTitle.text isEqualToString:@""] && ![self.noteTextField.text isEqualToString:@""])
    {
        self.note.noteTitle = self.viewTitle.text;
        self.note.contents = self.noteTextField.text;
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
