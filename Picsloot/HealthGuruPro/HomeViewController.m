//
//  HomeViewController.m
//  HealthGuruPro
//
//  Created by think360 on 08/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import "HomeViewController.h"
#import "SchedulelistCell.h"

@interface HomeViewController ()
{
    NSString *strdayid,*str2moroid;
    NSIndexPath *index;
    int count,Compile;
    NSIndexPath *index2;
    
    int day,Time,serverday;
    NSMutableArray *arrDates,*arrMonths,*arrWeeks,*arrMonthsName,*arrYear,*arrWeekDay;
    NSMutableArray *DateArray,*Compilearray,*Compilearray2,*WeekCompilearray,*WeekCompilearray2;
    
    NSMutableArray *Morninglistarray,*EveninglistArray;
    
    SchedulelistCell *cell;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    day=0;
    count=1;
    Compile=1;
    
    DateArray=[[NSMutableArray alloc]init];
    Compilearray=[[NSMutableArray alloc]init];
    Compilearray2=[[NSMutableArray alloc]init];
    arrDates=[[NSMutableArray alloc]init];
    arrMonths=[[NSMutableArray alloc]init];
    arrMonthsName=[[NSMutableArray alloc]init];
    arrYear=[[NSMutableArray alloc]init];
    arrWeekDay=[[NSMutableArray alloc]init];
    WeekCompilearray=[[NSMutableArray alloc]init];
    WeekCompilearray2=[[NSMutableArray alloc]init];
    arrWeeks=[[NSMutableArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday",@"Monday",@"Tueday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    
    [self CalenderView];
    
    Morninglistarray=[[NSMutableArray alloc]init];
    EveninglistArray=[[NSMutableArray alloc]init];
    
    
    _DateLab.text=[Compilearray2 objectAtIndex:0];
    _weekdayLab.text=[WeekCompilearray2 objectAtIndex:0];
    
    _leftDateButt.hidden=YES;
    _RightDateButt.hidden=NO;
    
    _scheduleTabl.tag = 1;
    _tablheightConstraint.constant = (3) * (49);
}

#pragma mark - Notification Butt Clicked

- (IBAction)NotificationButtClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    tbc.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:tbc animated:YES];
}

#pragma mark - Approval Pending Butt Clicked

- (IBAction)ApprovelPendingButtClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"AppointmentRequestViewController"];
    tbc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:tbc animated:YES];
}

#pragma mark - left and right date clicked

- (IBAction)leftDatebuttClicked:(id)sender
{
    if (day==0)
    {
        _leftDateButt.hidden=YES;
        _RightDateButt.hidden=NO;
        
        _DateLab.text=[Compilearray2 objectAtIndex:day];
        _weekdayLab.text=[WeekCompilearray2 objectAtIndex:day];
        day++;
    }
    else
    {
         day--;
        if (day==0)
        {
            _leftDateButt.hidden=YES;
            _RightDateButt.hidden=NO;
        }
        else
        {
            _leftDateButt.hidden=NO;
            _RightDateButt.hidden=NO;
        }
        _DateLab.text=[Compilearray2 objectAtIndex:day];
         _weekdayLab.text=[WeekCompilearray2 objectAtIndex:day];
    }
}
- (IBAction)RightDateButtClicked:(id)sender
{
    if (day==serverday)
    {
        _leftDateButt.hidden=NO;
        _RightDateButt.hidden=YES;
        _DateLab.text=[Compilearray2 objectAtIndex:day];
         _weekdayLab.text=[WeekCompilearray2 objectAtIndex:day];
        day--;
    }
    else
    {
         day++;
        if (day==serverday)
        {
            _leftDateButt.hidden=NO;
            _RightDateButt.hidden=YES;
        }
        else
        {
            _leftDateButt.hidden=NO;
            _RightDateButt.hidden=NO;
        }
        _DateLab.text=[Compilearray2 objectAtIndex:day];
         _weekdayLab.text=[WeekCompilearray2 objectAtIndex:day];
    }
}

#pragma mark - Segment changed

- (IBAction)segmentValueChanged:(id)sender
{
    if(_segmentSchedule.selectedSegmentIndex == 0)
    {
        _scheduleTabl.tag = 1;
        _tablheightConstraint.constant = (3) * (49);
        [_scheduleTabl reloadData];
    }
    else if(_segmentSchedule.selectedSegmentIndex == 1)
    {
        _scheduleTabl.tag = 2;
        _tablheightConstraint.constant = (5) * (49);
        [_scheduleTabl reloadData];
    }
}



