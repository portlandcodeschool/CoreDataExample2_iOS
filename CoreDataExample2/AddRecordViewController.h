//
//  AddRecordViewController.h
//  CoreDataExample2
//
//  Created by Erick Bennett on 2/16/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRecordViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *hairColor;
@property (weak, nonatomic) IBOutlet UITextField *eyeColor;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLeftArmsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRightArmsLabel;
@property (weak, nonatomic) IBOutlet UIButton *addRecordButton;
@property (weak, nonatomic) IBOutlet UIButton *addLeftArm;
@property (weak, nonatomic) IBOutlet UIButton *addRightArm;
@property (nonatomic, strong) NSMutableArray *rtArms;
@property (nonatomic, strong) NSMutableArray *ltArms;

@end
