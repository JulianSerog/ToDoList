//
//  NoteView.h
//  ToDoList
//
//  Created by Esa Serog on 3/27/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainView.h"

@interface NoteView : UIViewController <UITextFieldDelegate>


@property(strong,nonatomic) UIButton *doneButton;
@property(strong,nonatomic) UITextView *noteTextView;
@property(strong, nonatomic) UITextField *viewTitle;
@property(strong, nonatomic) MainView *instanceOfMainView;
@property(strong, nonatomic) UILabel *placeholder;

@end
