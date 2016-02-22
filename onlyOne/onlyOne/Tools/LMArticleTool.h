//
//  LMArticleTool.h
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMArticleModal.h"

@interface LMArticleTool : NSObject

+ (void)requestArticleDataFromSeverByDate:(NSString *)dateString lastUpdateDate:(NSString *)lastUpdateDateString success:(void (^)(LMArticleModal *articleModal))success failure:(void (^)(NSError *error))failure;

@end