#pragma mark - Tableview delegate methodes

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1)
    {
        return 3;
        // return MorninglistArray.count
    }
    else
    {
        return 5;
        // return EveninglistArray.count
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellClassName = @"SchedulelistCell";
    
    cell = (SchedulelistCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[SchedulelistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SchedulelistCell"
                                                     owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor=[UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(tableView.tag == 1)
    {
        cell.timeLab.text = @"10.00 am - 12.00 am";
        cell.countLab.text = @"6";
    }
    else
    {
        cell.timeLab.text = @"4.00 pm - 6.00 pm";
        cell.countLab.text = @"6";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strday=[NSString stringWithFormat:@"%@, %@",_weekdayLab.text,_DateLab.text];
    [[NSUserDefaults standardUserDefaults]setObject:strday forKey:@"Weekday"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"AppointSpecificViewController"];
    tbc.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:tbc animated:YES];
}

#pragma mark - Add Patint Clicked

- (IBAction)AddPatientsbuttClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewPatientViewController"];
    tbc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:tbc animated:YES];
}

#pragma mark - Add Appointment Clicked

- (IBAction)AddAppointmentsClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewPatientViewController"];
    tbc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:tbc animated:YES];
}

#pragma mark - Lab Near By You Clicked

- (IBAction)labNearByClicked:(id)sender
{
    UIViewController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"LabsViewController"];
    tbc.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:tbc animated:YES];
}





#pragma mark - CalenderView

