//
//  CGAutoCompleteSuggestionView.h
//  CGAutoComplete
//
//  Created by Chris Galzerano on 12/4/13.
//  Copyright (c) 2013 Chris Galzerano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGAutoCompleteSuggestionView : UIView

extern NSString * const CGSuggestionTypeText;
extern NSString * const CGSuggestionTypeDetailedText;
extern NSString * const CGSuggestionTypeImageText;
extern NSString * const CGSuggestionTypeImageDetailedText;
extern float const SuggestionViewHeight;
extern int const NumberOfSuggestionsToShow;

@property (nonatomic, retain, readonly) NSString *suggestionViewType;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *detailedText;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *detailedTextColor;
@property (nonatomic, retain) UIFont *textFont;
@property (nonatomic, retain) UIFont *detailedTextFont;

- (id)initWithType:(NSString*)type;

@end
