//
//  AppDelegate.h
//  TextBarExample
//
//  Created by Ryan Bigger on 8/29/17.
//  Copyright © 2017 Ryan Bigger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

