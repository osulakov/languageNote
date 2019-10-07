//
//  OSTestViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/31/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSTestViewController.h"
#import "OSColorsAndAttributes.h"
#import "OSDataManager.h"
#import "OSWordEntity+CoreDataClass.h"
#import "OSSmallCardView.h"

@interface OSTestViewController ()

@property (assign, nonatomic) UIViewAutoresizing mask;

@property (strong, nonatomic) NSArray* viewsArray;

@property (weak, nonatomic) UIView* selectedView;
@property (assign, nonatomic) NSInteger selectedViewTag;
@property (weak, nonatomic) UIView* testCardView;
@property (strong, nonatomic) OSWordEntity* selectedWord;

@property (strong, nonatomic) NSMutableArray* answerButtonsArray;
@property (strong, nonatomic) NSString* selectedAnswer;

@end

@implementation OSTestViewController

@synthesize fetchedResultsController = _fetchedResultsController;

static NSString* fakeAnswers[] = {
    
    @"Computer", @"Disk", @"Health", @"Screen", @"Screem",
    @"Human", @"Automobile", @"Truck", @"Yang", @"Youth",
    @"Button", @"Light", @"Decision", @"Feeling", @"Long",
    @"Dress", @"To go", @"Find", @"Woman", @"Children",
    @"Gas", @"Ride", @"Motor", @"Bicycle", @"Magnet",
    @"Muscle", @"Fire", @"Box", @"To have", @"To dream",
    @"Must have", @"Answer", @"Face", @"Arm", @"Programm",
    @"Memory", @"Cloud", @"Apple", @"Tomato", @"School",
    @"Holyday", @"Horn", @"Mountain", @"To blow", @"Liberty",
    @"Spine", @"So far", @"State", @"Language", @"Rock"
};

static int fakeAnswersCount = 50;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.viewsArray = [NSMutableArray array];
    self.selectedViewTag = 0;
    self.selectedView = nil;
    self.testCardView = nil;
    self.selectedWord = nil;
   
    [self wordList];
    
    self.viewsArray = [self createTestCards];
    
    for (UIView * view in self.viewsArray) {
        [self.view addSubview:view];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
}

- (NSManagedObjectContext*)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[OSDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - Privat methods

- (NSArray*)createTestCards {
    
    NSInteger wordsCount = [self.fetchedResultsController.fetchedObjects count];
    
    NSInteger offset = self.view.bounds.size.width / 15;
    
    CGPoint testCardViewCenter1 = CGPointMake(self.view.bounds.size.width / 4,
                                              self.view.bounds.size.height / 4);
    CGPoint testCardViewCenter2 = CGPointMake((self.view.bounds.size.width / 4) * 3,
                                              self.view.bounds.size.height / 4);
    CGPoint testCardViewCenter3 = CGPointMake(self.view.bounds.size.width / 4,
                                              self.view.bounds.size.height / 4 +
                                              self.view.bounds.size.width / 3 + offset);
    CGPoint testCardViewCenter4 = CGPointMake((self.view.bounds.size.width / 4) * 3,
                                              self.view.bounds.size.height / 4 +
                                              self.view.bounds.size.width / 3 + offset);
    CGPoint testCardViewCenter5 = CGPointMake(self.view.bounds.size.width / 4,
                                              self.view.bounds.size.height / 4 +
                                               (self.view.bounds.size.width / 3) * 2 + offset * 2);
    CGPoint testCardViewCenter6 = CGPointMake((self.view.bounds.size.width / 4) * 3,
                                              self.view.bounds.size.height / 4 +
                                               (self.view.bounds.size.width / 3) * 2 + offset * 2);
    
    NSArray* centersArray = [NSArray arrayWithObjects:
                             [NSValue valueWithCGPoint:testCardViewCenter1],
                             [NSValue valueWithCGPoint:testCardViewCenter2],
                             [NSValue valueWithCGPoint:testCardViewCenter3],
                             [NSValue valueWithCGPoint:testCardViewCenter4],
                             [NSValue valueWithCGPoint:testCardViewCenter5],
                             [NSValue valueWithCGPoint:testCardViewCenter6], nil];
    
    //creating test card views
    
    NSInteger realWordCount = 0;
    if (wordsCount > 6) {
        realWordCount = 6;
    } else {
        realWordCount = wordsCount;
    }
    
    CGRect testCardViewRect =
    CGRectMake(0, 0, (self.view.bounds.size.width / 2) - (offset + offset / 2), self.view.bounds.size.width / 3);
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = 0; i < realWordCount; i++) {
        
        OSWordEntity* word = [self.fetchedResultsController.fetchedObjects objectAtIndex:i];

        OSSmallCardView* view = [[OSSmallCardView alloc] initWithFrame:testCardViewRect];
        view.tag = i + 1;
        view.backgroundColor = [UIColor lightGrayColor];
        view.layer.cornerRadius = 5;
        NSValue* value = [centersArray objectAtIndex:i];
        CGPoint center = [value CGPointValue];
        view.center = center;
        
        view.centerLabel.text = @"?";
        view.nameLabel.text = word.wordName;
        view.translationLabel.text = word.wordTranslation;
        
        [array addObject:view];
        
    }
    
    return array;
    
}

