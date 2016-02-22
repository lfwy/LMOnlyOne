//
//  LMHomeTool.h
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMHomeModal.h"

@interface LMHomeTool : NSObject

+ (void)requestHomeDataFromSeverByDate:(NSString *)dateString success:(void (^)(LMHomeModal *homeModal))success failure:(void (^)(NSError *error))failure;

/**
 *  获取首页数据
 *
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */

+ (void)requestHomeDataFromSeverByIndex:(NSInteger)index success:(void (^)(LMHomeModal *homeModal))success failure:(void (^)(NSError *error))failure;

@end
