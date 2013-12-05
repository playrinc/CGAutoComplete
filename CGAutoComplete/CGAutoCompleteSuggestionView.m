//
//  CGAutoCompleteSuggestionView.m
//  CGAutoComplete
//
//  Created by Chris Galzerano on 12/4/13.
//  Copyright (c) 2013 Chris Galzerano. All rights reserved.
//

#import "CGAutoCompleteSuggestionView.h"

@implementation CGAutoCompleteSuggestionView

@synthesize suggestionViewType = _suggestionViewType, image = _image, text = _text, detailedText = _detailedText, textColor = _textColor, detailedTextColor = _detailedTextColor, textFont = _textFont, detailedTextFont = _detailedTextFont;

//View Types
NSString * const CGSuggestionTypeText = @"text";
NSString * const CGSuggestionTypeDetailedText = @"detail_text";
NSString * const CGSuggestionTypeImageText = @"image_text";
NSString * const CGSuggestionTypeImageDetailedText = @"image_detail_text";
float const SuggestionViewHeight = 30.0f;
int const NumberOfSuggestionsToShow = 4;

- (id)initWithType:(NSString*)type
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self) {
        // Initialization code
        _suggestionViewType = type;
        self.contentMode = UIViewContentModeRedraw;
        self.opaque = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _textColor = [UIColor blackColor];
        _detailedTextColor = [UIColor darkGrayColor];
        _textFont = [UIFont systemFontOfSize:10];
        _detailedTextFont = [UIFont systemFontOfSize:8];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSDictionary *textAttributes = @{NSFontAttributeName: _textFont, NSForegroundColorAttributeName: _textColor};
    NSDictionary *detailedTextAttributes = @{NSFontAttributeName: _detailedTextFont, NSForegroundColorAttributeName: _detailedTextColor};
    
    if ([_suggestionViewType isEqualToString:CGSuggestionTypeText]) {
        [self.text drawInRect:CGRectMake(7, 8, self.bounds.size.width-14, 12) withAttributes:textAttributes];
    }
    else if ([_suggestionViewType isEqualToString:CGSuggestionTypeDetailedText]) {
        [self.text drawInRect:CGRectMake(7, 4, self.bounds.size.width-14, 12) withAttributes:textAttributes];
        [self.detailedText drawInRect:CGRectMake(7, 16, self.bounds.size.width-14, 10) withAttributes:detailedTextAttributes];
    }
    else if ([_suggestionViewType isEqualToString:CGSuggestionTypeImageText]) {
        [self.image drawInRect:CGRectMake(5, 5, 20, 20)];
        [self.text drawInRect:CGRectMake(30, 8, self.bounds.size.width-35, 12) withAttributes:textAttributes];
    }
    else if ([_suggestionViewType isEqualToString:CGSuggestionTypeImageDetailedText]) {
        [self.image drawInRect:CGRectMake(5, 5, 20, 20)];
        [self.text drawInRect:CGRectMake(30, 4, self.bounds.size.width-14, 12) withAttributes:textAttributes];
        [self.detailedText drawInRect:CGRectMake(30, 16, self.bounds.size.width-14, 10) withAttributes:detailedTextAttributes];
    }
}


@end
