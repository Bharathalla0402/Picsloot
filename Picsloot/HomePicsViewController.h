//
//  HomePicsViewController.h
//  Picsloot
//
//  Created by think360 on 16/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePicsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backButt;
@property (weak, nonatomic) IBOutlet UILabel *NotificationCount;
@property (weak, nonatomic) IBOutlet UILabel *latestorderlab;
@property (weak, nonatomic) IBOutlet UIView *orderView;

@property (weak, nonatomic) IBOutlet UICollectionView *ImageCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *DateSent;
@property (weak, nonatomic) IBOutlet UIImageView *DateSentImg;
@property (weak, nonatomic) IBOutlet UILabel *DateReceived;
@property (weak, nonatomic) IBOutlet UIImageView *DateReceivedImg;
@property (weak, nonatomic) IBOutlet UILabel *DateAddress;
@property (weak, nonatomic) IBOutlet UIImageView *DateAddressImg;
@property (weak, nonatomic) IBOutlet UILabel *DateComplete;
@property (weak, nonatomic) IBOutlet UIImageView *DateCompleteImg;

@end
