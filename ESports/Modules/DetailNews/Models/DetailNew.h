//
//  DetailNew.h
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol HotNew
@end

@protocol RelNew
@end

@class HotNew;
@class RelNew;

@interface DetailNew : JSONModel

@property (strong, nonatomic) NSString *newsId;
@property (strong, nonatomic) NSString *newsTitle;
@property (strong, nonatomic) NSString *newsArea;

@property (strong, nonatomic) NSString *newsFrom;
//@property (strong, nonatomic) NSDate *newsTime;
@property (strong, nonatomic) NSDate *newsDate;
@property (strong, nonatomic) NSString *newsDateString;
@property (strong, nonatomic) NSString *newsContent;

@property (strong, nonatomic) NSArray<HotNew> *hotNews;
@property (strong, nonatomic) NSArray<RelNew> *relNews;

- (NSString *)dateString;

@end

@interface HotNew : JSONModel

@property (strong, nonatomic) NSString *hotNewId;
@property (strong, nonatomic) NSString *hotNewTitle;
@property (strong, nonatomic) NSString *hotNewImageUrl;

@end

@interface RelNew : JSONModel

@property (strong, nonatomic) NSString *relNewId;
@property (strong, nonatomic) NSString *relNewTitle;

@end
