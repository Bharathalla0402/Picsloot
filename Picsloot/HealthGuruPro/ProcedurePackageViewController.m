//
//  ProcedurePackageViewController.m
//  Patient
//
//  Created by think360 on 30/03/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import "ProcedurePackageViewController.h"
#import "ApiRequest.h"
#import "ExpandableTableView.h"
#import "ALCustomColoredAccessory.h"
#import "UIFloatLabelTextField.h"



static NSString *SectionHeaderViewIdentifier    = @"SectionHeaderViewIdentifier";
static NSString *DemoTableViewIdentifier        = @"DemoTableViewIdentifier";


@interface ProcedurePackageViewController ()<ApiRequestdelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    ApiRequest *requested;
    UILabel *AvailBalancelab,*titlelab,*NoticationLab;
    UIScrollView *categoryScrollView;
    UISegmentedControl *segmentedControl;
   // ExpandableTableView *tabl;
    NSMutableArray *arrcategeorys;
    NSMutableArray *arraylist;
    UITableView *tabl,*tabl2;
    
    UIGraphicsRendererContext *Context;
    
    int x;
    
    float a;
    
    int c1,c2;
    
    UIButton *ListButton,*PackageButton;
    
    UIView *popview;
    UIView *footerview;
    
    UIFloatLabelTextField *listName,*sublistName,*listPrice,*packageName,*packagePrice;
    UILabel *linelabel2,*linelabel3,*linelabel4,*packageDiscount;
    UITextView *packageDesc;
    UISlider *discountSlider;
    UISwitch *switchcheck;
    
}

@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, strong) NSArray *headers;

@property (nonatomic, strong) NSArray <NSDictionary *> *productsList1;

@end

@implementation ProcedurePackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    requested=[[ApiRequest alloc]init];
    requested.delegate=self;
    
    x=0;
    arrcategeorys=[[NSMutableArray alloc]init];
  
    _productsList1=_arrChildCategory;
    
    arrcategeorys=[_productsList1 valueForKey:@"name"];
    
    [self CustomView];
}










#pragma mark - CustomView

