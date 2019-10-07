//
//  OSWordArea+CoreDataProperties.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/28/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//
//

#import "OSWordArea+CoreDataProperties.h"

@implementation OSWordArea (CoreDataProperties)

+ (NSFetchRequest<OSWordArea *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"OSWordArea"];
}

@dynamic areaName;
@dynamic words;

@end
