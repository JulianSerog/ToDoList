//
//  AppDelegate.h
//  ToDoList
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



@property(strong, nonatomic) UIViewController *loginView;
@property(strong, nonatomic) UITableViewController *tableView;


@end