-(void)CustomView
{
    // topview
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        c1 = 64;
        c2 = 25;
        
    }
    else
    {
        c1 = 84;
        c2 = 35;
    }
   
    
    
    
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, c1)];
    topView.backgroundColor=[UIColor colorWithRed:59.0/255.0f green:234.0/255.0f blue:217.0/255.0f alpha:1.0];
    [self.view addSubview:topView];
    
    UIImageView *backimage=[[UIImageView alloc] initWithFrame:CGRectMake(5, c2, 30, 30)];
    backimage.image=[UIImage imageNamed:@"Back"];
    backimage.contentMode = UIViewContentModeScaleAspectFit;
    [topView addSubview:backimage];
    
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 10, 70, topView.frame.size.height-10)];
    [backButton addTarget:self action:@selector(BackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor=[UIColor clearColor];
    [topView addSubview:backButton];
    

    titlelab=[[UILabel alloc] initWithFrame:CGRectMake(60, topView.frame.size.height/2-25+5, topView.frame.size.width-120, 50)];
    titlelab.text=_strTitle;
    titlelab.numberOfLines=2;
    titlelab.font=[UIFont boldSystemFontOfSize:15];
    titlelab.textAlignment=NSTextAlignmentCenter;
    titlelab.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [topView addSubview:titlelab];
    
    

    
    UIImageView *Walletimage=[[UIImageView alloc] initWithFrame:CGRectMake(topView.frame.size.width-45, topView.frame.size.height/2-10, 35, 35)];
    Walletimage.image=[UIImage imageNamed:@"NotificationBell"];
    Walletimage.contentMode = UIViewContentModeScaleAspectFit;
    [topView addSubview:Walletimage];
    
    NoticationLab=[[UILabel alloc]initWithFrame:CGRectMake(topView.frame.size.width-30, topView.frame.size.height/2-11, 22, 22)];
    NoticationLab.backgroundColor=[UIColor colorWithRed:255.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
    NoticationLab.layer.masksToBounds = YES;
    NoticationLab.layer.cornerRadius = 11.0;
    NoticationLab.textColor=[UIColor whiteColor];
    NoticationLab.font=[UIFont systemFontOfSize:12];
    NoticationLab.textAlignment=NSTextAlignmentCenter;
    NoticationLab.text=@"10";
    [topView addSubview:NoticationLab];
    
    UIButton *NotificationButton=[[UIButton alloc] initWithFrame:CGRectMake(topView.frame.size.width-97, 0, 40, 40)];
    [NotificationButton addTarget:self action:@selector(NotificationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    NotificationButton.backgroundColor=[UIColor clearColor];
    [topView addSubview:NotificationButton];
    
    UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, topView.frame.size.height-1, self.view.frame.size.width, 1)];
    linelabel.backgroundColor=[UIColor lightGrayColor];
    [topView addSubview:linelabel];
    
    
    
    
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Procedure List", @"Procedure Packages", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(15, topView.frame.size.height+topView.frame.origin.y+15, self.view.frame.size.width-30, 40);
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    NSDictionary *attributes1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                 [UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes1 forState:UIControlStateNormal];
    
    UIColor *selectedColor = [UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0];
    
    for (id subview in [segmentedControl subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
    }
    [self.view addSubview:segmentedControl];
    
    

    
    
    
    tabl=[[UITableView alloc] initWithFrame:CGRectMake(0, segmentedControl.frame.size.height+segmentedControl.frame.origin.y+15, self.view.frame.size.width, self.view.frame.size.height-185)];
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabl.rowHeight=UITableViewAutomaticDimension;
    tabl.estimatedRowHeight=85;
    tabl.showsHorizontalScrollIndicator = NO;
    tabl.showsVerticalScrollIndicator = NO;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabl.hidden=YES;
    tabl.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:tabl];
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    
    
    
    tabl2=[[UITableView alloc] initWithFrame:CGRectMake(0, segmentedControl.frame.size.height+segmentedControl.frame.origin.y+15, self.view.frame.size.width, self.view.frame.size.height-185)];
    tabl2.delegate=self;
    tabl2.dataSource=self;
    tabl2.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabl2.rowHeight=UITableViewAutomaticDimension;
    tabl2.estimatedRowHeight=85;
    tabl2.showsHorizontalScrollIndicator = NO;
    tabl2.showsVerticalScrollIndicator = NO;
    tabl2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabl2.hidden=YES;
    tabl2.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:tabl2];

    
    
    
    
    
    ListButton=[[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 45)];
    ListButton.backgroundColor=[UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0];
    [ListButton setTitle:@"+ ADD NEW PROCEDURE LIST" forState:UIControlStateNormal];
    ListButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    ListButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [ListButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ListButton addTarget:self action:@selector(ListButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ListButton];
    
    
    PackageButton=[[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 45)];
    PackageButton.backgroundColor=[UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0];
    [PackageButton setTitle:@"+ ADD NEW PROCEDURE PACKAGES" forState:UIControlStateNormal];
    PackageButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    PackageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [PackageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PackageButton addTarget:self action:@selector(PackageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PackageButton];
    
    
    
    
    if([_strTitle isEqualToString:@"Procedure List"])
    {
        segmentedControl.selectedSegmentIndex = 0;
        tabl.hidden=NO;
        tabl2.hidden=YES;
        ListButton.hidden = NO;
        PackageButton.hidden = YES;
    }
    else
    {
        segmentedControl.selectedSegmentIndex = 1;
        tabl2.hidden=NO;
        tabl.hidden=YES;
        ListButton.hidden = YES;
        PackageButton.hidden = NO;
    }
    
    
    
   

}




#pragma mark - Segment Changed

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    UIColor *selectedColor = [UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0];
    
    for (id subview in [segmentedControl subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                [UIColor colorWithRed:1.0/255.0f green:23.0/255.0f blue:239.0/255.0f alpha:1.0], NSForegroundColorAttributeName, nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    if(segment.selectedSegmentIndex == 0)
    {
       titlelab.text=@"Procedure List";
        tabl.hidden=NO;
        tabl2.hidden=YES;
        ListButton.hidden = NO;
        PackageButton.hidden = YES;
    }
    else if(segment.selectedSegmentIndex == 1)
    {
       titlelab.text=@"Procedure Packages";
        tabl.hidden=YES;
        tabl2.hidden=NO;
        ListButton.hidden = YES;
        PackageButton.hidden = NO;
    }
}



#pragma mark - TableView Delegate Methods


- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (tableView==tabl)
    {
        for (int i=0; i<arrcategeorys.count; i++)
        {
            if (section==i)
            {
                NSString *strcount=[NSString stringWithFormat:@"%lu",(unsigned long)[[[_productsList1 objectAtIndex:i] valueForKey:@"child"]count]];
                int i=(int)[strcount integerValue];
                if (i==0)
                {
                    return NO;
                }
                else
                {
                    return YES;
                }
            }
        }
        return NO;
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==tabl)
    {
        return arrcategeorys.count;
    }
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==tabl)
    {
        if ([self tableView:tableView canCollapseSection:section])
        {
            if ([expandedSections containsIndex:section])
            {
                NSString *strcount=[NSString stringWithFormat:@"%lu",(unsigned long)[[[_productsList1 objectAtIndex:section]valueForKey:@"child"] count]];
                int i=(int)[strcount integerValue];
                i=i+1;
                return i;// return rows when expanded
            }
            
            return 1; // only top row showing
        }
        
        // Return the number of rows in the section.
        return 1;
    }
    else{
        return _arrChildCategoryp2.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // return UITableViewAutomaticDimension;
    
    if (tableView==tabl)
    {
        if ([self tableView:tableView canCollapseSection:indexPath.section])
        {
            if (!indexPath.row)
            {
                return 50;
            }
            else
            {
                return 50;
            }
        }
        else
        {
            return 50;
        }
    }
    else
    {
        UIView *view1=[[UIView alloc]init];
        UILabel *label1=[[UILabel alloc] init];
        UILabel *label2=[[UILabel alloc]init];
        UILabel *label3=[[UILabel alloc]init];
        UILabel *label4=[[UILabel alloc]init];
        
        view1.backgroundColor=[UIColor whiteColor];
//        view1.layer.borderColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f].CGColor;
//        view1.layer.borderWidth = 2.0f;
        
        
        label1.textColor=[UIColor blackColor];
        label1.font=[UIFont boldSystemFontOfSize:15];
        label1.numberOfLines=0;
        label1.textAlignment=NSTextAlignmentLeft;
        [label1 setAdjustsFontSizeToFitWidth:YES];
        
        label2.textColor=[UIColor blackColor];
        label2.font=[UIFont systemFontOfSize:15];
        label2.numberOfLines=0;
        label2.textAlignment=NSTextAlignmentLeft;
        [label2 setAdjustsFontSizeToFitWidth:YES];
        
        label3.textColor=[UIColor blueColor];
        label3.font=[UIFont boldSystemFontOfSize:15];
        label3.numberOfLines=0;
        label3.textAlignment=NSTextAlignmentLeft;
        [label3 setAdjustsFontSizeToFitWidth:YES];
        
        label4.textColor=[UIColor blackColor];
        label4.font=[UIFont systemFontOfSize:15];
        label4.numberOfLines=0;
        label4.textAlignment=NSTextAlignmentRight;
        [label4 setAdjustsFontSizeToFitWidth:YES];
        
        view1.backgroundColor=[UIColor whiteColor];
//        view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        view1.layer.borderWidth = 1.0f;
        
        
        
        label1.text=[[_arrChildCategoryp2 valueForKey:@"name"] objectAtIndex:indexPath.row];
        label2.text=[[_arrChildCategoryp2 valueForKey:@"detail"] objectAtIndex:indexPath.row];
        label3.text=[[_arrChildCategoryp2 valueForKey:@"cashback"] objectAtIndex:indexPath.row];
        label4.text=[NSString stringWithFormat:@"₹ %@",[[_arrChildCategoryp2 valueForKey:@"price"] objectAtIndex:indexPath.row]];
        
        
        //        CGSize labelSize = [label1.text sizeWithFont:label1.font constrainedToSize:label1.frame.size lineBreakMode:NSLineBreakByWordWrapping];
        //        CGFloat labelHeight = labelSize.height;
        
        CGRect textRect = [label1.text boundingRectWithSize:label1.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                    context:nil];
        CGSize size = textRect.size;
        CGSize descriptionSize = [label1 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size.height)];
        label1.frame = CGRectMake(10,5, descriptionSize.width, descriptionSize.height);
        
        
        
        CGRect textRect2 = [label2.text boundingRectWithSize:label2.frame.size
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                     context:nil];
        CGSize size2 = textRect2.size;
        CGSize descriptionSize2 = [label2 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size2.height)];
        label2.frame = CGRectMake(10,label1.frame.origin.y+label1.frame.size.height+5, descriptionSize2.width, descriptionSize2.height);
        
        
        
        CGRect textRect3= [label3.text boundingRectWithSize:label3.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                    context:nil];
        CGSize size3 = textRect3.size;
        CGSize descriptionSize3= [label3 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size3.height)];
        label3.frame = CGRectMake(10,label2.frame.origin.y+label2.frame.size.height+5, descriptionSize3.width, descriptionSize3.height);
        
        
        
        
        view1.frame = CGRectMake(0,0, tabl2.frame.size.width, descriptionSize.height+descriptionSize2.height+descriptionSize3.height+20);
        
        
        CGRect textRect4= [label4.text boundingRectWithSize:label4.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                    context:nil];
        CGSize size4 = textRect4.size;
        CGSize descriptionSize4= [label4 sizeThatFits:CGSizeMake(105,size4.height)];
        label4.textAlignment=NSTextAlignmentRight;
        label4.frame = CGRectMake(view1.frame.size.width-110,view1.frame.size.height/2-(size4.height/2), 100, descriptionSize4.height);
        
        UILabel *linelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, view1.frame.size.height)];
        linelabel.backgroundColor=[UIColor darkGrayColor];
        [view1 addSubview:linelabel];


        return view1.frame.size.height+5;
    }
    return UITableViewAutomaticDimension;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
   tableView.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:240.0/255.0f blue:240.0/255.0f alpha:1.0];
    cell.backgroundColor=[UIColor colorWithRed:245.0/255.0f green:240.0/255.0f blue:240.0/255.0f alpha:1.0];
    
    
    if (tableView==tabl)
    {

    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // first row
           // cell.textLabel.text = [NSString stringWithFormat:@"Expandable cell %ld",(long)indexPath.section]; // only top row showing
           // cell.textLabel.text=[arrcategeorys objectAtIndex:indexPath.section];
            
            UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tabl.frame.size.width, 50)];
            view1.backgroundColor=[UIColor whiteColor];
            view1.layer.borderColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f].CGColor;
            view1.layer.borderWidth = 1.0f;
            [cell addSubview:view1];
            
            UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 4, 50)];
