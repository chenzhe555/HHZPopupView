//
//  HHZOrderedDictionary.m
//  HHZBaseClass
//
//  Created by 陈哲是个好孩子 on 2017/8/3.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "HHZOrderedDictionary.h"

@interface HHZOrderedDictionary ()
@property (nonatomic, strong) NSMutableDictionary * realDic;
@property (nonatomic, strong) NSMutableArray * realArr;
@end

@implementation HHZOrderedDictionary
-(instancetype)initWithCapacity:(NSUInteger)numItems
{
    if (self = [super init])
    {
        _realDic = [[NSMutableDictionary alloc] initWithCapacity:numItems];
        _realArr = [[NSMutableArray alloc] initWithCapacity:numItems];
    }
    return self;
}

-(instancetype)init
{
    if (self = [super init])
    {
        _realDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        _realArr = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (![_realDic objectForKey:aKey])
    {
        [_realArr addObject:aKey];
    }
    [_realDic setObject:anObject forKey:aKey];
}

-(void)removeObjectForKey:(id)aKey
{
    [_realDic removeObjectForKey:aKey];
    [_realArr removeObject:aKey];
}

-(void)removeAllObjects
{
    _realDic = [NSMutableDictionary dictionary];
    _realArr = [NSMutableArray array];
}

-(NSArray *)allKeys
{
    return _realArr.copy;
}

-(id)objectForKey:(id)aKey
{
    return _realDic[aKey];
}

-(NSEnumerator *)keyEnumerator
{
    return [_realArr objectEnumerator];
}

@end