- (void)createOpenedCard:(NSInteger)wordIndex {
    
    OSWordEntity* word = [self.fetchedResultsController.fetchedObjects objectAtIndex:wordIndex];
    self.selectedWord = word;
    CGRect testCardFrame = CGRectMake(0, 0, self.view.bounds.size.width / 4 * 3,
                                      self.view.bounds.size.height / 4);
    UIView* testCardView =
    [[UIView alloc] initWithFrame:testCardFrame];
    testCardView.tag = 7;
    
    testCardView.backgroundColor = [OSColorsAndAttributes getDarkGreenColor];
    testCardView.layer.cornerRadius = 5;
    
    //LABEL
    CGRect labelRect =
    CGRectMake(0, 0, testCardView.frame.size.width, testCardView.frame.size.height / 4 * 2);
    UILabel* label = [[UILabel alloc] initWithFrame:labelRect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25];
    label.text = word.wordName;
    label.autoresizingMask = self.mask;
    
    [testCardView addSubview:label];
    
    //creating answer's logic
    
    NSMutableArray* answersArray = [NSMutableArray array];
    
    NSInteger position1 = arc4random()% 4;
    NSInteger position2 = 0;
    NSInteger position3 = 0;
    NSInteger position4 = 0;
    
    do {
        position2 = arc4random()% 4;
    } while (position1 == position2);
    
    do {
        position3 = arc4random()% 4;
    } while (position1 == position3 || position2 == position3);
    
    do {
        position4 = arc4random()% 4;
    } while (position1 == position4 || position2 == position4 || position3 == position4);
    
    for (int i = 0; i < 4; i++) {
        NSString* answer = @"answer";
        [answersArray addObject:answer];
    }
    
    NSString* answer1 = word.wordTranslation;
    [answersArray replaceObjectAtIndex:position1 withObject:answer1];
    
    NSString* answer2 = fakeAnswers [arc4random() % fakeAnswersCount];
    [answersArray replaceObjectAtIndex:position2 withObject:answer2];
    
    NSString* answer3 = fakeAnswers [arc4random() % fakeAnswersCount];
    [answersArray replaceObjectAtIndex:position3 withObject:answer3];
    
    NSString* answer4 = fakeAnswers [arc4random() % fakeAnswersCount];
    [answersArray replaceObjectAtIndex:position4 withObject:answer4];
    
    
    //CREATING FIELDS FOR ANSWER VARIANTS
    
    CGRect answer1Rect = CGRectMake(0, testCardView.frame.size.height / 4 * 2,
                                    testCardView.frame.size.width / 2,
                                    testCardView.frame.size.height / 4);
    UIButton* answer1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    answer1Button.tag = 1;
    answer1Button.frame = answer1Rect;
    answer1Button.backgroundColor = [OSColorsAndAttributes getDarkGreenColor];
    [answer1Button setTitle:[answersArray objectAtIndex:0] forState:UIControlStateNormal];
    [answer1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    answer1Button.autoresizingMask = self.mask;
    [answer1Button addTarget:self
                      action:@selector(actionAnswer:)
            forControlEvents:UIControlEventTouchUpInside];
    [testCardView addSubview:answer1Button];
    [self.answerButtonsArray addObject:answer1Button];
    
    CGRect answer2Rect = CGRectMake(testCardView.frame.size.width / 2,
                                    testCardView.frame.size.height / 4 * 2,
                                    testCardView.frame.size.width / 2,
                                    testCardView.frame.size.height / 4);
    UIButton* answer2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    answer2Button.tag = 2;
    answer2Button.frame = answer2Rect;
    answer2Button.backgroundColor = [OSColorsAndAttributes getDarkGreenColor];
    [answer2Button setTitle:[answersArray objectAtIndex:1] forState:UIControlStateNormal];
    [answer2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    answer2Button.autoresizingMask = self.mask;
    [answer2Button addTarget:self
                      action:@selector(actionAnswer:)
            forControlEvents:UIControlEventTouchUpInside];
    [testCardView addSubview:answer2Button];
    [self.answerButtonsArray addObject:answer2Button];
    
    CGRect answer3Rect = CGRectMake(0,
                                    testCardView.frame.size.height / 4 * 3,
                                    testCardView.frame.size.width / 2,
                                    testCardView.frame.size.height / 4);
    UIButton* answer3Button = [UIButton buttonWithType:UIButtonTypeCustom];
    answer3Button.tag = 3;
    answer3Button.frame = answer3Rect;
    answer3Button.backgroundColor = [OSColorsAndAttributes getDarkGreenColor];
    [answer3Button setTitle:[answersArray objectAtIndex:2] forState:UIControlStateNormal];
    [answer3Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    answer3Button.autoresizingMask = self.mask;
    [answer3Button addTarget:self
                      action:@selector(actionAnswer:)
            forControlEvents:UIControlEventTouchUpInside];
    [testCardView addSubview:answer3Button];
    [self.answerButtonsArray addObject:answer3Button];
    
    CGRect answer4Rect = CGRectMake(testCardView.frame.size.width / 2,
                                    testCardView.frame.size.height / 4 * 3,
                                    testCardView.frame.size.width / 2,
                                    testCardView.frame.size.height / 4);
    UIButton* answer4Button = [UIButton buttonWithType:UIButtonTypeCustom];
    answer4Button.tag = 4;
    answer4Button.frame = answer4Rect;
    answer4Button.backgroundColor = [OSColorsAndAttributes getDarkGreenColor];
    [answer4Button setTitle:[answersArray objectAtIndex:3] forState:UIControlStateNormal];
    [answer4Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    answer4Button.autoresizingMask = self.mask;
    [answer4Button addTarget:self
                      action:@selector(actionAnswer:)
            forControlEvents:UIControlEventTouchUpInside];
    [testCardView addSubview:answer4Button];
    [self.answerButtonsArray addObject:answer4Button];
    
    
     
    //BUTTON ON TESTCARD VIEW
    CGRect buttonRect =
    CGRectMake(testCardView.frame.size.width / 5,
               (testCardView.frame.size.height / 5) * 4,
               (testCardView.frame.size.width / 5) * 3,
               testCardView.frame.size.height / 5);
    
    UIButton* answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    answerButton.frame = buttonRect;
    answerButton.layer.cornerRadius = 3;
    answerButton.backgroundColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    answerButton.alpha = 0.9;
    [answerButton setTitle:@"Answer" forState:UIControlStateNormal];
    [answerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [answerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    answerButton.autoresizingMask = self.mask;
    
    [answerButton addTarget:self action:@selector(actionAnswer:) forControlEvents:UIControlEventTouchUpInside];
    
    //[testCardView addSubview:answerButton];
    
    CGPoint viewCenter = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    testCardView.center = viewCenter;
    testCardView.alpha = 0;
    
    self.testCardView = testCardView;
    
    [self.view addSubview:self.testCardView];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7f];
    self.testCardView.alpha = 0.95;
    [UIView commitAnimations];
    
}

#pragma mark - Actions

- (void)actionAnswer:(UIButton*)sender {
    
    self.selectedAnswer = sender.titleLabel.text;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [sender setBackgroundColor:[UIColor lightGrayColor]];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.7f];
    [UIView setAnimationDuration:0.3f];
    self.testCardView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.testCardView.alpha = 0;
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.testCardView removeFromSuperview];
    });
    
    
    NSString* successSoundFilePath = [NSString stringWithFormat:@"%@/sounds/success.m4a",
                                      [[NSBundle mainBundle] resourcePath]];
    NSURL* successSoundFileURL = [NSURL fileURLWithPath:successSoundFilePath];
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:successSoundFileURL error:nil];
    player.numberOfLoops = -1;
    self.player = player;
    [self.player play];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [player play];
    });
    
    __weak OSSmallCardView* deselectedView = nil;
    for (OSSmallCardView *v in self.viewsArray) {
        if (v.tag == self.selectedViewTag) {
            deselectedView = v;
        }
    }
    
    [UIView animateWithDuration:0.3 delay:1.2 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [deselectedView setAlpha:0.7];
        
        if (![self.selectedAnswer isEqualToString:self.selectedWord.wordTranslation]) {
            [deselectedView setBackgroundColor:[UIColor redColor]];
            [deselectedView setAlpha:0.7];
        } else {
            [deselectedView setBackgroundColor:[OSColorsAndAttributes getDarkGreenColor]];
            [deselectedView setAlpha:0.7];
        }
        
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
        
        deselectedView.centerLabel.alpha = 0;
        deselectedView.nameLabel.alpha = 1.f;
        deselectedView.translationLabel.alpha = 1.f;
        
    } completion:nil];
    
    self.selectedViewTag = 0;
    self.selectedView = nil;
    self.selectedWord = nil;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    UIView* view = [self.view hitTest:pointOnMainView withEvent:event];

    NSLog(@"%ld", view.tag);
    
    if (!self.selectedView) {
        
        if (![view isEqual:self.view]) {
            
            self.selectedView = view;
            [self.selectedView.layer removeAllAnimations];
            
            if (self.selectedViewTag == 0) {
                
                [UIView animateWithDuration:0.5
                                 animations:^{
                                     
                                     self.selectedView.alpha = 0.3;
                                     
                                 }];
                
                self.selectedViewTag = view.tag;
                
                NSInteger wordIndex = view.tag - 1;
                [self createOpenedCard:wordIndex]; //-------//
                
            } else if (view.tag == self.selectedViewTag) {
                
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     self.selectedView.alpha = 1.0;
                                 }];
                
                self.selectedViewTag = 0;
                
            } else {
                
                __weak UIView* deselectedView = nil;
                for (UIView *v in self.viewsArray) {
                    if (v.tag == self.selectedViewTag) {
                        deselectedView = v;
                    }
                }
                
                self.selectedViewTag = view.tag;
                
                [UIView animateWithDuration:0.5
                                 animations:^{
                                     
                                     [deselectedView setAlpha:1.0];
                                     self.selectedView.alpha = 0.3;
                                     
                                 }];
                
            }
        }
    }

}


#pragma mark - FetchedResultsController

- (void)wordList {
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"OSWordEntity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* wordNameDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"wordName" ascending:YES];
    [fetchRequest setSortDescriptors:@[wordNameDescriptor]];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    dayComponent.day = -1;
    NSDate *yesterday = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"wordCreatingDate > %@", yesterday];
    //[fetchRequest setPredicate:predicate]; // should uncomment this
    
    NSFetchedResultsController* aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:@"wordNameInitial"
                                                   cacheName:nil];
    [aFetchedResultsController performFetch:nil];
    self.fetchedResultsController = aFetchedResultsController;
    
}


@end