//            label1.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0];
             label1.backgroundColor=[UIColor clearColor];
            [cell addSubview:label1];
            
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(7, 0, view1.frame.size.width-40, view1.frame.size.height)];
            label2.text=[arrcategeorys objectAtIndex:indexPath.section];
            [view1 addSubview:label2];
            
            
            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
            }
            else
            {
               cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
            }
        }
        else
        {
            NSArray *arlist=[[[_productsList1 objectAtIndex:indexPath.section] valueForKey:@"child"] valueForKey:@"name"];
            NSArray *arlist2=[[[_productsList1 objectAtIndex:indexPath.section] valueForKey:@"child"] valueForKey:@"price"];
//            cell.textLabel.text = [arlist  objectAtIndex:indexPath.row-1];
//            cell.accessoryView = nil;
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tabl.frame.size.width, 50)];
            view1.backgroundColor=[UIColor whiteColor];
            view1.layer.borderColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f].CGColor;
            view1.layer.borderWidth = 1.0f;
            [cell addSubview:view1];
            
            UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 4, 50)];
            //            label1.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0];
            label1.backgroundColor=[UIColor clearColor];
            [cell addSubview:label1];
            
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, view1.frame.size.width-40, view1.frame.size.height)];
            label2.text=[arlist objectAtIndex:indexPath.row-1];
            [view1 addSubview:label2];
            
            UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(view1.frame.size.width-100, 0, 90, view1.frame.size.height)];
            label3.text=[NSString stringWithFormat:@"₹ %@",[arlist2 objectAtIndex:indexPath.row-1]];
            label3.textAlignment=NSTextAlignmentRight;
            [view1 addSubview:label3];
        }
    }
    else
    {
//        cell.accessoryView = nil;
//        cell.textLabel.text = [arrcategeorys objectAtIndex:indexPath.section];
        
        NSString *arlist2=[[_productsList1 objectAtIndex:indexPath.section] valueForKey:@"price"];
        
    

        UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tabl.frame.size.width, 50)];
        view1.backgroundColor=[UIColor whiteColor];
        view1.layer.borderColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f].CGColor;
        view1.layer.borderWidth = 1.0f;
        [cell addSubview:view1];
        
        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 4, 50)];
        //            label1.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0];
        label1.backgroundColor=[UIColor clearColor];
        [cell addSubview:label1];
        
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, view1.frame.size.width-40, view1.frame.size.height)];
        label2.text=[arrcategeorys objectAtIndex:indexPath.section];
        [view1 addSubview:label2];

        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(view1.frame.size.width-100, 0, 90, view1.frame.size.height)];
        label3.text=[NSString stringWithFormat:@"₹ %@",arlist2];
        label3.textAlignment=NSTextAlignmentRight;
        [view1 addSubview:label3];
        
            }
    }
    else
    {
        UIView *view1=[[UIView alloc]init];
        UILabel *label1=[[UILabel alloc] init];
        UILabel *label2=[[UILabel alloc]init];
        UILabel *label3=[[UILabel alloc]init];
        UILabel *label4=[[UILabel alloc]init];

        view1.backgroundColor=[UIColor whiteColor];
//        view1.layer.borderColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f].CGColor;
//        view1.layer.borderWidth = 2.0f;

    
        label1.textColor=[UIColor blackColor];
        label1.font=[UIFont boldSystemFontOfSize:15];
        label1.numberOfLines=0;
        label1.textAlignment=NSTextAlignmentLeft;
        [label1 setAdjustsFontSizeToFitWidth:YES];
        
        label2.textColor=[UIColor blackColor];
        label2.font=[UIFont systemFontOfSize:15];
        label2.numberOfLines=0;
        label2.textAlignment=NSTextAlignmentLeft;
        [label2 setAdjustsFontSizeToFitWidth:YES];
        
        label3.textColor=[UIColor blueColor];
        label3.font=[UIFont boldSystemFontOfSize:15];
        label3.numberOfLines=0;
        label3.textAlignment=NSTextAlignmentLeft;
        [label3 setAdjustsFontSizeToFitWidth:YES];
        
        label4.textColor=[UIColor blackColor];
        label4.font=[UIFont systemFontOfSize:15];
        label4.numberOfLines=0;
        label4.textAlignment=NSTextAlignmentRight;
        [label4 setAdjustsFontSizeToFitWidth:YES];
        
        view1.backgroundColor=[UIColor whiteColor];
//        view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        view1.layer.borderWidth = 1.0f;
        
        
      
        label1.text=[[_arrChildCategoryp2 valueForKey:@"name"] objectAtIndex:indexPath.row];
        label2.text=[[_arrChildCategoryp2 valueForKey:@"detail"] objectAtIndex:indexPath.row];
        label3.text=[[_arrChildCategoryp2 valueForKey:@"cashback"] objectAtIndex:indexPath.row];
        label4.text=[NSString stringWithFormat:@"₹ %@",[[_arrChildCategoryp2 valueForKey:@"price"] objectAtIndex:indexPath.row]];
        
        
//        CGSize labelSize = [label1.text sizeWithFont:label1.font constrainedToSize:label1.frame.size lineBreakMode:NSLineBreakByWordWrapping];
//        CGFloat labelHeight = labelSize.height;
        
        CGRect textRect = [label1.text boundingRectWithSize:label1.frame.size
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                             context:nil];
        CGSize size = textRect.size;
        CGSize descriptionSize = [label1 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size.height)];
        label1.frame = CGRectMake(10,5, descriptionSize.width, descriptionSize.height);
        
        
        
        CGRect textRect2 = [label2.text boundingRectWithSize:label2.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                    context:nil];
        CGSize size2 = textRect2.size;
        CGSize descriptionSize2 = [label2 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size2.height)];
        label2.frame = CGRectMake(10,label1.frame.origin.y+label1.frame.size.height+5, descriptionSize2.width, descriptionSize2.height);
        
        
        
        CGRect textRect3= [label3.text boundingRectWithSize:label3.frame.size
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                     context:nil];
        CGSize size3 = textRect3.size;
        CGSize descriptionSize3= [label3 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size3.height)];
        label3.frame = CGRectMake(10,label2.frame.origin.y+label2.frame.size.height+5, descriptionSize3.width, descriptionSize3.height);
        
        
        
        
        view1.frame = CGRectMake(0,0, tabl2.frame.size.width, descriptionSize.height+descriptionSize2.height+descriptionSize3.height+20);
        
        
        CGRect textRect4= [label4.text boundingRectWithSize:label4.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                    context:nil];
        CGSize size4 = textRect4.size;
        CGSize descriptionSize4= [label4 sizeThatFits:CGSizeMake(105,size4.height)];
        label4.textAlignment=NSTextAlignmentRight;
        label4.frame = CGRectMake(view1.frame.size.width-110,view1.frame.size.height/2-(size4.height/2), 100, descriptionSize4.height);
        
        UILabel *linelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 4, view1.frame.size.height)];
        //            label1.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0];
        label1.backgroundColor=[UIColor clearColor];
        [view1 addSubview:linelabel];
        
        [cell addSubview:view1];
        [view1 addSubview:label1];
        [view1 addSubview:label2];
        [view1 addSubview:label3];
        [view1 addSubview:label4];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tabl)
    {

    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
               cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
               cell.accessoryView =  [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
                
            }
        }
        else {
            NSLog(@"Selected Section is %ld and subrow is %ld ",(long)indexPath.section ,(long)indexPath.row);
            
        }
    }
    else
    {
       
        
    }
    }
    else
    {
    
    
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//      
//    }
//}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==tabl)
    {
        a=50;
    }
    else
    {
        UIView *view1=[[UIView alloc]init];
        UILabel *label1=[[UILabel alloc] init];
        UILabel *label2=[[UILabel alloc]init];
        UILabel *label3=[[UILabel alloc]init];
        UILabel *label4=[[UILabel alloc]init];
        
        view1.backgroundColor=[UIColor whiteColor];
        view1.layer.borderColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f].CGColor;
        view1.layer.borderWidth = 2.0f;
        
        
        label1.textColor=[UIColor blackColor];
        label1.font=[UIFont boldSystemFontOfSize:15];
        label1.numberOfLines=0;
        label1.textAlignment=NSTextAlignmentLeft;
        [label1 setAdjustsFontSizeToFitWidth:YES];
        
        label2.textColor=[UIColor blackColor];
        label2.font=[UIFont systemFontOfSize:15];
        label2.numberOfLines=0;
        label2.textAlignment=NSTextAlignmentLeft;
        [label2 setAdjustsFontSizeToFitWidth:YES];
        
        label3.textColor=[UIColor blueColor];
        label3.font=[UIFont boldSystemFontOfSize:15];
        label3.numberOfLines=0;
        label3.textAlignment=NSTextAlignmentLeft;
        [label3 setAdjustsFontSizeToFitWidth:YES];
        
        label4.textColor=[UIColor blackColor];
        label4.font=[UIFont systemFontOfSize:15];
        label4.numberOfLines=0;
        label4.textAlignment=NSTextAlignmentRight;
        [label4 setAdjustsFontSizeToFitWidth:YES];
        
        view1.backgroundColor=[UIColor whiteColor];
        view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view1.layer.borderWidth = 1.0f;
        
        
        
        label1.text=[[_arrChildCategoryp2 valueForKey:@"name"] objectAtIndex:indexPath.row];
        label2.text=[[_arrChildCategoryp2 valueForKey:@"detail"] objectAtIndex:indexPath.row];
        label3.text=[[_arrChildCategoryp2 valueForKey:@"cashback"] objectAtIndex:indexPath.row];
        label4.text=[NSString stringWithFormat:@"₹ %@",[[_arrChildCategoryp2 valueForKey:@"price"] objectAtIndex:indexPath.row]];
        
        
        //        CGSize labelSize = [label1.text sizeWithFont:label1.font constrainedToSize:label1.frame.size lineBreakMode:NSLineBreakByWordWrapping];
        //        CGFloat labelHeight = labelSize.height;
        
        CGRect textRect = [label1.text boundingRectWithSize:label1.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                    context:nil];
        CGSize size = textRect.size;
        CGSize descriptionSize = [label1 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size.height)];
        label1.frame = CGRectMake(10,5, descriptionSize.width, descriptionSize.height);
        
        
        
        CGRect textRect2 = [label2.text boundingRectWithSize:label2.frame.size
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                     context:nil];
        CGSize size2 = textRect2.size;
        CGSize descriptionSize2 = [label2 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size2.height)];
        label2.frame = CGRectMake(10,label1.frame.origin.y+label1.frame.size.height+5, descriptionSize2.width, descriptionSize2.height);
        
        
        
        CGRect textRect3= [label3.text boundingRectWithSize:label3.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                    context:nil];
        CGSize size3 = textRect3.size;
        CGSize descriptionSize3= [label3 sizeThatFits:CGSizeMake(tabl2.frame.size.width-110,size3.height)];
        label3.frame = CGRectMake(10,label2.frame.origin.y+label2.frame.size.height+5, descriptionSize3.width, descriptionSize3.height);
        
        
        
        
        view1.frame = CGRectMake(0,0, tabl2.frame.size.width, descriptionSize.height+descriptionSize2.height+descriptionSize3.height+20);
        
        
        CGRect textRect4= [label4.text boundingRectWithSize:label4.frame.size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                    context:nil];
        CGSize size4 = textRect4.size;
        CGSize descriptionSize4= [label4 sizeThatFits:CGSizeMake(105,size4.height)];
        label4.textAlignment=NSTextAlignmentRight;
        label4.frame = CGRectMake(view1.frame.size.width-110,view1.frame.size.height/2-(size4.height/2), 100, descriptionSize4.height);
        
        UILabel *linelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, view1.frame.size.height)];
        linelabel.backgroundColor=[UIColor darkGrayColor];
        [view1 addSubview:linelabel];
        
        
        a = view1.frame.size.height;

    }

    
    
    
    UIView *DeleteView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, a)];
    DeleteView.backgroundColor = [UIColor redColor];
    
    UILabel *DeleteLab=[[UILabel alloc] initWithFrame:CGRectMake(DeleteView.frame.size.width/2-40, DeleteView.frame.size.height/2+2, 80, 20)];
    DeleteLab.text=@"Delete";
    DeleteLab.font =[UIFont systemFontOfSize:15];
    DeleteLab.textColor=[UIColor whiteColor];
    DeleteLab.textAlignment=NSTextAlignmentCenter;
    [DeleteView addSubview:DeleteLab];
    
    UIImageView *DeleteImag=[[UIImageView alloc]initWithFrame:CGRectMake(DeleteView.frame.size.width/2-10, DeleteView.frame.size.height/2-18, 20, 20)];
    DeleteImag.image=[UIImage imageNamed:@"Delete"];
    DeleteImag.contentMode=UIViewContentModeScaleAspectFit;
    [DeleteView addSubview:DeleteImag];
    

    CGSize size = tableView.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [DeleteView.layer renderInContext:context];
    UIImage * imgVw = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"           " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                          [requested showMessage:@"Delete Clicked" withTitle:@"HealthGuruPro"];
                                    }];
    delete.backgroundColor = [UIColor redColor];
    delete.backgroundColor = [UIColor colorWithPatternImage:imgVw];
    
    
    
    
    
    UIView *EditView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, a)];
    EditView.backgroundColor = [UIColor colorWithRed:0.188 green:0.514 blue:0.984 alpha:1];
    
    UILabel *EditLab=[[UILabel alloc] initWithFrame:CGRectMake(DeleteView.frame.size.width/2-40, DeleteView.frame.size.height/2+2, 80, 20)];
    EditLab.text=@"Edit";
    EditLab.font =[UIFont systemFontOfSize:15];
    EditLab.textColor=[UIColor whiteColor];
    EditLab.textAlignment=NSTextAlignmentCenter;
    [EditView addSubview:EditLab];
    
    UIImageView *EditImag=[[UIImageView alloc]initWithFrame:CGRectMake(DeleteView.frame.size.width/2-10, DeleteView.frame.size.height/2-18, 20, 20)];
    EditImag.image=[UIImage imageNamed:@"Edit"];
    EditImag.contentMode=UIViewContentModeScaleAspectFit;
    [EditView addSubview:EditImag];
    
    
    CGSize size2 = tableView.frame.size;
    UIGraphicsBeginImageContextWithOptions(size2, NO, [UIScreen mainScreen].scale);
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    [EditView.layer renderInContext:context2];
    UIImage *EditImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    
    
    
    UITableViewRowAction *more = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"           " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                  {
                                      if (tableView==tabl)
                                      {
                                          [self ListView];
                                          
                                          
                                          if ([self tableView:tableView canCollapseSection:indexPath.section])
                                          {
                                              if (!indexPath.row)
                                              {
                                                   [switchcheck addTarget:self action:@selector(switchIsChanged2:)forControlEvents:UIControlEventValueChanged];
                                                  
                                                  listName.text = [arrcategeorys objectAtIndex:indexPath.section];
                                                  
                                                  listPrice.hidden = true;
                                                  linelabel4.hidden = true;
                                                  listName.userInteractionEnabled = true;
                                                  
                                                  [switchcheck setOn:false];
                                                  switchcheck.userInteractionEnabled = true;
                                              }
                                              else
                                              {
                                                   [switchcheck addTarget:self action:@selector(switchIsChanged4:)forControlEvents:UIControlEventValueChanged];
                                                  
                                                  NSArray *arlist=[[[_productsList1 objectAtIndex:indexPath.section] valueForKey:@"child"] valueForKey:@"name"];
                                                  NSArray *arlist2=[[[_productsList1 objectAtIndex:indexPath.section] valueForKey:@"child"] valueForKey:@"price"];
                                                  
                                                  listName.text = [arrcategeorys objectAtIndex:indexPath.section];
                                                  sublistName.text=[arlist objectAtIndex:indexPath.row-1];
                                                  listPrice.text = [NSString stringWithFormat:@"%@",[arlist2 objectAtIndex:indexPath.row-1]];
                                                  
                                                  sublistName.hidden = NO;
                                                  linelabel3.hidden = NO;
                                                  listPrice.hidden = false;
                                                  linelabel4.hidden = false;
                                                  listName.userInteractionEnabled = false;
                                                  
                                                  [switchcheck setOn:true];
                                                  
                                                  switchcheck.userInteractionEnabled = false;
                                                  
                                              }
                                          }
                                          else
                                          {
                                               [switchcheck addTarget:self action:@selector(switchIsChanged3:)forControlEvents:UIControlEventValueChanged];
                                              
                                              NSString *arlist3=[[_productsList1 objectAtIndex:indexPath.section] valueForKey:@"price"];
                                              
                                              listName.text = [arrcategeorys objectAtIndex:indexPath.section];
                                              listPrice.text=[NSString stringWithFormat:@"%@",arlist3];
                                              
                                              sublistName.hidden = YES;
                                              linelabel3.hidden = YES;
                                              listPrice.hidden = false;
                                              linelabel4.hidden = false;
                                               listName.userInteractionEnabled = true;
                                              
                                              [switchcheck setOn:false];
                                              switchcheck.userInteractionEnabled = true;
                                              
                                          }

                                      }
                                      else
                                      {
                                          [self PackageView];
                                          
                                          
                                          packageName.text=[[_arrChildCategoryp2 valueForKey:@"name"] objectAtIndex:indexPath.row];
                                          packageDesc.text=[[_arrChildCategoryp2 valueForKey:@"detail"] objectAtIndex:indexPath.row];
                                          NSString *str=[[_arrChildCategoryp2 valueForKey:@"cashback"] objectAtIndex:indexPath.row];
                                          packageDiscount.text=[NSString stringWithFormat:@"%@%@",[str substringToIndex:2],@"%"];
                                          packagePrice.text=[NSString stringWithFormat:@"%@",[[_arrChildCategoryp2 valueForKey:@"price"] objectAtIndex:indexPath.row]];
                                          
                                          NSString *strDiscount=[NSString stringWithFormat:@"%@",[str substringToIndex:2]];
                                          float dis = [strDiscount floatValue];
                                          [discountSlider setValue:dis animated:YES];
                                         
                                      }
                                     
                                  }];
    more.backgroundColor = [UIColor colorWithRed:0.188 green:0.514 blue:0.984 alpha:1];
    more.backgroundColor = [UIColor colorWithPatternImage:EditImage];
    
    
    
    
    return @[delete, more];
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}








