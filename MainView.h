//
//  MainView.h
//  ToDoList
//
//  Created by Esa Serog on 3/25/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *noteArray;
@property(strong, nonatomic) NSString *noteTitle;
@property(strong, nonatomic) NSString *noteBody;
@property(strong, nonatomic) UIBarButtonItem *logout;

@end
