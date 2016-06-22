//
//  CategoryCell.m
//  CollectionViewShakeDelete
//
//  Created by chairman on 16/6/22.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "CategoryCell.h"
#import "Masonry.h"
@interface CategoryCell()
@property (nonatomic, strong) UIImageView *imageView;

@end
@implementation CategoryCell

#pragma mark - system Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [UIImageView new];
        [self.contentView addSubview:self.imageView];
        [self.imageView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        //* 删除按钮 */
        self.deleteBtn = [UIButton new];
        [self.deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(clickedDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteBtn];
        [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(30, 30));
            make.centerY.equalTo(self.contentView.top).offset(3);
            make.centerX.equalTo(self.contentView.left).offset(6);
        }];
        
        //* 长按手势 */
        UILongPressGestureRecognizer *longGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGR:)];
        longGR.minimumPressDuration = 1.0;
        longGR.allowableMovement = 10;
        [self addGestureRecognizer:longGR];
    }
    return self;
}
#pragma mark - setter
- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

#pragma mark - action
- (void)longGR:(UILongPressGestureRecognizer *)sender {
    if (self.categoryCellDelegate && [self.categoryCellDelegate respondsToSelector:@selector(categoryCell:didClickedLongPress:)]) {
        [self.categoryCellDelegate categoryCell:self didClickedLongPress:sender];
    }
}
- (void)clickedDeleteBtn:(UIButton *)sender {
    NSLog(@"clickedDeleteBtn");
    if (self.categoryCellDelegate && [self.categoryCellDelegate respondsToSelector:@selector(didClickedDeleteBtnCategoryCell:)]) {
        [self.categoryCellDelegate didClickedDeleteBtnCategoryCell:self];
    }
}

@end