#pragma mark - List & Packages Clicked

-(IBAction)ListButtonClicked:(id)sender
{
     [self ListView];
}

-(void)ListView
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-190, 300, 380)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Add New Procedure List";
    lab.textColor=[UIColor darkGrayColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    
    
    listName=[[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(15, 60, footerview.frame.size.width-30, 50)];
    listName.placeholder=@"Procedure List Name";
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Procedure List Name" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    listName.attributedPlaceholder = str1;
    listName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    listName.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    listName.font = [UIFont systemFontOfSize:16];
    listName.backgroundColor=[UIColor clearColor];
    listName.delegate=self;
    listName.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:listName];
     listName.userInteractionEnabled = true;
    
    linelabel2=[[UILabel alloc]initWithFrame:CGRectMake(20, listName.frame.size.height+listName.frame.origin.y, footerview.frame.size.width-40, 2)];
    linelabel2.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [footerview addSubview:linelabel2];
    
    
    UILabel *SwitchLab=[[UILabel alloc]initWithFrame:CGRectMake(15, linelabel2.frame.origin.y+linelabel2.frame.size.height+15, footerview.frame.size.width-30, 30)];
    SwitchLab.text=@"Add New Procedure List";
    SwitchLab.textColor=[UIColor darkGrayColor];
    SwitchLab.textAlignment=NSTextAlignmentLeft;
    SwitchLab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:SwitchLab];
    
    
    
    switchcheck=[[UISwitch alloc]initWithFrame:CGRectMake(footerview.frame.size.width-60,linelabel2.frame.origin.y+linelabel2.frame.size.height+15, 30, 30)];
    [switchcheck setOn:NO];
    switchcheck.tintColor = [UIColor colorWithRed:59.0/255.0f green:234.0/255.0f blue:217.0/255.0f alpha:1.0];
    switchcheck.onTintColor =[UIColor colorWithRed:59.0/255.0f green:234.0/255.0f blue:217.0/255.0f alpha:1.0];
    [switchcheck addTarget:self action:@selector(switchIsChanged:)forControlEvents:UIControlEventValueChanged];
    switchcheck.userInteractionEnabled = true;
    [footerview addSubview:switchcheck];
    
    
    
    
    sublistName=[[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(15, SwitchLab.frame.origin.y+SwitchLab.frame.size.height+10, footerview.frame.size.width-30, 50)];
    sublistName.placeholder=@"Sub Listing";
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Sub Listing" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    sublistName.attributedPlaceholder = str2;
    sublistName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    sublistName.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    sublistName.font = [UIFont systemFontOfSize:16];
    sublistName.backgroundColor=[UIColor clearColor];
    sublistName.delegate=self;
    sublistName.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:sublistName];
    
    linelabel3=[[UILabel alloc]initWithFrame:CGRectMake(20, sublistName.frame.size.height+sublistName.frame.origin.y, footerview.frame.size.width-40, 2)];
    linelabel3.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [footerview addSubview:linelabel3];
    
    sublistName.hidden = YES;
    linelabel3.hidden = YES;
    
    
    listPrice=[[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(15, linelabel3.frame.origin.y+linelabel3.frame.size.height+10, footerview.frame.size.width-30, 50)];
    listPrice.placeholder=@"Price";
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    listPrice.attributedPlaceholder = str3;
    listPrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    listPrice.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    listPrice.font = [UIFont systemFontOfSize:16];
    listPrice.backgroundColor=[UIColor clearColor];
    listPrice.delegate=self;
    [listPrice setKeyboardType:UIKeyboardTypeNumberPad];
    listPrice.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:listPrice];
    
    linelabel4=[[UILabel alloc]initWithFrame:CGRectMake(20, listPrice.frame.size.height+listPrice.frame.origin.y, footerview.frame.size.width-40, 2)];
    linelabel4.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [footerview addSubview:linelabel4];
    
    listPrice.hidden = false;
    linelabel4.hidden = false;
    
    UIButton *SubmitButton=[[UIButton alloc] initWithFrame:CGRectMake(20, linelabel4.frame.size.height+linelabel4.frame.origin.y+30, footerview.frame.size.width-40, 40)];
    SubmitButton.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    SubmitButton.layer.cornerRadius = 20;
    SubmitButton.clipsToBounds = YES;
    [SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    SubmitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    SubmitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [SubmitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SubmitButton addTarget:self action:@selector(SubmitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:SubmitButton];
    
}


- (void) switchIsChanged:(UISwitch *)paramSender
{
    if ([paramSender isOn])
    {
        sublistName.hidden = NO;
        linelabel3.hidden = NO;
        listPrice.hidden = false;
        linelabel4.hidden = false;
    }
    else
    {
        sublistName.hidden = YES;
        linelabel3.hidden = YES;
    }
}

- (void) switchIsChanged2:(UISwitch *)paramSender
{
    if ([paramSender isOn])
    {
        sublistName.hidden = NO;
        linelabel3.hidden = NO;
        listPrice.hidden = false;
        linelabel4.hidden = false;
        listName.userInteractionEnabled = true;
    }
    else
    {
        sublistName.hidden = YES;
        linelabel3.hidden = YES;
        listPrice.hidden = true;
        linelabel4.hidden = true;
        listName.userInteractionEnabled = true;
    }
}

- (void) switchIsChanged3:(UISwitch *)paramSender
{
    if ([paramSender isOn])
    {
        sublistName.hidden = NO;
        linelabel3.hidden = NO;
        listPrice.hidden = false;
        linelabel4.hidden = false;
         listName.userInteractionEnabled = true;
    }
    else
    {
        sublistName.hidden = YES;
        linelabel3.hidden = YES;
         listName.userInteractionEnabled = true;
    }
}

- (void) switchIsChanged4:(UISwitch *)paramSender
{
    if ([paramSender isOn])
    {
        sublistName.hidden = NO;
        linelabel3.hidden = NO;
        listPrice.hidden = false;
        linelabel4.hidden = false;
        listName.userInteractionEnabled = false;
    }
    else
    {
        sublistName.hidden = YES;
        linelabel3.hidden = YES;
        listName.userInteractionEnabled = false;
    }
}



#pragma mark - NextButton Clicked

-(IBAction)SubmitButtonClicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}



