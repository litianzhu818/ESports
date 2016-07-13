//
//  HotWordNew.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HotWordNew : JSONModel
/*
Id:2,
Title: Team Dragon Knight,
ImgSrc: http://content/images /News Images 7/stix1.jpg,
Date: 2016/4/23 16:00:00 +00:00
 */
@property (strong, nonatomic) NSString *newsId;
@property (strong, nonatomic) NSString *newsTitle;
@property (strong, nonatomic) NSString *newsImageUrl;
@property (strong, nonatomic) NSDate *newsDate;

- (NSString *)newsDateString;


@end
