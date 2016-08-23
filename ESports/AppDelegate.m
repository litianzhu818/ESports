//
//  AppDelegate.m
//  ESports
//
//  Created by Peter Lee on 16/5/24.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "ESportsTabBarController.h"
#import "LTZLocalizationKit.h"
#import "MatchZoneManager.h"
#import "BaseNavigationController.h"
#import "LoginController.h"
#import "UserConfig.h"

@interface AppDelegate ()

@property (strong, nonatomic) UIViewController *rootViewController;
@property (strong, nonatomic) ESportsTabBarController *tabBarController;
@property (strong, nonatomic) BaseNavigationController *loginNavigationController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerRemoteNotificationWithOptions:launchOptions];
    [[MatchZoneManager sharedInstance] initialize];
    [self setupViewControllers];
    
    return YES;
}

- (void)changedLanguage
{
    NSString *language = nil;
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        language = SYS_LANGUAGE_S_CHINESE;
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]){
        language = SYS_LANGUAGE_T_CHINESE;
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]){
        language = SYS_LANGUAGE_ENGLISH;
    }
    
    [LTZLocalizationManager setLanguage:language];
    
    [self performSelector:@selector(changedLanguage) withObject:nil afterDelay:2.0];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //notification是发送推送时传入的字典信息
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"message"
                                                    message:notification.alertBody
                                                   delegate:nil
                                          cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //用户已经允许接收以下类型的推送
    //UIUserNotificationType allowedTypes = [notificationSettings types];
    
    LOG(@"Register User Notification Settings Success");
}

//按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    
    completionHandler();
}

#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    //send the deviceToken
    NSString* device_token = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    LOG(@"device_token ====>%@",device_token);
    
    [[SystemConfig sharedInstance] SetDeviceToken:device_token];
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    LOG(@"Push Register Error:%@", error.description);
    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    //推送反馈(app运行时)
}

#pragma mark - other methods

- (void)registerPushForIOS8{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

- (void)registerPush
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

//register remote push notification
-(void)registerRemoteNotificationWithOptions:(NSDictionary *)launchOptions
{
    // Register for push notifications
    
    //iOS8注册push方法
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(sysVer < 8){
        [self registerPush];
    }
    else{
        [self registerPushForIOS8];
    }
#else
    //iOS8之前注册push方法
    //注册Push服务，注册后才能收到推送
    [self registerPush];
#endif

    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //清除所有通知(包含本地通知)
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    
    //本地推送示例
    /*
     NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:10];
     
     NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] init];
     [dicUserInfo setValue:@"myid" forKey:@"clockID"];
     NSDictionary *userInfo = dicUserInfo;
     
     [XGPush localNotification:fireDate alertBody:@"测试本地推送" badge:2 alertAction:@"确定" userInfo:userInfo];
     */
}

- (void)setupViewControllers
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = HexColor(0x0e161f);
    
    if ([[UserConfig sharedInstance] GetHasLogin]) {
        [self switchToLoginViewController];
    }else{
        [self switchToTabbarViewController];
    }
    
    [self.window makeKeyAndVisible];
}

- (void)switchToLoginViewController
{
    if (!self.loginNavigationController) {
        LoginController *loginController = [[LoginController alloc] init];
        self.loginNavigationController = [[BaseNavigationController alloc] initWithRootViewController:loginController];
    }
    if ([self.rootViewController isEqual:self.loginNavigationController]) return;
    self.rootViewController = self.loginNavigationController;
    [self.window setRootViewController:self.loginNavigationController];
}
- (void)switchToTabbarViewController
{
    if (!self.tabBarController) {
        self.tabBarController = [[ESportsTabBarController alloc] init];
    }
    
    if ([self.rootViewController isEqual:self.tabBarController]) return;
    
    self.rootViewController = self.tabBarController;
    [self.window setRootViewController:self.tabBarController];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.afusion.ESports" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ESports" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ESports.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