-(IBAction)PackageButtonClicked:(id)sender
{
    [self PackageView];

}

-(void)PackageView
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-220, 300, 440)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Add New Procedure Packages";
    lab.textColor=[UIColor darkGrayColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    
    
    packageName=[[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(15, 60, footerview.frame.size.width-30, 50)];
    packageName.placeholder=@"Package Name";
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Package Name" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    packageName.attributedPlaceholder = str1;
    packageName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    packageName.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    packageName.font = [UIFont systemFontOfSize:16];
    packageName.backgroundColor=[UIColor clearColor];
    packageName.delegate=self;
    packageName.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:packageName];
    
    linelabel2=[[UILabel alloc]initWithFrame:CGRectMake(20, packageName.frame.size.height+packageName.frame.origin.y, footerview.frame.size.width-40, 2)];
    linelabel2.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [footerview addSubview:linelabel2];
    
    
    UILabel *DetailLab=[[UILabel alloc]initWithFrame:CGRectMake(20, linelabel2.frame.origin.y+linelabel2.frame.size.height+15, footerview.frame.size.width-40, 20)];
    DetailLab.text=@"Package Detail";
    DetailLab.textColor=[UIColor darkGrayColor];
    DetailLab.textAlignment=NSTextAlignmentLeft;
    DetailLab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:DetailLab];
    
    
    
    packageDesc = [[UITextView alloc]initWithFrame:CGRectMake(15, DetailLab.frame.size.height+DetailLab.frame.origin.y+5, footerview.frame.size.width-30, 50)];
    packageDesc.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [footerview addSubview:packageDesc];
    
    
    linelabel3=[[UILabel alloc]initWithFrame:CGRectMake(20, packageDesc.frame.size.height+packageDesc.frame.origin.y, footerview.frame.size.width-40, 2)];
    linelabel3.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [footerview addSubview:linelabel3];
    
    
    
    packagePrice=[[UIFloatLabelTextField alloc]initWithFrame:CGRectMake(15, packageDesc.frame.origin.y+packageDesc.frame.size.height+15, footerview.frame.size.width-30, 50)];
    packagePrice.placeholder=@"Package Price";
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Package Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    packagePrice.attributedPlaceholder = str2;
    packagePrice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    packagePrice.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    packagePrice.font = [UIFont systemFontOfSize:16];
    packagePrice.backgroundColor=[UIColor clearColor];
    packagePrice.delegate=self;
    [packagePrice setKeyboardType:UIKeyboardTypeNumberPad];
    packagePrice.returnKeyType = UIReturnKeyNext;
    [footerview addSubview:packagePrice];
    
    linelabel4=[[UILabel alloc]initWithFrame:CGRectMake(20, packagePrice.frame.size.height+packagePrice.frame.origin.y, footerview.frame.size.width-40, 2)];
    linelabel4.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    [footerview addSubview:linelabel4];
    
    
    
    UILabel *DiscountLab=[[UILabel alloc]initWithFrame:CGRectMake(20, linelabel4.frame.origin.y+linelabel4.frame.size.height+20, footerview.frame.size.width-40, 20)];
    DiscountLab.text=@"Package Discount";
    DiscountLab.textColor=[UIColor darkGrayColor];
    DiscountLab.textAlignment=NSTextAlignmentLeft;
    DiscountLab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:DiscountLab];
    
    packageDiscount =[[UILabel alloc]initWithFrame:CGRectMake(footerview.frame.size.width-80, linelabel4.frame.origin.y+linelabel4.frame.size.height+20, 60, 15)];
    packageDiscount.textColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    packageDiscount.textAlignment=NSTextAlignmentRight;
    packageDiscount.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:packageDiscount];
    
    
    discountSlider = [[UISlider alloc]initWithFrame:CGRectMake(20, DiscountLab.frame.size.height+DiscountLab.frame.origin.y+15, footerview.frame.size.width-40, 30)];
    discountSlider.maximumValue = 0;
    discountSlider.maximumValue = 100;
    discountSlider.continuous = YES;
    [discountSlider addTarget:self action:@selector(SliderIsChanged:)forControlEvents:UIControlEventValueChanged];
    [footerview addSubview:discountSlider];
    
    
    
    
    UIButton *SubmitButton=[[UIButton alloc] initWithFrame:CGRectMake(20, discountSlider.frame.size.height+discountSlider.frame.origin.y+30, footerview.frame.size.width-40, 40)];
    SubmitButton.backgroundColor=[UIColor colorWithRed:37.0/255.0f green:53.0/255.0f blue:236.0/255.0f alpha:1.0];
    SubmitButton.layer.cornerRadius = 20;
    SubmitButton.clipsToBounds = YES;
    [SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    SubmitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    SubmitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [SubmitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SubmitButton addTarget:self action:@selector(SubmitButtonClicked2:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:SubmitButton];
}


#pragma mark - NextButton Clicked

-(IBAction)SubmitButtonClicked2:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
}



