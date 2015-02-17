//
//  RightArm.h
//  CoreDataExample2
//
//  Created by Erick Bennett on 2/17/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface RightArm : NSManagedObject

@property (nonatomic, retain) Person *person;

@end
