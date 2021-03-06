//
//  HotFocus.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HotFocusNew : JSONModel

@property (strong, nonatomic) NSString *newsId;
@property (strong, nonatomic) NSString *newsTitle;
@property (strong, nonatomic) NSString *newsImageUrl;
@property (strong, nonatomic) NSString *newsArea;
@property (strong, nonatomic) NSDate *newsDate;
@property (strong, nonatomic) NSString *stringDate;

- (NSString *)newsDateString;

@end
