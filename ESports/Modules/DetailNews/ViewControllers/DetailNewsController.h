//
//  DetailNewsController.h
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailNewsController : BaseViewController

@property (strong, nonatomic) NSString *newsId;

- (instancetype)initWithNewsId:(NSString *)newsId;

@end
