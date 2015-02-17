//
//  Person.h
//  CoreDataExample2
//
//  Created by Erick Bennett on 2/17/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LeftArm, RightArm;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * eyeColor;
@property (nonatomic, retain) NSString * hairColor;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * shoeSIze;
@property (nonatomic, retain) NSSet *leftArms;
@property (nonatomic, retain) NSSet *rightArms;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addLeftArmsObject:(LeftArm *)value;
- (void)removeLeftArmsObject:(LeftArm *)value;
- (void)addLeftArms:(NSSet *)values;
- (void)removeLeftArms:(NSSet *)values;

- (void)addRightArmsObject:(RightArm *)value;
- (void)removeRightArmsObject:(RightArm *)value;
- (void)addRightArms:(NSSet *)values;
- (void)removeRightArms:(NSSet *)values;

@end
