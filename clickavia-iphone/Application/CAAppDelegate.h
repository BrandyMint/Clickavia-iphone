//
//  CAAppDelegate.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 29.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CASearchFormControls/CAFlightPassengersCount.h>
#import <CAManagers/OfferConditions.h>
#import <AKTabBarController/AKTabBarController.h>
#import "SpecialOffer.h"
#import "Offer.h"
@interface CAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) SpecialOffer* specialOffer;
@property (strong, nonatomic) Offer* offer;
@property (strong,nonatomic) OfferConditions *offerConditions; //для проброса данных из календаря в графики
@property (strong,nonatomic) CAFlightPassengersCount *passengersCount; //проброс пассажиров, их количества и типов
@property (nonatomic, strong) AKTabBarController *rootTabBarController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
