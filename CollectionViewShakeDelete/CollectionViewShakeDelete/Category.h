//
//  Category.h
//  CollectionViewShakeDelete
//
//  Created by chairman on 16/6/22.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Category : NSObject
@property (nonatomic, strong) NSString *categoryImageFileName;
@property (nonatomic, strong) NSNumber *isIncome; // ignore
@property (nonatomic, readonly) UIImage *image;
+ (NSArray *)categorysList;
@end
