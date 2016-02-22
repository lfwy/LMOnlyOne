//
//  LMThingTool.h
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMThingModal.h"

@interface LMThingTool : NSObject

+ (void)requestThingDataFromSeverByDate:(NSString *)dateString success:(void (^)(LMThingModal *thingModal))success failure:(void (^)(NSError *error))failure;

+ (void)requestThingDataFromSeverByIndex:(NSInteger)index success:(void (^)(LMThingModal *thingModal))success failure:(void (^)(NSError *error))failure;

@end
