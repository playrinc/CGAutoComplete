//
//  ViewController.h
//  CGAutoComplete
//
//  Created by Chris Galzerano on 12/4/13.
//  Copyright (c) 2013 Chris Galzerano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGAutoCompleteSuggestionsListView.h"

@interface ViewController : UIViewController <CGAutoCompleteProtocol, UITextFieldDelegate> {
    CGAutoCompleteSuggestionsListView *suggestions;
    NSArray *sampleData;
    NSMutableArray *queriedData;
    UITextField *TextField;
    NSString *suggestionViewType;
    
    IBOutlet UISegmentedControl *typeControl;
}

@end

@interface NSString (JRStringAdditions)

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options;

@end
