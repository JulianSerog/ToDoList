//
//  CustomTableCell.h
//  ToDoList
//
//  Created by Esa Serog on 8/10/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property(strong, nonatomic) UIView *container;
@property(strong, nonatomic) UILabel *cellTitle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)layoutSubviews;

@end
