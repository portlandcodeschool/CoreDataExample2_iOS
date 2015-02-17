//
//  ViewController.m
//  CoreDataExample2
//
//  Created by Erick Bennett on 2/16/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ShowRecordsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Sandbox = %@", NSHomeDirectory());

}
- (IBAction)viewAllRecords:(id)sender {
    
    NSArray *allPersons = [self fetchAllData];
    
    if (allPersons.count == 0) {
        UIAlertController *uac = [UIAlertController alertControllerWithTitle:@"No records!" message:@"Sorry, there are no records to show" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        
        [uac addAction:okAction];
        
        [self presentViewController:uac animated:YES completion:nil];
        
    } else {
        
        [self performSegueWithIdentifier:@"showRecords" sender:allPersons];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showRecords"]){
        
        ShowRecordsViewController *showRecordsVC = segue.destinationViewController;
        showRecordsVC.allPersons = (NSArray *)sender;
    }
}

-(NSArray *) fetchAllData {
    
    //Grab a reference to our appdelegate since that is where all the core data methods are.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //Get the managed object context from our appdelegate
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    
    //Create a NSEntityDescription that points to the entity in Core Data we want to search through
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Person" inManagedObjectContext:context];
    
    
    //Create a fetch request that will get data from the entity listed in the NSEntityDescription above.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    
    //Set the entity for the request
    [request setEntity:entityDescription];
    
    //Using this makes sure we get the full object(s) returned rather than a pointer to object(s) that will become a full object when we access its properties.
    request.returnsObjectsAsFaults = NO;
    
    NSError *error = nil;
    //Execute the fetch request. It will return an Array of objects
    NSArray *all = [context executeFetchRequest:request error:&error];
    
    return all;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
