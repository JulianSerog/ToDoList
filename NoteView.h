//
//  NoteView.h
//  ToDoList
//
//  Created by Esa Serog on 3/27/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"


@interface NoteView : UIViewController <UITextViewDelegate, UITextFieldDelegate>


@property(strong,nonatomic) UIButton *doneButton;
@property(strong,nonatomic) UITextView *noteBody;
@property(strong, nonatomic) UITextField *noteTitle;
@property(strong, nonatomic) MainView *instanceOfMainView;
@property(strong, nonatomic) UILabel *placeholder;
@property(strong, nonatomic) NSString *strTitle; //used to pass data through old VC
@property(strong, nonatomic) NSString *strBody; //used to pass data through old VC


@end
