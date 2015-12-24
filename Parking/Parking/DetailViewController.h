//
//  DetailViewController.h
//  Parking
//
//  Created by Alex Baev on 24/12/15.
//  Copyright © 2015 baevsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

