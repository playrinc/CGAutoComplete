//
//  CGAutoCompleteSuggestionsListView.h
//  CGAutoComplete
//
//  Created by Chris Galzerano on 12/4/13.
//  Copyright (c) 2013 Chris Galzerano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGAutoCompleteSuggestionView.h"

@protocol CGAutoCompleteProtocol<NSObject>
- (CGAutoCompleteSuggestionView*)suggestionForIndex:(id)suggestionsListView viewIndex:(int)index;
- (int)numberOfSuggestions:(id)suggestionsListView;
- (void)suggestionSelected:(id)suggestionsListView viewIndex:(int)index;
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


