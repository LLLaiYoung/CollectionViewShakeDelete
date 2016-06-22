//
//  CategoryCell.h
//  CollectionViewShakeDelete
//
//  Created by chairman on 16/6/22.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryCell;
@protocol CategoryCellDelegate <NSObject>
@required
@optional
/** 长按事件 */
- (void)categoryCell:(CategoryCell *)cell didClickedLongPress:(UILongPressGestureRecognizer *)longPress;
/** 删除事件 */
- (void)didClickedDeleteBtnCategoryCell:(CategoryCell *)cell;
@end
@interface CategoryCell : UICollectionViewCell
@property (nonatomic, weak) id<CategoryCellDelegate> categoryCellDelegate;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
