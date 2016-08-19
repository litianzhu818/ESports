//
//  ExtendTableViewHeaderView.h
//  Kissnapp
//
//  Created by Peter Lee on 15/7/15.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtendTableViewHeaderView : UITableViewHeaderFooterView

@property (assign, nonatomic) BOOL isExtend;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subTitle;
@property (assign, nonatomic) NSInteger sectionIndex;
@property (copy, nonatomic) void (^tapBlock)(NSInteger sectionIndex, BOOL isExtend);

- (void)setSectionIndex:(NSInteger)sectionIndex tapBlock:(void (^)(NSInteger sectionIndex, BOOL isExtend)) tapBlock;

+ (CGFloat)sectionHeaderViewHeight;
+ (NSString *)sectionHeaderViewIdentifier;

@end

