//
//  UITableView+AZAutoCellHeight.h
//  Mastory_Use
//
//  Created by Andrew on 16/8/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYMemoryCache.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^AZ_AutoCellHeitghtConfiguration)(_Nullable id cell);

@interface UITableView (AZAutoCellHeight)

@property (nonatomic,strong,readonly)YYMemoryCache *memoryCache;

-(CGFloat)az_cacheCellHeightAtIndexPath:(NSIndexPath *)indexPath CellClass:(Class)CellClass Identifier:(nullable NSString *)identifier ContentConfiguration:(nullable AZ_AutoCellHeitghtConfiguration)configuration;

-(CGFloat)az_heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)az_heightForRowAtIndexPath:(NSIndexPath *)indexPath CellClass:(Class)CellClass Identifier:(nullable NSString *)identifier ContentConfiguration:(nullable AZ_AutoCellHeitghtConfiguration)configuration;

-(void)removeAllMemoryCache;

-(void)removeMemoryCacheIndex:(NSIndexPath *)index;


@end
NS_ASSUME_NONNULL_END