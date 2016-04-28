//
//  Note.m
//  ToDoList
//
//  Created by Esa Serog on 4/28/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "Note.h"

@implementation Note


-(instancetype)initWithTitle:(NSString *)title andBody:(NSString *)body
{
    self = [super init];
    
    
    self.title = title;
    self.body = body;
    
    return self;
}//initwithtitle

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return self;
}

@end
