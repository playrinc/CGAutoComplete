//
//  CGAutoCompleteSuggestionsListView.h
//  CGAutoComplete
//
//  Created by Chris Galzerano on 12/4/13.
//  Copyright (c) 2013 Chris Galzerano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGAutoCompleteSuggestionView.h"

@class CGAutoCompleteSuggestionsListView;

@protocol CGAutoCompleteProtocol<NSObject>
- (CGAutoCompleteSuggestionView*)suggestionForIndex:(CGAutoCompleteSuggestionsListView*)suggestionsListView viewIndex:(int)index;
- (int)numberOfSuggestions:(CGAutoCompleteSuggestionsListView*)suggestionsListView;
- (void)suggestionSelected:(CGAutoCompleteSuggestionsListView*)suggestionsListView viewIndex:(int)index;
@end

@interface CGAutoCompleteSuggestionsListView : UIScrollView {
    NSMutableArray *suggestionViews;
}

@property (nonatomic, assign) id<CGAutoCompleteProtocol> autoCompleteProtocol;
- (void) reloadSuggestions;

@end

@interface UITapGestureRecognizer(Property)

@property (nonatomic, retain) NSNumber *index;

@end


