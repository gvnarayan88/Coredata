//
//  ViewController.m
//  CoreDataEx
//
//  Created by VEERA NARAYANA GUTTI on 08/07/15.
//  Copyright (c) 2015 VEERA NARAYANA GUTTI. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSManagedObjectContext *context;
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self firstnameTextField]setDelegate:self];
    [[self lastnameTextfield]setDelegate:self];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPersonButton:(id)sender {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSManagedObject *newPerson = [[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:context];
    [newPerson setValue:self.firstnameTextField.text forKeyPath:@"Enter First name"];
    [newPerson setValue:self.lastnameTextfield.text forKeyPath:@"Enter last name"];
    
    NSError *error;
    [context save:&error];
    
    self.displayLabel.text = @"Person added";
}

- (IBAction)searchButton:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ or lastname like %@",self.firstnameTextField.text,self.lastnameTextfield.text];
    
    [request setPredicate:predicate];
    NSError *error;
    
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <= 0)
    {
        self.displayLabel.text = @"No personfound";
    }
    else
    {
        NSString *firstname;
        NSString *lastname;
        
        int x = matchingData.count;
        
        for(NSManagedObject *obj in matchingData)
        {
            firstname = [obj valueForKey:@"firstname"];
            lastname = [obj valueForKey:@"lastname"];
        }
    self.displayLabel.text = [NSString stringWithFormat:@"%d firstname %@,lastname %@",x,firstname,lastname];
    }
    
}

- (IBAction)deleteButton:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ or lastname like %@",self.firstnameTextField.text,self.lastnameTextfield.text];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    if(matchingData.count <= 0)
    {
        self.displayLabel.text = @"No person deleted";
    }
    else
    {
        int count =0;
        for(NSManagedObject *obj in matchingData)
        {
            [context deleteObject:obj];
            ++count;
        }
        [context save:&error];
        self.displayLabel.text = [NSString stringWithFormat:@"%d persons deleted",count];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
@end
