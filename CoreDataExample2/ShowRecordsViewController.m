//
//  ShowRecordsViewController.m
//  CoreDataExample2
//
//  Created by Erick Bennett on 2/16/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import "ShowRecordsViewController.h"
#import "Person.h"
#import "AppDelegate.h"

@interface ShowRecordsViewController ()

@end

@implementation ShowRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark
#pragma TableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //returns the number of sections you need.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //how many rows are in each of the above sections (Total number of cells needing to be displayed).
    return self.allPersons.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //This sets the size of the cell at any given index.
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //The actual code to return each cell, configured with the data you want to display.
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    
    Person *person = [self.allPersons objectAtIndex:indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ hair, %@ eyes, %i left arms and %i right arms", person.hairColor, person.eyeColor, person.leftArms.count, person.rightArms.count];
    
    // Configure the cell.
    
    return cell;
    
}

#pragma -mark
#pragma TableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //This delegate method gets call when a user taps a TableView cell. This method sends the index of the tapped cell in the indexpath argument.
    
    //Show an animated deselection of the selected cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        //Grab a reference to our appdelegate since that is where all the core data methods are.
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        
        //Get the managed object context from our appdelegate
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        
        //Get the object from the array
        Person *person = [self.allPersons objectAtIndex:indexPath.row];

        //Delete this object from Core Data
        [context deleteObject:person];
        
        //We need to save the context in order to update our persistant store
        
        NSError *error = nil;

        if (![appDelegate.managedObjectContext save:&error]) {
            NSLog(@"Error saving MOC: %@", [error localizedDescription]);
        } else {

            
            //In order to remove an object from our NSArray, we are assigning it to a NSMutableArray, removing the object, then reassigning back to the main array
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.allPersons];
            
           //remove the object here
            [array removeObjectAtIndex:indexPath.row];

            //Reassign the updated array back to our main array used in the tableview
            self.allPersons = array;
            
            // Delete the row from the data source and reloads the table with an animation
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    } 
}
@end
