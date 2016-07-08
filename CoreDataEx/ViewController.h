//
//  ViewController.h
//  CoreDataEx
//
//  Created by VEERA NARAYANA GUTTI on 08/07/15.
//  Copyright (c) 2015 VEERA NARAYANA GUTTI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"  

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextfield;

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)addPersonButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@end
