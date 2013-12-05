CGAutoComplete
==============

A scroll view that appears under a UITextView that shows suggestions based off of data given to it. Like in Android's SDK...

![alt tag](http://chrisgalz.com/cgauto1.gif)

Everything is animated on iOS even though it is not shown in the gif.

To use the sample app
=======================
Just start typing "S" in the UITextField because all the sample data's text starts with S

Switch between the different types of suggestion views with the UISegmentedControl

To put in your own app
=======================
1. Drag into your Xcode project these files:

   CGAutoCompleteSuggestionsListView.h and .m

   CGAutoCompleteSuggestionView.h and .m

2. ```#import CGAutoCompleteSuggestionsListView.h``` on your header of the class you want this in
3. Put in the protocol: ```<CGAutoCompleteProtocol>```
4. Put in the protocol's methods:

```objc
- (void)suggestionSelected:(CGAutoCompleteSuggestionsListView*)suggestionsListView viewIndex:(int)index {}
- (int)numberOfSuggestions:(CGAutoCompleteSuggestionsListView*)suggestionsListView {}
- (CGAutoCompleteSuggestionView*)suggestionForIndex:(CGAutoCompleteSuggestionsListView*)suggestionsListView viewIndex:(int)index {}
```

5. Refer to the sample app on how to use the methods. They are pretty self explanatory.
6. Put the view in the app where you want it (usually under a text view) E.g:

```objc 
suggestions = [[CGAutoCompleteSuggestionsListView alloc] initWithFrame:CGRectMake(20, 130, 240, 0)];
suggestions.autoCompleteProtocol = self;
[self.view addSubview:suggestions];
```

7. There are 4 different types of Suggestion views: Text, Detailed Text, Image+Text, and Image+Detailed Text
8. Set the type of suggestion view you want in the suggestionForIndex protocol method with the initWithType E.g:

```objc
CGAutoCompleteSuggestionView *suggestionView = [[CGAutoCompleteSuggestionView alloc] initWithType:CGSuggestionTypeText];
```

9. Refresh the data of the suggestions with

```objc
[suggestions reloadSuggestions];
```

On the suggestion view itself, in the protocol method to set it up based on its index, these are the properties that can be set:

image, text, textFont, textColor, detailedText, detailedTextFont, detailedTextColor

The max amount of suggestions that are shown before becoming scrollable is set to 4 by default, but it is a constant that can be set in the source code if necessary.

Enjoy.
