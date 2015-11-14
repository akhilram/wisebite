//
//  InterfaceController.m
//  WiseBite WatchKit Extension
//
//  Created by Arjun Pola on 13/11/15.
//  Copyright © 2015 USC. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)speak {
    NSArray *suggestions = nil;
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModePlain completion:^(NSArray * _Nullable results) {
        
        NSLog(@"text = %@", results);
        
    }];
}

@end



