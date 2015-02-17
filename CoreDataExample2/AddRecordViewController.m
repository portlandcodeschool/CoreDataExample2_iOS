//
//  AddRecordViewController.m
//  CoreDataExample2
//
//  Created by Erick Bennett on 2/16/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import "AddRecordViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "SVProgressHUD.h"
#import "LeftArm.h"
#import "RightArm.h"

@interface AddRecordViewController ()

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ltArms = [NSMutableArray array];
    
    self.rtArms = [NSMutableArray array];
    
    [self clearAll];
}

- (void) clearAll {
    self.addLeftArm.enabled = FALSE;
    self.addRightArm.enabled = FALSE;
    self.addRecordButton.enabled = FALSE;
    
    self.name.text = @"";
    self.hairColor.text = @"";
    self.eyeColor.text = @"";
    
    [self.rtArms removeAllObjects];
    [self.ltArms removeAllObjects];
    
    self.numberOfRightArmsLabel.text = [NSString stringWithFormat:@"%i Rt. arm(s)", self.rtArms.count];
    
    self.numberOfLeftArmsLabel.text = [NSString stringWithFormat:@"%i Lt. arm(s)", self.ltArms.count];
    
    
}

- (IBAction)addLeftArm:(id)sender {

    //Grab a reference to our appdelegate since that is where all the core data methods are.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //Get the managed object context from our appdelegate
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    //Create a new Human object in Core Data using the entity name. This is the entity we created in our core data model file (CoreDataExample.xcdatamodeld)
    LeftArm *arm = [NSEntityDescription insertNewObjectForEntityForName:@"LeftArm"inManagedObjectContext:context];
    
    [self.ltArms addObject:arm];
    
    
    self.numberOfLeftArmsLabel.text = [NSString stringWithFormat:@"%i Lt. arm(s)", self.ltArms.count];
    
}

- (IBAction)addRightArm:(id)sender {
    
    //Grab a reference to our appdelegate since that is where all the core data methods are.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //Get the managed object context from our appdelegate
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    //Create a new Human object in Core Data using the entity name. This is the entity we created in our core data model file (CoreDataExample.xcdatamodeld)
    RightArm *arm = [NSEntityDescription insertNewObjectForEntityForName:@"RightArm"inManagedObjectContext:context];
    
    [self.rtArms addObject:arm];

    
    self.numberOfRightArmsLabel.text = [NSString stringWithFormat:@"%i Rt. arm(s)", self.rtArms.count];

}

- (IBAction)addRecord:(id)sender {
    
    //Grab a reference to our appdelegate since that is where all the core data methods are.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //Get the managed object context from our appdelegate
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    //Create a new Human object in Core Data using the entity name. This is the entity we created in our core data model file (CoreDataExample.xcdatamodeld)
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"inManagedObjectContext:context];
    
    //make some changes to our new Human object
    person.name = self.name.text;
    person.hairColor = self.hairColor.text;
    person.eyeColor = self.eyeColor.text;
    person.age = @(28);
    
    
    
    if (self.ltArms.count > 0) {
        
        [person addLeftArms:[NSSet setWithArray:self.ltArms]];
    }
    
    if (self.rtArms.count > 0) {
        
        [person addRightArms:[NSSet setWithArray:self.rtArms]];
    }
    
    //Create an NSError for use when we are trying to save this new object
    NSError *error = nil;
    
    //Use the 'save' method in our managedObjectContext instance. This method returns a BOOL specifying wether the operation was succesfull or not.
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Error saving MOC: %@", [error localizedDescription]);
    } else {
        [SVProgressHUD showSuccessWithStatus:@"Saved!"];
        [self clearAll];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.name) {
        [textField resignFirstResponder];
        [self.hairColor becomeFirstResponder];
    }
    else if (textField == self.hairColor) {
        [textField resignFirstResponder];
        [self.eyeColor becomeFirstResponder];
    }
    else if (textField == self.eyeColor) {
        if (self.name.text.length > 0) {
            self.addLeftArm.enabled = TRUE;
            self.addRightArm.enabled = TRUE;
            self.addRecordButton.enabled = TRUE;
        }
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
