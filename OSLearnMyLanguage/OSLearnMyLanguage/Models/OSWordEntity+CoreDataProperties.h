//
//  OSWordEntity+CoreDataProperties.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 9/12/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//
//

#import "OSWordEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OSWordEntity (CoreDataProperties)

+ (NSFetchRequest<OSWordEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *wordContext;
@property (nullable, nonatomic, copy) NSDate *wordCreatingDate;
@property (nullable, nonatomic, copy) NSString *wordExplanation;
@property (nullable, nonatomic, copy) NSString *wordName;
@property (nullable, nonatomic, copy) NSString *wordNameInitial;
@property (nullable, nonatomic, copy) NSString *wordPicture;
@property (nullable, nonatomic, copy) NSString *wordSound;
@property (nullable, nonatomic, copy) NSString *wordTranslation;
@property (nonatomic) int16_t wordScore;
@property (nullable, nonatomic, retain) OSWordArea *area;

@end

NS_ASSUME_NONNULL_END
