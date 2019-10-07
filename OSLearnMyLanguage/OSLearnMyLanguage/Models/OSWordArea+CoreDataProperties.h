//
//  OSWordArea+CoreDataProperties.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/28/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//
//

#import "OSWordArea+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OSWordArea (CoreDataProperties)

+ (NSFetchRequest<OSWordArea *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *areaName;
@property (nullable, nonatomic, retain) NSSet<OSWordEntity *> *words;

@end

@interface OSWordArea (CoreDataGeneratedAccessors)

- (void)addWordsObject:(OSWordEntity *)value;
- (void)removeWordsObject:(OSWordEntity *)value;
- (void)addWords:(NSSet<OSWordEntity *> *)values;
- (void)removeWords:(NSSet<OSWordEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
