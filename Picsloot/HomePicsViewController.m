//
//  HomePicsViewController.m
//  Picsloot
//
//  Created by think360 on 16/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import "HomePicsViewController.h"
#import "CreolePhotoSelection.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "PicsViewCell.h"
#import "ConfirmPicViewController.h"
#import "UserInformation.h"

@interface HomePicsViewController ()<UINavigationControllerDelegate, UIScrollViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,CreolePhotoSelectionDelegate>
{
     UserInformation *userInfo;
    PicsViewCell *Cell;
    NSMutableArray *arrimages;
    
    NSMutableArray *arrpics;
}
@property (strong,nonatomic) NSMutableArray *arrImage;
@property (strong,nonatomic) NSMutableArray *arrimglist;
@property (nonatomic, copy) NSArray *chosenImages;

@end

@implementation HomePicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     userInfo=[[UserInformation alloc] init];
    
    arrpics = [[NSMutableArray alloc]init];
    
    _backButt.hidden = YES;
    
    arrimages = [[NSMutableArray alloc]initWithObjects:@"1img",@"2img",@"3img",@"4img",@"5img", nil];
    
    UIColor *normalColor = [UIColor lightGrayColor];
    UIColor *highlightColor = [UIColor blackColor];
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIFont *font2 = [UIFont boldSystemFontOfSize:14.0];
    NSDictionary *normalAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:normalColor};
    NSDictionary *highlightAttributes = @{NSFontAttributeName:font2, NSForegroundColorAttributeName:highlightColor};
    
    
    NSAttributedString *normalText = [[NSAttributedString alloc] initWithString:@"Date 22/09/2017, 6.00 PM, " attributes:normalAttributes];
    NSAttributedString *highlightedText = [[NSAttributedString alloc] initWithString:@"5 images sent" attributes:highlightAttributes];
    NSMutableAttributedString *finalAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:normalText];
    [finalAttributedString appendAttributedString:highlightedText];
    _DateSent.attributedText = finalAttributedString;
    
    
    NSAttributedString *normalText1 = [[NSAttributedString alloc] initWithString:@"Date 24/09/2017, 10.00 AM, " attributes:normalAttributes];
    NSAttributedString *highlightedText1 = [[NSAttributedString alloc] initWithString:@"PicsLOOT Images Received" attributes:highlightAttributes];
    NSMutableAttributedString *finalAttributedString1 = [[NSMutableAttributedString alloc] initWithAttributedString:normalText1];
    [finalAttributedString1 appendAttributedString:highlightedText1];
    _DateReceived.attributedText = finalAttributedString1;

    
    NSAttributedString *normalText2 = [[NSAttributedString alloc] initWithString:@"Date 27/09/2017, 4.00 PM, " attributes:normalAttributes];
    NSAttributedString *highlightedText2 = [[NSAttributedString alloc] initWithString:@"PicsLOOT Images Printout send your mentioned Address" attributes:highlightAttributes];
    NSMutableAttributedString *finalAttributedString2 = [[NSMutableAttributedString alloc] initWithAttributedString:normalText2];
    [finalAttributedString2 appendAttributedString:highlightedText2];
    _DateAddress.attributedText = finalAttributedString2;
    
    
    NSAttributedString *normalText3 = [[NSAttributedString alloc] initWithString:@"Date 29/09/2017, 4.00 PM, " attributes:normalAttributes];
    NSAttributedString *highlightedText3 = [[NSAttributedString alloc] initWithString:@"Order Complete" attributes:highlightAttributes];
    NSMutableAttributedString *finalAttributedString3 = [[NSMutableAttributedString alloc] initWithAttributedString:normalText3];
    [finalAttributedString3 appendAttributedString:highlightedText3];
    _DateComplete.attributedText = finalAttributedString3;
    
    
    NSString *strname = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]];
    
    NSString *message = [NSString stringWithFormat:@"Welcome to picsloot %@",strname];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    int duration = 3; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });

}


#pragma mark - Notification Butt Clicked

- (IBAction)NotificationButtClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:tbc animated:YES];
}





- (IBAction)PicsButtClicked:(id)sender
{
    CreolePhotoSelection *objPhotoViewController= [[CreolePhotoSelection alloc] initWithNibName:@"CreolePhotoSelection" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:objPhotoViewController];
    objPhotoViewController.strTitle = @"All Photos";
    objPhotoViewController.delegate = self;
    objPhotoViewController.arySelectedPhoto = _arrImage;
    objPhotoViewController.maxCount = 6;
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}


#pragma mark - Photo selected Delegate Method
-(void)getSelectedPhoto:(NSMutableArray *)aryPhoto
{
    //Initlize array
    _arrImage = nil;
    _arrImage = [NSMutableArray new];
    _arrImage = [aryPhoto mutableCopy]; //mainImage, Asset,     selected
    
    
    _arrimglist = nil;
    _arrimglist = [NSMutableArray new];
    
    arrpics = _arrImage;
    
    
    NSInteger numberOfImages = _arrImage.count;
    
    for (int i = 0 ; i < numberOfImages ; i++)
    {
        UIImage *image;
         image = [[_arrImage objectAtIndex:i] valueForKey:@"mainImage"];
        
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:image];
        
       // NSArray *arr=[[_arrImage objectAtIndex:i] valueForKey:@"mainImage"];
        
     
        _arrimglist = [[_arrimglist arrayByAddingObjectsFromArray:arr] mutableCopy]; //mainImage, Asset, selected
        
        NSLog(@"%@",_arrimglist);
    }

//    [[UserInformation sharedController] updateuserinfo:arrpics];
//    NSData *encode = [NSKeyedArchiver archivedDataWithRootObject:[UserInformation sharedController]];
//    [[NSUserDefaults standardUserDefaults] setObject:encode forKey:@"Imagespics"];
//    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_arrimglist];
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"Images"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    ConfirmPicViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmPicViewController"];
    tbc.arrImage = _arrImage;
    tbc.arrImage2 = _arrImage;
    [self.navigationController pushViewController:tbc animated:YES];
   
}



#pragma mark - Collection View Delegates


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrimages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PicsViewCell";
    
    Cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    NSString *strname=[arrimages objectAtIndex:indexPath.row];
    Cell.picImageView.image=[UIImage imageNamed:strname];
    
    
    
    return Cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
}





















- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}




#pragma mark -- UIAlertView Method
-(void)showMessage:(NSString*)message withTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
