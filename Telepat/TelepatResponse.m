//
//  TelepatResponse.m
//  Kraken
//
//  Created by Ovidiu on 29/06/15.
//  Copyright (c) 2015 Appscend. All rights reserved.
//

#import "TelepatResponse.h"

@interface TelepatResponseModel : JSONModel
@property (nonatomic) NSInteger status;
@property (nonatomic, strong) id<Optional, NSObject> content;
@property (nonatomic, strong) NSString<Optional> *message;
@property (nonatomic, strong) NSError<Ignore> *error;
@end

@implementation TelepatResponseModel

@end

@implementation TelepatResponse

- (id) initWithResponse:(KRResponse *)response {
    if (self = [super init]) {
        if (response.error) {
            self.error = response.error;
            self.status = response.status;
            self.message = response.dict[@"message"];
            return self;
        }
        NSError *err;
        TelepatResponseModel *responseModel = [[TelepatResponseModel alloc] initWithDictionary:response.dict error:&err];
        if (err) {
            self.error = err;
            return self;
        } else {
            self.status = responseModel.status;
            self.content = responseModel.content;
            self.message = responseModel.message;
        }
    }
    
    return self;
}

- (BOOL) isError {
    return self.error != nil;
}

- (id) getObjectOfType:(Class)classType {
    NSError *err;
    id obj;
    if ([self.content isKindOfClass:[NSDictionary class]]) {
        obj = [[classType alloc] initWithDictionary:(NSDictionary*)self.content error:&err];
        if (err) {
            self.error = err;
        }
    } else if ([self.content isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in (NSArray *)self.content) {
            obj = [[classType alloc] initWithDictionary:dict error:&err];
            if (err) @throw([NSException exceptionWithName:@"InvalidJSONData" reason:@"Invalid JSON data. Required JSON keys are missing from the input. Check the error user information." userInfo:@{@"error": err}]);
            [array addObject:obj];
        }
        obj = array;
    }
    return obj;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"<TelepatResponse: %p>\nstatus: %ld\ncontent: %@", self, (long)self.status, self.content ? self.content : self.message];
}

@end
