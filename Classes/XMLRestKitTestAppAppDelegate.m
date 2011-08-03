//
//  XMLRestKitTestAppAppDelegate.m
//  XMLRestKitTestApp
//
//  Created by GREGORY GENTLING on 8/3/11.
//  Copyright 2011 7Studios LLC. All rights reserved.
//

#import "XMLRestKitTestAppAppDelegate.h"
#import "RootViewController.h"

//** our xml parser
#import <SSRestKitXMLParser.h>

// RestKit
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Support/JSON/YAJL/YAJL.h>

//** Models
#import "iRepProgramPresetItems.h"
#import "iRepProgramPresets.h"


@implementation XMLRestKitTestAppAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)awakeFromNib {    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Initialize RestKit
	RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://www.7watts.com"];
	
	NSString *seedDatabaseName = nil;
	NSString *databaseName = RKDefaultSeedDatabaseFileName;	
	
	objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:databaseName usingSeedDatabaseName:seedDatabaseName managedObjectModel:nil delegate:self];

	
	//objectManager.acceptMIMEType = RKMIMETypeXML;
	//objectManager.serializationMIMEType = RKMIMETypeXML;
	
	//* User our XML Plugin
	[[RKParserRegistry sharedRegistry] setParserClass:[XMLReaderParser class] forMIMEType:RKMIMETypeXML];

	
	RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    RKManagedObjectSeeder* seeder = [RKManagedObjectSeeder objectSeederWithObjectManager:objectManager];
        
	
	//** Parent Presets
	RKManagedObjectMapping* presetMapping = [RKManagedObjectMapping mappingForClass:[iRepProgramPresets class]];
	presetMapping.primaryKeyAttribute = @"programpresetitemID";
	presetMapping.setNilForMissingRelationships = YES;	
	[presetMapping mapKeyPathsToAttributes:
	 @"ProgramPresetItemId", @"programpresetitemID",
	 @"ProgramCampaignId", @"programcompaignID",
	 @"iRepId", @"userID",
	 @"PresetTitle", @"presettitle",
	 @"Version", @"version",
	 @"ModifiedDate", @"modifieddate",
	 nil];
	
	//** PresetItems...
	RKManagedObjectMapping* presetItemsMapping = [RKManagedObjectMapping mappingForClass:[iRepProgramPresetItems class]];
	presetItemsMapping.primaryKeyAttribute = @"presetID";
	[presetItemsMapping mapKeyPathsToAttributes:
	 @"PresetId", @"presetID",
	 @"ProgramPresetItemId", @"programpresetitemID",
	 @"ProductItemNo", @"productitemno",
	 @"InitialFillQuantity", @"initialfillquantity",
	 nil];

	[objectManager.mappingProvider registerMapping:presetMapping withRootKeyPath:@"Root.ProgramPresets"];
	[presetMapping mapKeyPath:@"ProgramPresetItems" toRelationship:@"presetitems" withMapping:presetItemsMapping];
	
	[objectManager.mappingProvider registerMapping:presetMapping withRootKeyPath:@"ProgramPresets"];
	[objectManager.mappingProvider registerMapping:presetItemsMapping withRootKeyPath:@"ProgramPresetItems"];
	
/*	
	[objectManager.mappingProvider registerMapping:presetMapping withRootKeyPath:@"Root.ProgramPresets"];
	[objectManager.mappingProvider registerMapping:presetItemsMapping withRootKeyPath:@"Root.ProgramPresets.ProgramPresetItems"];
	[presetMapping mapKeyPath:@"ProgramPresetItems" toRelationship:@"Presetitems" withMapping:presetItemsMapping];
	
	[objectManager.mappingProvider registerMapping:presetMapping withRootKeyPath:@"presets"];
	[objectManager.mappingProvider registerMapping:presetItemsMapping withRootKeyPath:@"presetitems"];
*/	
	
	//** presets_single.json, or presets.json
	NSString* file = @"presets.json";
	
	[seeder seedObjectsFromFiles:file, nil];
	
    // Finalize the seeding operation and output a helpful informational message
    [seeder finalizeSeedingAndExit];
	
	

    // Set the navigation controller as the window's root view controller and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
        
    [navigationController release];
    [window release];
    [super dealloc];
}


@end

