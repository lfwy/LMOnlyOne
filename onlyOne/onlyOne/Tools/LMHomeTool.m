//
//  LMHomeTool.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMHomeTool.h"
#import "LMHttpTool.h"
#import "MJExtension.h"
#import "LMBaseFun.h"

@implementation LMHomeTool

+ (void)requestHomeDataFromSeverByDate:(NSString *)dateString success:(void (^)(LMHomeModal *))success failure:(void (^)(NSError *))failure {
    NSDictionary *params = @{@"strDate" : dateString, @"strRow" : [@1 stringValue]};
    [LMHttpTool GET:URL_GET_HOME_CONTENT parameters:params success:^(id responseObject) {
        if (success) {
            LMHomeModal *homeModal = [[LMHomeModal alloc]init];
            [homeModal mj_setKeyValues:responseObject[@"hpEntity"]];
            success(homeModal);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (NSDictionary *)parametersWithIndex:(NSInteger)index {
    if (index > 9) {
        NSString *date = [LMBaseFun stringDateBeforeTodaySeveralDays:index];
        NSDictionary *parameters = @{@"strDate" : date, @"strRow" : @"1"};
        
        return parameters;
    } else {
        NSString *date = [LMBaseFun stringDateFromCurrent];
        NSDictionary *parameters = @{@"strDate" : date, @"strRow" : [@(++index) stringValue]};
        
        return parameters;
    }
}

+ (void)requestHomeDataFromSeverByIndex:(NSInteger)index success:(void (^)(LMHomeModal *))success failure:(void (^)(NSError *))failure {
    NSDictionary *parameters = [self parametersWithIndex:index];
    [LMHttpTool GET:URL_GET_HOME_CONTENT parameters:parameters success:^(id responseObject) {
        if (success) {
            LMHomeModal *homeModal = [[LMHomeModal alloc]init];
            [homeModal mj_setKeyValues:responseObject[@"hpEntity"]];
            success(homeModal);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
