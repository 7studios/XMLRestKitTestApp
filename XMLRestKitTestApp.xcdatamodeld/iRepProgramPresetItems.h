//
//  iRepProgramPresetItems.h
//  XMLRestKitTestApp
//
//  Created by GREGORY GENTLING on 8/3/11.
//  Copyright 2011 7Studios LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@class iRepProgramPresets;

@interface iRepProgramPresetItems :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * productitemno;
@property (nonatomic, retain) NSNumber * initialfillquantity;
@property (nonatomic, retain) NSNumber * presetID;
@property (nonatomic, retain) NSString * programpresetitemID;
@property (nonatomic, retain) iRepProgramPresets * Presets;

@end



