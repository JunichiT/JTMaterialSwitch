//
//  DemoViewController.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "DemoViewController.h"
#import "DefaultStyleCell.h"
#import "LightStyleCell.h"
#import "DarkStyleCell.h"
#import "CustomizedStyleCell.h"
#import "SizeBehaviorsCell.h"
#import "BounceBehaviorsCell.h"
#import "RippleBehaviorsCell.h"
#import "EnabledBehaviorsCell.h"

@interface DemoViewController () {
  NSArray *sectionList;
  NSDictionary *dataSource;
}

@end

@implementation DemoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[DefaultStyleCell class] forCellReuseIdentifier:@"Default"];
  [self.tableView registerClass:[LightStyleCell class] forCellReuseIdentifier:@"Light"];
  [self.tableView registerClass:[DarkStyleCell class] forCellReuseIdentifier:@"Dark"];
  [self.tableView registerClass:[CustomizedStyleCell class] forCellReuseIdentifier:@"CustomizedStyle"];
  [self.tableView registerClass:[SizeBehaviorsCell class] forCellReuseIdentifier:@"Size"];
  [self.tableView registerClass:[BounceBehaviorsCell class] forCellReuseIdentifier:@"Bounce"];
  [self.tableView registerClass:[RippleBehaviorsCell class] forCellReuseIdentifier:@"Ripple"];
  [self.tableView registerClass:[EnabledBehaviorsCell class] forCellReuseIdentifier:@"Enabled"];
  
  
  // セクション名を設定する
  sectionList =  [NSArray arrayWithObjects: @"Style", @"Size", @"Bounce", @"Ripple Effect", @"Enabled", nil];
  
  // セルの項目を作成する
  NSArray *styles = [[NSArray alloc]initWithObjects: @"Default", @"Light", @"Dark", @"CustomizedStyle", nil];
  NSArray *sizes = [[NSArray alloc]initWithObjects: @"Size", nil];
  NSArray *bounce = [[NSArray alloc]initWithObjects: @"Bounce", nil];
  NSArray *ripple = [[NSArray alloc]initWithObjects: @"Ripple", nil];
  NSArray *enabled = [[NSArray alloc]initWithObjects: @"Enabled", nil];
  
  // セルの項目をまとめる
  NSArray *datas = [NSArray arrayWithObjects: styles, sizes, bounce, ripple, enabled, nil];
  dataSource = [NSDictionary dictionaryWithObjects:datas forKeys:sectionList];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [sectionList count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return [sectionList objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSString *sectionName = [sectionList objectAtIndex:section];
  return [[dataSource objectForKey:sectionName ]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  // Get section name
  NSString *sectionName = [sectionList objectAtIndex:indexPath.section];
  // Get section items
  NSArray *items = [dataSource objectForKey:sectionName];
  
  NSString *cellIdentifier = [items objectAtIndex:indexPath.row];
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  // セルが作成されていないか?
  if (!cell) { // yes
    // セルを作成
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  // Set text to the cell
  //  cell.textLabel.text = [items objectAtIndex:indexPath.row];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 90.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
