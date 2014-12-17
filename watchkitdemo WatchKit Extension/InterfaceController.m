//
//  InterfaceController.m
//  watchkitdemo WatchKit Extension
//
//  Created by Avi Wilensky on 12/16/14.
//  Copyright (c) 2014 Avi Wilensky. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *instagramImage;

@property NSArray* instagramImages;

@property NSInteger* index;

@end


@implementation InterfaceController

-(void) loadImage {
    UIImage* image = [self.instagramImages objectAtIndex:self.index];
    [self.instagramImage setImage:image];
}


- (IBAction)nextButtonPressed {
    self.index++;
    if(self.index >= [self.instagramImages count]){
        self.index = 0;
    }
    [self loadImage];
}
    


- (instancetype)initWithContext:(id)context {
    
    self = [super initWithContext:context];
    if (self) {
        self.index = 0;
        
        NSString* endpoint = @"https://api.instagram.com/v1/tags/kimkardashian/media/recent?access_token=219890611.e669052.af303f88246a4e63b1bd7e93afe24e43";
        
        NSData* data =[NSData dataWithContentsOfURL:[NSURL URLWithString:endpoint]];
        
        NSDictionary* object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray* images = [NSMutableArray array];
        
        for (NSDictionary* imageData in object[@"data"]) {
            
            NSString* imageURL = imageData[@"images"][@"low_resolution"][@"url"];
            NSLog(@"%@", imageURL);
            
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            
            UIImage* image = [UIImage imageWithData:data];
            [images addObject:image];

            
        }
        self.instagramImages = images;
        
        [self loadImage];
        
        NSLog(@"%@", object);
        
    }
    
    return self;
        
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

@end