- (IBAction)SliderIsChanged:(id)sender
{
    UISlider *MYslider = (UISlider *)sender;
    int SliderValue = (int)roundf(MYslider.value);
    packageDiscount.text = [NSString stringWithFormat:@"%d%@", SliderValue,@"%"];
}


#pragma mark - NotificationButton Clicked

-(IBAction)NotificationButtonClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    tbc.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:tbc animated:YES];
}




#pragma mark - Back Clicked

-(IBAction)BackButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == listName)
    {
        if ([listName.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Procedure List Name" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            listName.attributedPlaceholder = str1;
        }
    }
    else if (textField == sublistName)
    {
        if ([sublistName.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Sub Listing" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            sublistName.attributedPlaceholder = str1;
        }
    }
    else if (textField == listPrice)
    {
        if ([listPrice.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            listPrice.attributedPlaceholder = str1;
        }
    }
    else if (textField == packageName)
    {
        if ([packageName.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            packageName.attributedPlaceholder = str1;
        }
    }
    else if (textField == packagePrice)
    {
        if ([packagePrice.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            packagePrice.attributedPlaceholder = str1;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == listName)
    {
        if ([listName.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Procedure List Name" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            listName.attributedPlaceholder = str1;
        }
    }
    else if (textField == sublistName)
    {
        if ([sublistName.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Sub Listing" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            sublistName.attributedPlaceholder = str1;
        }
    }
    else if (textField == listPrice)
    {
        if ([listPrice.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            listPrice.attributedPlaceholder = str1;
        }
    }
    else if (textField == packageName)
    {
        if ([packageName.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            packageName.attributedPlaceholder = str1;
        }
    }
    else if (textField == packagePrice)
    {
        if ([packagePrice.text isEqual:@""])
        {
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
            packagePrice.attributedPlaceholder = str1;
        }
    }
}





#pragma mark - Warrings

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
