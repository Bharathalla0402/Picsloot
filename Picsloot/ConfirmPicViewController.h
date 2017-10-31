//
//  ConfirmPicViewController.h
//  Picsloot
//
//  Created by think360 on 26/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmPicViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backButt;
@property (weak, nonatomic) IBOutlet UILabel *NotificationCount;
@property (weak, nonatomic) IBOutlet UICollectionView *PicsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *imageCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewHeight;

@property (strong,nonatomic) NSMutableArray *arrImage;
@property (strong,nonatomic) NSMutableArray *arrImage2;

@end
