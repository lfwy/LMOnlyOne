//
//  LMThingModal.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMThingModal.h"

@implementation LMThingModal

- (NSString *)description {
    return [NSString stringWithFormat:@"strLastUpdateDate = %@, strPn = %@, strBu = %@, strTm = %@, strWu = %@, strId = %@, strTt = %@, strTc = %@.", self.strLastUpdateDate, self.strPn, self.strBu, self.strTm, self.strWu, self.strId, self.strTt, self.strTc];
}

@end
