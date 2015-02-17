//
//  ShowRecordsViewController.h
//  CoreDataExample2
//
//  Created by Erick Bennett on 2/16/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowRecordsViewController : UIViewController <UITabBarControllerDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *allPersons;

@end
