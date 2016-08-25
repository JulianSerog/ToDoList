//
//  CustomTableCell.m
//  ToDoList
//
//  Created by Esa Serog on 8/10/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

-(id)init {
    self = [super init];
    
    //set properties
    [self setBackgroundColor:[UIColor grayColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    
    //container
    self.container = [[UILabel alloc] init];
    //[self.container setBackgroundColor:[UIColor blackColor]];
    self.container.layer.cornerRadius = 8.0;
    [self.container.layer setMasksToBounds:YES];
    [self addSubview:self.container];
    
    //label
    self.cellTitle = [[UILabel alloc] init];
    [self.cellTitle setTextColor:[UIColor whiteColor]];
    [self.container addSubview:self.textLabel];
    //[self.container bringSubviewToFront:self.cellTitle];
    return self;
}

-(id)initWithTitle:(NSString *)title {
    self = [super init];



    
    //set properties
    [self setBackgroundColor:[UIColor grayColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    
    //container
    self.container = [[UILabel alloc] init];
    //[self.container setBackgroundColor:[UIColor blackColor]];
    self.container.layer.cornerRadius = 8.0;
    [self.container.layer setMasksToBounds:YES];
    [self addSubview:self.container];
    
    //label
    self.cellTitle = [[UILabel alloc] init];
    [self.cellTitle setTextColor:[UIColor whiteColor]];
    [self.container addSubview:self.textLabel];
    //[self.container bringSubviewToFront:self.cellTitle];
    return self;
}//initWithWitle

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    

    //set properties
    [self setBackgroundColor:[UIColor grayColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    


    //container
    self.container = [[UILabel alloc] init];
    [self.container setBackgroundColor:[UIColor blackColor]];
    self.container.layer.cornerRadius = 8.0;
    [self.container.layer setMasksToBounds:YES];
    [self addSubview:self.container];
    
    //label
    self.cellTitle = [[UILabel alloc] init];
    [self.cellTitle setTextColor:[UIColor whiteColor]];
    [self.container addSubview:self.cellTitle];
    //[self.container bringSubviewToFront:self.cellTitle];
    
    
    return self;
}//initWithStyle


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.container setFrame:CGRectMake(self.frame.size.width * 0.025, self.frame.size.height * 0.05, self.frame.size.width * 0.95, self.frame.size.height * 0.9)];
    [self.cellTitle setFrame:CGRectMake(5, 5, self.container.frame.size.width - 10, self.container.frame.size.height - 10)];
}//layoutSubviews

@end
