//
//  UITableView+AZAutoCellHeight.m
//  Mastory_Use
//
//  Created by Andrew on 16/8/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "UITableView+AZAutoCellHeight.h"
#import <objc/runtime.h>

static const void *MemoryCacheAddr = "com.andrew.tableautocellheight";

@implementation UITableView (AZAutoCellHeight)

#if AZ_TB_NEED_IOS8
#else

-(YYMemoryCache *)memoryCache
{
    YYMemoryCache *cache = objc_getAssociatedObject(self, MemoryCacheAddr);
    if (!cache) {
        cache = [YYMemoryCache new];
        cache.name = @"com.andrew.tablecellheight.cache";
        cache.shouldRemoveAllObjectsWhenEnteringBackground=NO;
        cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        objc_setAssociatedObject(self, MemoryCacheAddr, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}

#endif


-(CGFloat)az_cacheCellHeightAtIndexPath:(NSIndexPath *)indexPath   CellClass:(Class)CellClass Identifier:(nullable NSString *)identifier ContentConfiguration:(nullable AZ_AutoCellHeitghtConfiguration)configuration
{

    NSAssert( [CellClass isSubclassOfClass:[UITableViewCell class]], @"CellClass 必须是 UITableViewCell class 的派生类");
    
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [self registerClass:CellClass forCellReuseIdentifier:identifier];
        cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (configuration) {
        configuration(cell);
    }
    
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);
    if (cell.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[cell.accessoryType];
    }
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    [cell.contentView addConstraint:widthFenceConstraint];
    

     CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1.0f;
    [cell.contentView removeConstraint:widthFenceConstraint];
    
    if (cellHeight == 0) {
        // Try '- sizeThatFits:' for frame layout.
        cellHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
    }
    
    [self.memoryCache setObject:@(cellHeight) forKey:[self getRowKeyFromIndexPath:indexPath]];
    
    return cellHeight;
    
}

-(CGFloat)az_heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *key = [self getRowKeyFromIndexPath:indexPath];
    if ([self.memoryCache containsObjectForKey:key]) {
        NSNumber *cellHeightObj = [self.memoryCache objectForKey:key];
        return [cellHeightObj floatValue];
    }else{
        NSLog(@"cell高度返回异常，未在cache中找到缓存，请先确认已经调用 az_cacheCellHeightAtIndexPath： ");
        return 100;
    }

}

-(CGFloat)az_heightForRowAtIndexPath:(NSIndexPath *)indexPath CellClass:(Class)CellClass Identifier:(NSString *)identifier ContentConfiguration:(AZ_AutoCellHeitghtConfiguration)configuration
{    

    NSString *key = [self getRowKeyFromIndexPath:indexPath];
    if ([self.memoryCache containsObjectForKey:key]) {
        NSNumber *cellHeightObj = [self.memoryCache objectForKey:key];
        return [cellHeightObj floatValue];
    }else{
        
        return [self az_cacheCellHeightAtIndexPath:indexPath CellClass:CellClass Identifier:identifier ContentConfiguration:configuration];
    }

}

-(NSString *)getRowKeyFromIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowKey = [NSString stringWithFormat:@"section_%ld.row_%ld",(long)indexPath.section,(long)indexPath.row];
    return rowKey;
}




@end