-(void)CalenderView
{
    NSDate *today = [NSDate dateWithTimeInterval:(24*0*0) sinceDate:[NSDate date]];
    NSString *dateSt = [NSString stringWithFormat:@"%@",today];
    NSArray *components = [dateSt componentsSeparatedByString:@" "];
    NSString *dat = components[0];
    NSArray *todate=[dat componentsSeparatedByString:@"-"];
    strdayid = [NSString stringWithFormat:@"%@", [todate objectAtIndex:2]];
   // NSLog(@"today: %@",strdayid);
    
    
    
    NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];
    NSString *dateString = [NSString stringWithFormat:@"%@",tomorrow];
    NSArray *components2 = [dateString componentsSeparatedByString:@" "];
    NSString *date2 = components2[0];
    NSArray *todaydate=[date2 componentsSeparatedByString:@"-"];
    str2moroid = [NSString stringWithFormat:@"%@", [todaydate objectAtIndex:2]];
   // NSLog(@"tomorrow day: %@",str2moroid);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
   // NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    
    
    NSArray * allDatesOfThisWeek = [self daysThisWeek];
    NSArray * allDatesOfNextWeek = [self daysNextWeek];
    //NSLog(@"%@",allDatesOfThisWeek);
    // NSLog(@"%@",allDatesOfNextWeek);
    
    NSArray * allDatesOfNextToNextWeek = [self daysInWeek:2 fromDate:[NSDate date]];
    // NSLog(@"%@",allDatesOfNextToNextWeek);
    
    
    
    for (int i=0; i<allDatesOfThisWeek.count; i++)
    {
        NSString *dateString = [NSString stringWithFormat:@"%@",[allDatesOfThisWeek objectAtIndex:i]];
        NSArray *components = [dateString componentsSeparatedByString:@" "];
        NSString *date = components[0];
        NSArray *todaydate=[date componentsSeparatedByString:@"-"];
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        [arr addObject:[todaydate objectAtIndex:1]];
        arrMonths=[[arrMonths arrayByAddingObjectsFromArray:arr] mutableCopy];
        
        NSMutableArray *arr2=[[NSMutableArray alloc]init];
        [arr2 addObject:[todaydate objectAtIndex:2]];
        arrDates=[[arrDates arrayByAddingObjectsFromArray:arr2] mutableCopy];
        
        NSMutableArray *arr3=[[NSMutableArray alloc]init];
        [arr3 addObject:[todaydate objectAtIndex:0]];
        arrYear=[[arrYear arrayByAddingObjectsFromArray:arr3] mutableCopy];
    }
    
    for (int i=0; i<allDatesOfNextWeek.count; i++)
    {
        NSString *dateString = [NSString stringWithFormat:@"%@",[allDatesOfNextWeek objectAtIndex:i]];
        NSArray *components = [dateString componentsSeparatedByString:@" "];
        NSString *date = components[0];
        NSArray *todaydate=[date componentsSeparatedByString:@"-"];
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        [arr addObject:[todaydate objectAtIndex:1]];
        arrMonths=[[arrMonths arrayByAddingObjectsFromArray:arr] mutableCopy];
        
        NSMutableArray *arr2=[[NSMutableArray alloc]init];
        [arr2 addObject:[todaydate objectAtIndex:2]];
        arrDates=[[arrDates arrayByAddingObjectsFromArray:arr2] mutableCopy];
        
        NSMutableArray *arr3=[[NSMutableArray alloc]init];
        [arr3 addObject:[todaydate objectAtIndex:0]];
        arrYear=[[arrYear arrayByAddingObjectsFromArray:arr3] mutableCopy];
    }
    
    for (int i=0; i<allDatesOfNextToNextWeek.count; i++)
    {
        NSString *dateString = [NSString stringWithFormat:@"%@",[allDatesOfNextToNextWeek objectAtIndex:i]];
        NSArray *components = [dateString componentsSeparatedByString:@" "];
        NSString *date = components[0];
        NSArray *todaydate=[date componentsSeparatedByString:@"-"];
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        [arr addObject:[todaydate objectAtIndex:1]];
        arrMonths=[[arrMonths arrayByAddingObjectsFromArray:arr] mutableCopy];
        
        NSMutableArray *arr2=[[NSMutableArray alloc]init];
        [arr2 addObject:[todaydate objectAtIndex:2]];
        arrDates=[[arrDates arrayByAddingObjectsFromArray:arr2] mutableCopy];
        
        NSMutableArray *arr3=[[NSMutableArray alloc]init];
        [arr3 addObject:[todaydate objectAtIndex:0]];
        arrYear=[[arrYear arrayByAddingObjectsFromArray:arr3] mutableCopy];
    }
    for (int i=0; i<arrMonths.count; i++)
    {
        NSString *strid=[NSString stringWithFormat:@"%@",[arrMonths objectAtIndex:i]];
        
        if ([strid isEqualToString:@"01"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Jan", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"02"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Feb", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"03"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Mar", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"04"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Apr", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"05"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"May", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"06"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Jun", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"07"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Jul", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"08"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Aug", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"09"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Sep", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"10"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Oct", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"11"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Nov", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
        else if ([strid isEqualToString:@"12"])
        {
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:@"Dec", nil];
            arrMonthsName=[[arrMonthsName arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
    }
    
    
    int indexValue = (int)[arrDates indexOfObject:strdayid];
   // NSLog(@"%d",indexValue);
    
    for (int k=indexValue; k<indexValue+15; k++)
    {
        NSString *strformat=[NSString stringWithFormat:@"%@ %@ %@",[arrDates objectAtIndex:k],[arrMonthsName objectAtIndex:k],[arrYear objectAtIndex:k]];
        
        NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat, nil];
        Compilearray=[[Compilearray arrayByAddingObjectsFromArray:arr2] mutableCopy];
        
        NSString *strWeekDay=[NSString stringWithFormat:@"%@",[arrWeeks objectAtIndex:k]];
        NSMutableArray *arr3=[[NSMutableArray alloc]initWithObjects:strWeekDay, nil];
        WeekCompilearray=[[WeekCompilearray arrayByAddingObjectsFromArray:arr3] mutableCopy];
    }
    
   // NSLog(@"%@",Compilearray);

    
    for (int k=indexValue; k<indexValue+15; k++)
    {
        if (count==1)
        {
            NSString *strformat=[NSString stringWithFormat:@"%@ %@ %@",[arrDates objectAtIndex:k],[arrMonthsName objectAtIndex:k],[arrYear objectAtIndex:k]];
            count=2;
            
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat, nil];
            Compilearray2=[[Compilearray2 arrayByAddingObjectsFromArray:arr2] mutableCopy];
            
            
            NSString *strWeekDay=[NSString stringWithFormat:@"Today"];
            NSMutableArray *arr3=[[NSMutableArray alloc]initWithObjects:strWeekDay, nil];
            WeekCompilearray2=[[WeekCompilearray2 arrayByAddingObjectsFromArray:arr3] mutableCopy];
        }
        else if (count==2)
        {
            NSString *strformat=[NSString stringWithFormat:@"%@ %@ %@",[arrDates objectAtIndex:k],[arrMonthsName objectAtIndex:k],[arrYear objectAtIndex:k]];
            count=3;
            
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat, nil];
            Compilearray2=[[Compilearray2 arrayByAddingObjectsFromArray:arr2] mutableCopy];
            
            NSString *strWeekDay=[NSString stringWithFormat:@"Tomorrow"];
            NSMutableArray *arr3=[[NSMutableArray alloc]initWithObjects:strWeekDay, nil];
            WeekCompilearray2=[[WeekCompilearray2 arrayByAddingObjectsFromArray:arr3] mutableCopy];
        }
        else
        {
            NSString *strformat=[NSString stringWithFormat:@"%@ %@ %@",[arrDates objectAtIndex:k],[arrMonthsName objectAtIndex:k],[arrYear objectAtIndex:k]];
            
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat, nil];
            Compilearray2=[[Compilearray2 arrayByAddingObjectsFromArray:arr2] mutableCopy];
            
            NSString *strWeekDay=[NSString stringWithFormat:@"%@",[arrWeeks objectAtIndex:k]];
            NSMutableArray *arr3=[[NSMutableArray alloc]initWithObjects:strWeekDay, nil];
            WeekCompilearray2=[[WeekCompilearray2 arrayByAddingObjectsFromArray:arr3] mutableCopy];
        }
        
    }
    
   // NSLog(@"%@",Compilearray2);
    
    
    
    for (int k=0; k<Compilearray.count; k++)
    {
        if (Compile==1)
        {
            NSString *strformat=[NSString stringWithFormat:@"%@",[Compilearray objectAtIndex:k]];
            NSArray *arrcompo=[strformat componentsSeparatedByString:@" "];
            NSString *date = [NSString stringWithFormat:@"%@", arrcompo[1]];
            if ([strdayid isEqualToString:date])
            {
                NSString *strformat2=[NSString stringWithFormat:@"%@",[Compilearray2 objectAtIndex:k]];
                NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat2, nil];
                DateArray=[[DateArray arrayByAddingObjectsFromArray:arr2] mutableCopy];
            }
            else
            {
                Compile=2;
                NSString *strformat=[NSString stringWithFormat:@"%@",[Compilearray objectAtIndex:k]];
                NSArray *arrcompo=[strformat componentsSeparatedByString:@" "];
                NSString *date = [NSString stringWithFormat:@"%@", arrcompo[1]];
                if ([str2moroid isEqualToString:date])
                {
                    NSString *strformat2=[NSString stringWithFormat:@"%@",[Compilearray2 objectAtIndex:k+1]];
                    NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat2, nil];
                    DateArray=[[DateArray arrayByAddingObjectsFromArray:arr2] mutableCopy];
                }
                else
                {
                    NSString *strformat3=[NSString stringWithFormat:@"%@",[Compilearray objectAtIndex:k]];
                    NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat3, nil];
                    DateArray=[[DateArray arrayByAddingObjectsFromArray:arr2] mutableCopy];
                }
                
            }
        }
        else if (Compile==2)
        {
            NSString *strformat=[NSString stringWithFormat:@"%@",[Compilearray objectAtIndex:k]];
            NSArray *arrcompo=[strformat componentsSeparatedByString:@" "];
            NSString *date = [NSString stringWithFormat:@"%@", arrcompo[1]];
            if ([str2moroid isEqualToString:date])
            {
                NSString *strformat2=[NSString stringWithFormat:@"%@",[Compilearray2 objectAtIndex:k]];
                NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat2, nil];
                DateArray=[[DateArray arrayByAddingObjectsFromArray:arr2] mutableCopy];
            }
            else
            {
                NSString *strformat3=[NSString stringWithFormat:@"%@",[Compilearray objectAtIndex:k]];
                NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat3, nil];
                DateArray=[[DateArray arrayByAddingObjectsFromArray:arr2] mutableCopy];
            }
            
            Compile=3;
        }
        else
        {
            NSString *strformat3=[NSString stringWithFormat:@"%@",[Compilearray objectAtIndex:k]];
            NSMutableArray *arr2=[[NSMutableArray alloc]initWithObjects:strformat3, nil];
            DateArray=[[DateArray arrayByAddingObjectsFromArray:arr2] mutableCopy];
        }
    }
    
   // NSLog(@"%@",DateArray);
    
    serverday=(int)Compilearray2.count-1;
    
}

-(NSArray*)daysThisWeek
{
    return  [self daysInWeek:0 fromDate:[NSDate date]];
}

-(NSArray*)daysNextWeek
{
    return  [self daysInWeek:1 fromDate:[NSDate date]];
}
-(NSArray*)daysInWeek:(int)weekOffset fromDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //ask for current week
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps=[calendar components:NSWeekCalendarUnit|NSCalendarUnitYear fromDate:date];
    //create date on week start
    NSDate* weekstart=[calendar dateFromComponents:comps];
    
    NSDateComponents* moveWeeks=[[NSDateComponents alloc] init];
    moveWeeks.weekOfYear=weekOffset;
    weekstart=[calendar dateByAddingComponents:moveWeeks toDate:weekstart options:0];
    
    
    //add 7 days
    NSMutableArray* week=[NSMutableArray arrayWithCapacity:7];
    for (int i=1; i<=7; i++) {
        NSDateComponents *compsToAdd = [[NSDateComponents alloc] init];
        compsToAdd.day=i;
        NSDate *nextDate = [calendar dateByAddingComponents:compsToAdd toDate:weekstart options:0];
        [week addObject:nextDate];
        
    }
    return [NSArray arrayWithArray:week];
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
