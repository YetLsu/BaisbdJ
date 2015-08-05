//
//  XMGAddTagToolbar.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/8/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGAddTagToolbar.h"
#import "XMGAddTagViewController.h"

@interface XMGAddTagToolbar()
/** 顶部控件 */
@property (weak, nonatomic) IBOutlet UIView *topView;
@end

@implementation XMGAddTagToolbar

- (void)awakeFromNib
{
    // 添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
//    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = XMGTopicCellMargin;
    [self.topView addSubview:addButton];
}

- (void)addButtonClick
{
    XMGAddTagViewController *vc = [[XMGAddTagViewController alloc] init];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
    
    // a modal 出 b
//    [a presentViewController:b animated:YES completion:nil];
//    a.presentedViewController -> b
//    b.presentingViewController -> a
}

@end
