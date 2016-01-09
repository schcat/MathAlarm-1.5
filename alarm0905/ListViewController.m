//
//  ListViewController.m
//  alarm0905
//
//  Created by Zhixue Li on 9/7/15.
//  Copyright (c) 2015 Zhixue Li. All rights reserved.
//

#import "ListViewController.h"
#import "AlarmViewController.h"
#import "SetViewController.h"
#import "AlarmItemStore.h"
#import "AlarmItem.h"
@import UIKit;

@interface ListViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ListViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Alarm";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
//    NSLog(@"ok!");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[AlarmItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
    [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                           reuseIdentifier:@"UITableViewCell"];
    NSArray *items = [[AlarmItemStore sharedStore] allItems];
    AlarmItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    
    UIFont *newFont = [UIFont systemFontOfSize:16];
    cell.textLabel.font = newFont;
    
    UIImage *alarmimage = [UIImage imageNamed:@"alarm.png"];
    cell.imageView.image = alarmimage;
    NSString *str;
    if (item.OnOrOff) {
        str = @"On";
    }else{
        str = @"Off";
    }
    cell.detailTextLabel.text = str;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetViewController *setViewController = [[SetViewController alloc] init];
    
    NSArray *items = [[AlarmItemStore sharedStore] allItems];
    AlarmItem *selectedItem = items[indexPath.row];
    
    setViewController.item = selectedItem;
    
    [self.navigationController pushViewController:setViewController
                                         animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[AlarmItemStore sharedStore] allItems];
        AlarmItem *item = items[indexPath.row];
        [[AlarmItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)addNewItem:(id)sender
{
    
    AlarmItem *newItem = [[AlarmItemStore sharedStore] createItem];
    NSInteger lastRow = [[[AlarmItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
    SetViewController *setViewController = [[SetViewController alloc] init];
    
    NSArray *items = [[AlarmItemStore sharedStore] allItems];
    AlarmItem *selectedItem = items[indexPath.row];
    
    setViewController.item = selectedItem;
    
    [self.navigationController pushViewController:setViewController
                                         animated:YES];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
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
