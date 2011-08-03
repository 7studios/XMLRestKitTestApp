//
//  iRepProgramPresets.h
//  XMLRestKitTestApp
//
//  Created by GREGORY GENTLING on 8/3/11.
//  Copyright 2011 7Studios LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@class iRepProgramPresetItems;

@interface iRepProgramPresets :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSNumber * programcompaignID;
@property (nonatomic, retain) NSString * presettitle;
@property (nonatomic, retain) NSDate * modifieddate;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * programpresetitemID;
@property (nonatomic, retain) NSSet* Presetitems;

@end


