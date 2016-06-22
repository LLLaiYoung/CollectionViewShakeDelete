//
//  Category.m
//  CollectionViewShakeDelete
//
//  Created by chairman on 16/6/22.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "Category.h"

@implementation Category
#pragma mark - read plist

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)categoryWithDic:(NSDictionary *)dic {
    return  [[self alloc]initWithDic:dic];
}
+ (NSArray *)categorysList {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"addCategory" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSDictionary *dic in dicArray) {
        Category *category = [Category categoryWithDic:dic];
        [tempArray addObject:category];
    }
    return tempArray;
}
#pragma mark - getter
- (UIImage *)image {
    return [UIImage imageNamed:self.categoryImageFileName];
}

@end
