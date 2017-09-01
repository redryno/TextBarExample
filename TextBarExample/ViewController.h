//
//  ViewController.h
//  TextBarExample
//
//  Created by Ryan Bigger on 8/29/17.
//  Copyright © 2017 Ryan Bigger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TextBarExample+CoreDataModel.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

