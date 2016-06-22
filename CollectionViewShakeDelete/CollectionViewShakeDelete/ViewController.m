//
//  ViewController.m
//  CollectionViewShakeDelete
//
//  Created by chairman on 16/6/22.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "ViewController.h"
#import "Masonry.h"
#import "Category.h"
#import "CategoryCell.h"

static NSString *const cellID = @"categoryCell";

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
CategoryCellDelegate
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *categorys;
@property (nonatomic, assign) BOOL edit;
@end

@implementation ViewController

#pragma mark - lazy loading
- (NSMutableArray *)categorys
{
    if (!_categorys) {
        _categorys = [NSMutableArray new];
        _categorys = [[Category categorysList] mutableCopy];
    }
    return _categorys;
}


#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(97/2.5, 97/2.5);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:cellID];
    
    UIButton *stopEditBtn = [UIButton new];
    [self.view addSubview:stopEditBtn];
    [stopEditBtn setImage:[UIImage imageNamed:@"type_big_1002"] forState:UIControlStateNormal];
    [stopEditBtn addTarget:self action:@selector(clickedStopEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [stopEditBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categorys.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.categoryCellDelegate = self;
    cell.deleteBtn.hidden = YES;
    cell.indexPath = indexPath;
    CategoryCell *category = self.categorys[indexPath.row];
    cell.image = category.image;
    if (self.edit) {
        cell.deleteBtn.hidden = NO;
        /**
         *  动画的时候btn是不能接受响应事件的,如需接受响应事件,则需要设置动画的options为UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionAutoreverse
         */
        [UIView animateWithDuration:0.1 delay:0 options:0 animations:^{
            cell.transform=CGAffineTransformMakeRotation(-0.05);
        } completion:^(BOOL finished) {
           [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
               cell.transform=CGAffineTransformMakeRotation(0.05);
           } completion:nil];
        }];
    } else {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^ {
            cell.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Category *category = self.categorys[indexPath.row];
    NSLog(@"%@",category.categoryImageFileName);
}
#pragma mark - CategoryCellDelegate
- (void)categoryCell:(CategoryCell *)cell didClickedLongPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        self.edit = YES;
        [self.collectionView reloadData];
    }
}
- (void)didClickedDeleteBtnCategoryCell:(CategoryCell *)cell {
    NSIndexPath *indexPath = cell.indexPath;
    [self.categorys removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}
#pragma mark - action
- (void)clickedStopEditBtn:(UIButton *)sender {
    self.edit = !self.edit;
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
