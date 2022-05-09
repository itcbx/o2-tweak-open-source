//
//  HBPFavoritesExtensionSettingsController.m
//  HomeButtonPlus
//
//  Created by Will Smillie on 11/12/18.
//

#import "QSFavoritesPickerController.h"

#define kPrefs_Path @"/var/mobile/Library/Preferences/xc.lzsxcl.o2.Split.plist"//添加了app尝试把他弄到新的文件
#define kPrefs_KeyName_Key @"key"
#define kPrefs_KeyName_Defaults @"defaults"

@interface SBApplication : NSObject

@end


@interface QSFavoritesPickerController (){
    NSMutableDictionary *settings;
    ALApplicationList *applications;
    NSMutableArray *enabledApps;
    NSMutableArray *disabledApps;
}

@end

@implementation QSFavoritesPickerController
@synthesize allApps;

-(instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"选择喜爱的应用";
    
    [self.tableView setEditing:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    allApps = [[NSMutableArray alloc] init];
    enabledApps = [[NSMutableArray alloc] init];
    disabledApps = [[NSMutableArray alloc] init];
    
    NSMutableArray *a = [[NSMutableArray alloc] init];

    applications = [ALApplicationList sharedApplicationList];
    [applications applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"(isSystemApplication = true) OR (isSystemApplication = false)"] onlyVisible:true titleSortedIdentifiers:&a];
    allApps = a;
    
    settings = (NSMutableDictionary*)[self initDictionaryWithFile:kPrefs_Path asMutable:YES];

    enabledApps = [settings[@"favorites"] mutableCopy];//
    disabledApps = [allApps mutableCopy];
    [disabledApps removeObjectsInArray:enabledApps];//移除阵列中的对象？
}


//菜单操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *sourceArray = (sourceIndexPath.section == 0)?enabledApps:disabledApps;
    NSMutableArray *destinationArray = (destinationIndexPath.section == 0)?enabledApps:disabledApps;
    
    NSString *element = [[sourceArray objectAtIndex:sourceIndexPath.row] copy];//为毛要用浅拷贝copy 
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];//移除这个的话，菜单选择会保持原来的  原来的阵列
    [destinationArray insertObject:element atIndex:destinationIndexPath.row];
    
    [settings setObject:enabledApps forKey:@"favorites"];
    [settings writeToFile:kPrefs_Path atomically:YES];//原来的代码YES 2022.0224下午修改了一下 改为NO NO后就无法读取之前的app了
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {//可以在索引中移动行
    return YES;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"已选择-点击可选择或移除";
    }else{
        return @"未选择";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return enabledApps.count;
    }else{
        return disabledApps.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    NSString *identifier;

    if (indexPath.section == 0) {
        identifier = enabledApps[indexPath.row];
    }else{
        identifier = disabledApps[indexPath.row];
    }
    
    UIImage *icon;
    @try {
        icon = [applications iconOfSize:ALApplicationIconSizeSmall forDisplayIdentifier:identifier];
        cell.imageView.image = icon;
        cell.detailTextLabel.text = [applications valueForKey:@"displayName" forDisplayIdentifier:identifier];
    } @catch (NSException *exception) {
        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self tableView:tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:1] toIndexPath:[NSIndexPath indexPathForRow:enabledApps.count inSection:0]];
    }else{
        [self tableView:tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] toIndexPath:[NSIndexPath indexPathForRow:disabledApps.count inSection:1]];
    }
                // [self.tableView layoutIfNeeded];
    [self.tableView reloadData];
}





- (id)initDictionaryWithFile:(NSString*)plistPath asMutable:(BOOL)asMutable
{
//     NSString *newPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]; 
// plistPath = [newPath stringByAppendingPathComponent:@"/var/mobile/Library/Preferences/xc.lzsxcl.o2.SplitApp.plist"];

    Class class;
    if (asMutable)
        class = [NSMutableDictionary class];//NSMutableDictionary
    // else
    //     class = [NSDictionary class];//NSDictionary
    
    id dict;
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        NSLog(@"[HBP] extension plist exists");
        dict = [[class alloc] initWithContentsOfFile:plistPath];
    }else{
        NSLog(@"[HBP] creating new dict");
        dict = [[class alloc] init];
        dict[@"favorites"] = [[NSArray alloc] init];
    }
//修复初始化    
    return dict;
}



@end


