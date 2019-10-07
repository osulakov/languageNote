//
//  OSWordEntity+CoreDataProperties.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 9/12/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//
//

#import "OSWordEntity+CoreDataProperties.h"

@implementation OSWordEntity (CoreDataProperties)

+ (NSFetchRequest<OSWordEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"OSWordEntity"];
}

@dynamic wordContext;
@dynamic wordCreatingDate;
@dynamic wordExplanation;
@dynamic wordName;
@dynamic wordNameInitial;
@dynamic wordPicture;
@dynamic wordSound;
@dynamic wordTranslation;
@dynamic wordScore;
@dynamic area;

@end
