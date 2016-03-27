//
//  Note.m
//  ToDoList
//
//  Created by Esa Serog on 3/27/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "Note.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>

@implementation Note


-(void) initWithTitle:(NSString*)title NoteContents:(NSString*)contents
{
    self.noteTitle = title;
    self.contents = contents;
}//constructor

//maybe create a different initializer that just grabs the first word of the contents for the title


@end
