//
//  AppDelegate.m
//  AnylineExamples
//
//  Created by Daniel Albertini on 05/02/15.
//  Copyright (c) 2015 9yards GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ALMainPageViewController.h"
#import "UIColor+ALExamplesAdditions.h"
#import "NSUserDefaults+ALExamplesAdditions.h"

#import "CoreDataManager.h"

@interface AppDelegate ()

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[CoreDataManager sharedInstance] setupCoreData];
    if ([NSUserDefaults AL_createEntryOnce:NSStringFromClass([[CoreDataManager sharedInstance] class])]) {
        [[CoreDataManager sharedInstance] resetDemoData];
    }
    
    UINavigationController *masterNavigationController = (UINavigationController *)self.window.rootViewController;
    ALMainPageViewController *controller = (ALMainPageViewController *)masterNavigationController.topViewController;
    controller.managedObjectContext = [CoreDataManager sharedInstance].localContext;
    
    [self.window setTintColor:[UIColor AL_examplesBlue]];

    return YES; 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[CoreDataManager sharedInstance] saveContext];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}
@end

