//
//  ConfirmPicViewController.m
//  Picsloot
//
//  Created by think360 on 26/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import "ConfirmPicViewController.h"
#import "CreolePhotoSelection.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "picsCell.h"
#import "UserInformation.h"

@interface ConfirmPicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CreolePhotoSelectionDelegate>
{
    picsCell *Cell;
    NSMutableArray *arrimages;
    UICollectionViewFlowLayout*collectionLayout;
}

@property (strong,nonatomic) NSMutableArray *arrimglist;
@property (nonatomic, copy) NSArray *chosenImages;
@end

@implementation ConfirmPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _collectionviewHeight.constant = (2)*(self.view.bounds.size.width/4+20);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification2:)
                                                 name:@"CounNotification2"
                                               object:nil];
    
     _backButt.hidden = YES;
    
    arrimages = [[NSMutableArray alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"Images"];
    arrimages = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    _imageCount.text = [NSString stringWithFormat:@"You selected %lu images ",(unsigned long)arrimages.count];
    
  
//    
//    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
//    [_PicsCollectionView setDataSource:self];
//    [_PicsCollectionView setDelegate:self];
//    [_PicsCollectionView registerClass:[picsCell class] forCellWithReuseIdentifier:@"picsCell"];
//    [_PicsCollectionView setBackgroundColor:[UIColor clearColor]];
//    [_PicsCollectionView setCollectionViewLayout:layout];
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    layout.minimumLineSpacing=0;
//    [_PicsCollectionView setShowsHorizontalScrollIndicator:NO];
//    [_PicsCollectionView setShowsVerticalScrollIndicator:NO];
}


#pragma mark - Notification Butt Clicked

- (IBAction)NotificationButtClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:tbc animated:YES];
}


- (void) receiveTestNotification2:(NSNotification *) notification
{
//    NSData *Decode=[[NSUserDefaults standardUserDefaults] objectForKey:@"Imagespics"];
//    UserInformation *info = [NSKeyedUnarchiver unarchiveObjectWithData:Decode];
//  
//    _arrImage = info.PicsArray;
}



#pragma mark - Collection View Delegates


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrimages.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%f",_PicsCollectionView.bounds.size.width/4);
     return CGSizeMake(_PicsCollectionView.bounds.size.width/4-1, _PicsCollectionView.bounds.size.width/4-1);
}




-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"picsCell";
    
    Cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    //NSString *strname=[arrimages objectAtIndex:indexPath.row];
    Cell.picsImageView.image=[arrimages objectAtIndex:indexPath.row];
    
    
    
    return Cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CreolePhotoSelection *objPhotoViewController= [[CreolePhotoSelection alloc] initWithNibName:@"CreolePhotoSelection" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:objPhotoViewController];
    objPhotoViewController.strTitle = @"All Photos";
    objPhotoViewController.delegate = self;
    objPhotoViewController.arySelectedPhoto = _arrImage;
    objPhotoViewController.maxCount = 6;
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}


-(void)getSelectedPhoto2:(NSMutableArray *)aryPhoto
{
    _arrImage = nil;
    _arrImage = [NSMutableArray new];
    _arrImage = [aryPhoto mutableCopy];
}


#pragma mark - Photo selected Delegate Method
-(void)getSelectedPhoto:(NSMutableArray *)aryPhoto
{
    //Initlize array
    _arrImage = nil;
    _arrImage = [NSMutableArray new];
    _arrImage = [aryPhoto mutableCopy]; //mainImage, Asset,     selected
    
    
    arrimages = nil;
    arrimages = [NSMutableArray new];
    
    
    NSInteger numberOfImages = _arrImage.count;
    
    for (int i = 0 ; i < numberOfImages ; i++)
    {
        UIImage *image;
        image = [[_arrImage objectAtIndex:i] valueForKey:@"mainImage"];
        
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:image];
        
        // NSArray *arr=[[_arrImage objectAtIndex:i] valueForKey:@"mainImage"];
        
        
        arrimages = [[arrimages arrayByAddingObjectsFromArray:arr] mutableCopy]; //mainImage, Asset, selected
        
        NSLog(@"%@",arrimages);
    }
    
    [_PicsCollectionView reloadData];
    
    _imageCount.text = [NSString stringWithFormat:@"You selected %lu images ",(unsigned long)arrimages.count];
    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrimages];
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"Images"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}






- (IBAction)UploadImagesButtClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"DeliveryAddressViewController"];
    [self.navigationController pushViewController:tbc animated:YES];
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
