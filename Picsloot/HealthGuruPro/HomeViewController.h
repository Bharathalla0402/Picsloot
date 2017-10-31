//
//  HomeViewController.h
//  HealthGuruPro
//
//  Created by think360 on 08/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *NotificationCountLab;
@property (weak, nonatomic) IBOutlet UILabel *ApprovalCountLab;
@property (weak, nonatomic) IBOutlet UILabel *weekdayLab;
@property (weak, nonatomic) IBOutlet UILabel *DateLab;
@property (weak, nonatomic) IBOutlet UIButton *leftDateButt;
@property (weak, nonatomic) IBOutlet UIButton *RightDateButt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentSchedule;
@property (weak, nonatomic) IBOutlet UITableView *scheduleTabl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tablheightConstraint;

@end
