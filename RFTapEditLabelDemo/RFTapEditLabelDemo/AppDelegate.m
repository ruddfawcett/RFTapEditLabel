//
//  AppDelegate.m
//  RFTapEditLabelDemo
//
//  Created by Rudd Fawcett on 11/26/13.
//  Copyright (c) 2013 Rudd Fawcett. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DemoTableViewController *tableController = [[DemoTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tableController.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableController.title = @"RFTapEditLabel/Cell";
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tableController];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
