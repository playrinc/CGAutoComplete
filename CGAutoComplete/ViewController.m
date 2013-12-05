//
//  ViewController.m
//  CGAutoComplete
//
//  Created by Chris Galzerano on 12/4/13.
//  Copyright (c) 2013 Chris Galzerano. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    queriedData = [NSMutableArray array];
    suggestionViewType = CGSuggestionTypeText;
    
    sampleData = @[
                   @{@"text":@"Suggestion h1", @"detailText":@"details about suggestion 1", @"image":@"1"},
                   @{@"text":@"Suggestion h23", @"detailText":@"details about suggestion 2", @"image":@"2"},
                   @{@"text":@"Suggestion h345", @"detailText":@"details about suggestion 3", @"image":@"3"},
                   @{@"text":@"Suggestion h421", @"detailText":@"details about suggestion 4", @"image":@"4"},
                   @{@"text":@"Suggestion h51234", @"detailText":@"details about suggestion 5", @"image":@"5"},
                   @{@"text":@"Suggestion h64", @"detailText":@"details about suggestion 6", @"image":@"6"},
                   @{@"text":@"Suggestion h7", @"detailText":@"details about suggestion 7", @"image":@"7"}
                   ];
    
    suggestions = [[CGAutoCompleteSuggestionsListView alloc] initWithFrame:CGRectMake(20, 130, 240, 0)];
    suggestions.autoCompleteProtocol = self;
    suggestions.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    suggestions.hidden = YES;
    [self.view addSubview:suggestions];
    
    [typeControl addTarget:self action:@selector(SwitchType) forControlEvents:UIControlEventValueChanged];
    
    TextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
    TextField.delegate = self;
    TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    TextField.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(runSampleQuery)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:TextField];
    
    [self.view addSubview:TextField];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) runSampleQuery {
    //Bad, quick, sample of a search for example data
    suggestions.hidden = NO;
    
    NSMutableArray *mainStrings = [NSMutableArray array];
    [queriedData removeAllObjects];
    
    
    for (NSDictionary *dict in sampleData) {
        [mainStrings addObject:dict[@"text"]];
    }
    
    for (NSString *string in mainStrings) {
        if ([string containsString:TextField.text])
            [queriedData addObject:[sampleData objectAtIndex:[mainStrings indexOfObject:string]]];
    }
    
    NSLog(@"results: %d", queriedData.count);
    
    [suggestions reloadSuggestions];
    
}


- (void)suggestionSelected:(id)suggestionsListView viewIndex:(int)index {
    NSDictionary *data = [queriedData objectAtIndex:index];
    NSLog(@"This suggestion was selected: %@", data[@"text"]);
}

- (int)numberOfSuggestions:(id)suggestionsListView {
    return queriedData.count;
}

- (CGAutoCompleteSuggestionView*)suggestionForIndex:(id)suggestionsListView viewIndex:(int)index {
    CGAutoCompleteSuggestionView *suggestionView = [[CGAutoCompleteSuggestionView alloc] initWithType:suggestionViewType];
    NSDictionary *data = [queriedData objectAtIndex:index];
    suggestionView.text = data[@"text"];
    suggestionView.detailedText = data[@"detailText"];
    suggestionView.image = [UIImage imageNamed:data[@"image"]];
    return suggestionView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    suggestions.hidden = YES;
    return YES;
}

- (void)SwitchType {
    switch (typeControl.selectedSegmentIndex) {
        case 0:
            suggestionViewType = CGSuggestionTypeText;
            break;
        case 1:
            suggestionViewType = CGSuggestionTypeDetailedText;
            break;
        case 2:
            suggestionViewType = CGSuggestionTypeImageText;
            break;
        case 3:
            suggestionViewType = CGSuggestionTypeImageDetailedText;
            break;
        default:
            suggestionViewType = CGSuggestionTypeText;
            break;
    }
        
    [suggestions reloadSuggestions];
    
}

@end

@implementation NSString (JRStringAdditions)

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}



@end
