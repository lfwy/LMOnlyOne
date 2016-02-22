//
//  LMQuestionTool.h
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMQuestionModal.h"

@interface LMQuestionTool : NSObject

+ (void)requestQuestionDataFromSeverByDate:(NSString *)dateString lastUpdateDate:(NSString *)lastUpdateDateString success:(void (^)(LMQuestionModal *questionModal))success failure:(void (^)(NSError *error))failure;

@end
