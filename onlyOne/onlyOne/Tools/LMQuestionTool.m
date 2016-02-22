//
//  LMQuestionTool.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMQuestionTool.h"
#import "LMHttpTool.h"
#import "MJExtension.h"

@implementation LMQuestionTool

+ (void)requestQuestionDataFromSeverByDate:(NSString *)dateString lastUpdateDate:(NSString *)lastUpdateDateString success:(void (^)(LMQuestionModal *))success failure:(void (^)(NSError *))failure {
    
    NSDictionary *parameters = @{@"strDate" : dateString, @"strLastUpdateDate" : lastUpdateDateString};
    [LMHttpTool GET:URL_GET_QUESTION_CONTENT parameters:parameters success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if (success) {
            LMQuestionModal *questionModal = [[LMQuestionModal alloc]init];
            [questionModal mj_setKeyValues:responseObject[@"questionAdEntity"]];
            success(questionModal);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
