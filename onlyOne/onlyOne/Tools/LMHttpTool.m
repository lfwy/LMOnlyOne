//
//  LMHttpTool.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMHttpTool.h"
#import "AFNetworking.h"

@implementation LMHttpTool
static AFHTTPSessionManager *manager;
//创建manager单例
+ (AFHTTPSessionManager *)initAFHttpManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        manager.operationQueue.maxConcurrentOperationCount = 1;
    });
    return manager;
}
//获取首页数据
+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    manager = [self initAFHttpManager];
    [manager GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
