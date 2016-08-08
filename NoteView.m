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
    [self.noteTitle setReturnKeyType:UIReturnKeyDone];
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
    [self.noteBody setKeyboardType:UIKeyboardTypeAlphabet];
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


-(BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [self.noteTitle resignFirstResponder];
    return YES;
}//textFieldShouldReturn


-(void)parseNote
{
    //used for trimming strings
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    [self.noteTitle.text stringByTrimmingCharactersInSet:charSet];
    [self.noteBody.text stringByTrimmingCharactersInSet:charSet];
    
    //check if valid name and contents
    if ( ![self.noteTitle.text isEqualToString:@""] && ![self.noteBody.text isEqualToString:@""])
    {
        //NSLog(@"valid note1: Title: %@ Body: %@", self.noteTitle.text, self.noteBody.text);
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

-(void)saveNoteWithTitle:(NSString *)noteTitle contents:(NSString *)noteBody
{
    /*
    PFObject *PFnote = [PFObject objectWithClassName:@"PFnote"];
    PFnote[@"title"] = noteTitle;
    PFnote[@"contents"] = noteBody;
    //save locally first
    [PFnote pinInBackground];
     */
    NSDictionary *noteValues = @{@"title" : noteTitle, @"body" : noteBody}; //create dictionary to store note values
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if ([[[defaults dictionaryRepresentation] allKeys] containsObject:@"noteArray"])
    {
        //append the new note onto the array
        if ([self noteExists:noteTitle])
        {
            
            UIAlertController *alertNote = [UIAlertController alertControllerWithTitle:@"Duplicate Note!" message:@"You are trying to overwrite a note with the same title, are you sure you want to do this?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *overwrite = [UIAlertAction actionWithTitle:@"Overwrite" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //overwrite note in background
                NSMutableArray *notes = [[NSMutableArray alloc]init];//[[defaults objectForKey:@"noteArray"] mutableCopy];
                for (NSDictionary *i in [defaults objectForKey:@"noteArray"]) {
                    [notes addObject:[i mutableCopy]];
                }//for
                
                for(int i = 0; i < [notes count]; i++)
                {
                    NSLog(@"note: %@", notes[i]);
                    if ([[notes[i] objectForKey:@"title"] isEqualToString:self.noteTitle.text]) {
                        [[notes objectAtIndex:i] setValue:self.noteBody.text forKey:@"body"];
                        NSArray *nonMutableNoteArray = notes;
                        [defaults setObject:nonMutableNoteArray forKey:@"noteArray"];
                        break;
                    }//if
                }//for
                
                [defaults synchronize]; //synchronize and segue out
                [self performSegueWithIdentifier:@"toMainView" sender:self];
            }]; //block that overwrites note in background
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
            //add actions to alert
            [alertNote addAction:cancel];
            [alertNote addAction:overwrite];
            //present the alert controller
            [self presentViewController:alertNote animated:YES completion:nil];
            //TODO: add a handler for duplicate notes for overwriting
        }//if the note exists
        else
        {
            NSMutableArray *tempArray = [[defaults objectForKey:@"noteArray"] mutableCopy];
            [tempArray addObject:noteValues];
            NSArray *addedArray = tempArray;
            [defaults setObject:addedArray forKey:@"noteArray"];
        }
    }//if
    else
    {
        //create notearray
        NSArray *noteArray = [[NSArray alloc] initWithObjects:noteValues, nil];
        //NSLog(@"Title: %@\nBody: %@", noteTitle, noteBody);
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

//returns true if note title is found in background
-(BOOL)noteExists:(NSString *)noteTitle
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    NSArray *notes = [defaults objectForKey:@"noteArray"];
    for (NSDictionary *i in notes)
    {
        if ([[i objectForKey:@"title"] isEqualToString:self.noteTitle.text])
            return true;
    }
    return false;
}//noteExists



-(void) doneButtonPressed
{
    //should segue out of view, and change the title of the NoteView to the note object title
    //or if the string != "untitled note" && not white space/empty set it to the newly set title
    [self parseNote];
    [self performSegueWithIdentifier:@"toMainView" sender:self];
}//doneButtonPressed

@end

