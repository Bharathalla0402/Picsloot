//
//  UserInformation.m
//  Jaguar Enterprises
//
//  Created by Mac on 10/02/16.
//  Copyright (c) 2016 bharat. All rights reserved.
//

#import "UserInformation.h"

static UserInformation *sharedController;

@implementation UserInformation


+ (UserInformation *)sharedController
{
    if (sharedController == nil)
    {
        sharedController = [[self alloc] init];
    }
    return sharedController;
}
- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_PicsArray forKey:@"Images2"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    _PicsArray = [aDecoder decodeObjectForKey:@"Images2"];
    
    return self;
    
}
-(void)updateuserinfo:(NSMutableArray *)Array
{
    _PicsArray=Array;
    
}

@end
