//
//  CGAutoCompleteSuggestionsListView.m
//  CGAutoComplete
//
//  Created by Chris Galzerano on 12/4/13.
//  Copyright (c) 2013 Chris Galzerano. All rights reserved.
//

#import "CGAutoCompleteSuggestionsListView.h"

@implementation CGAutoCompleteSuggestionsListView

@synthesize autoCompleteProtocol = _autoCompleteProtocol;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        suggestionViews = [NSMutableArray array];
    }
    return self;
}

- (void) reloadSuggestions {
    NSMutableArray *newSuggestions = [NSMutableArray array];
    int numberOfSuggestions;
    if ([_autoCompleteProtocol respondsToSelector:@selector(numberOfSuggestions:)])
        numberOfSuggestions = [_autoCompleteProtocol numberOfSuggestions:self];
    else
        numberOfSuggestions = 0;
    
    NSLog(@"num of sug %d", numberOfSuggestions);
    
    self.contentSize = CGSizeMake(self.frame.size.width, numberOfSuggestions*SuggestionViewHeight);
    [UIView animateWithDuration:0.3f animations:^{
        if (numberOfSuggestions <= NumberOfSuggestionsToShow) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, numberOfSuggestions*SuggestionViewHeight);
        }
        else {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, NumberOfSuggestionsToShow*SuggestionViewHeight);
        }
    }completion:nil];
    
    if (numberOfSuggestions > 0) {
        
        for (int i = 0; i < numberOfSuggestions; i++) {
            CGAutoCompleteSuggestionView *suggestionView;
            if ([_autoCompleteProtocol respondsToSelector:@selector(suggestionForIndex:viewIndex:)]) {
                suggestionView = [_autoCompleteProtocol suggestionForIndex:self viewIndex:i];
                suggestionView.frame = CGRectMake(0, SuggestionViewHeight*i, self.frame.size.width, SuggestionViewHeight);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(touchTheDelegate:)];
                tap.index = [NSNumber numberWithInt:i];
                [suggestionView addGestureRecognizer:tap];
                
            }
            if (suggestionView) {
                [newSuggestions addObject:suggestionView];
                if (![suggestionViews containsObject:suggestionView]) {
                    [suggestionViews addObject:suggestionView];
                }
                
            }
            NSMutableArray *cleanup = [NSMutableArray array];
            for (CGAutoCompleteSuggestionView *view in suggestionViews) {
                if (![newSuggestions containsObject:view]) {
                    [view removeFromSuperview];
                    [cleanup addObject:view];
                }
            }
            [suggestionViews removeObjectsInArray:cleanup];
        }
        for (CGAutoCompleteSuggestionView *view in suggestionViews) {
            [self addSubview:view];
            NSLog(@"view being added");
        }
    }
    else {
        NSMutableArray *cleanup = [NSMutableArray array];
        for (CGAutoCompleteSuggestionView *view in suggestionViews) {
            if (![newSuggestions containsObject:view]) {
                [view removeFromSuperview];
                [cleanup addObject:view];
            }
        }
        [suggestionViews removeObjectsInArray:cleanup];
    }
}

- (void) touchTheDelegate:(UITapGestureRecognizer*)sender {
    if ([_autoCompleteProtocol respondsToSelector:@selector(suggestionSelected:viewIndex:)])
        [_autoCompleteProtocol suggestionSelected:self viewIndex:sender.index.intValue];
    
    [[suggestionViews objectAtIndex:sender.index.intValue] setAlpha:0.3];
    [UIView animateWithDuration:0.6f animations:^{
             [[suggestionViews objectAtIndex:sender.index.intValue] setAlpha:1.0];
        }completion:nil];
}

@end

#import <objc/runtime.h>

@implementation UITapGestureRecognizer(Property)

static char UIB_PROPERTY_KEY;

@dynamic index;

-(void)setIndex:(NSObject*)index
{
    objc_setAssociatedObject(self, &UIB_PROPERTY_KEY, index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject*)index
{
    return (NSObject*)objc_getAssociatedObject(self, &UIB_PROPERTY_KEY);
}

@end


