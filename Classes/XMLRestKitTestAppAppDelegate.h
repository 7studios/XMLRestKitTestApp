//
//  XMLRestKitTestAppAppDelegate.h
//  XMLRestKitTestApp
//
//  Created by GREGORY GENTLING on 8/3/11.
//  Copyright 2011 7Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface XMLRestKitTestAppAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


- (NSURL *)applicationDocumentsDirectory;


@end

