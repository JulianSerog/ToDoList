//
//  Note.h
//  ToDoList
//
//  Created by Esa Serog on 4/28/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>


@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *body;


-(instancetype)initWithTitle:(NSString *)title andBody:(NSString *)body;

@end
