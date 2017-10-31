//
//  ProcedurePackageViewController.h
//  Patient
//
//  Created by think360 on 30/03/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcedurePackageViewController : UIViewController
{
    NSMutableIndexSet *expandedSections;
}
@property(nonatomic,retain) NSString *strType;

@property(nonatomic,retain) NSString *stramount;
@property(nonatomic,retain) NSString *strBPLCount;
@property(nonatomic,retain) NSString *strDoctorId;
@property(nonatomic,retain) NSString *strDoctorname;
@property(nonatomic,retain) NSString *strAddress;
@property(nonatomic,retain) NSString *strPic;
@property(nonatomic,retain) NSMutableArray *arrDoctorlistCategory;
@property(nonatomic,retain) NSString *strClinicName;

@property(nonatomic,retain) NSString *strTitle;
@property(nonatomic,retain) NSMutableArray *arrChildCategory;
@property(nonatomic,retain) NSMutableArray *arrChildCategoryp2;


@end
