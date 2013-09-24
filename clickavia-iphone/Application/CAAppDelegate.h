//
//  CAAppDelegate.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 29.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AKTabBarController/AKTabBarController.h>
#import <CAManagers/OfferConditions.h>
@interface CAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) OfferConditions *offerConditions;
@property (nonatomic, strong) AKTabBarController *rootTabBarController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
