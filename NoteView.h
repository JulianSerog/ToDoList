//
//  NoteView.h
//  ToDoList
//
//  Created by Esa Serog on 3/27/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteView : UIViewController


@property(strong,nonatomic) UIButton *doneButton;
@property(strong,nonatomic) UITextField *noteTextField;
@property(strong,nonatomic) Note *note;
@property(strong, nonatomic) UITextField *viewTitle;


@end
