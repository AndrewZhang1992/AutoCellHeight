//
//  ViewController.m
//  Mastory_Use
//
//  Created by Andrew on 16/8/30.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Person.h"
#import "PersonCell.h"
#import "UITableView+AZAutoCellHeight.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *cellHeightArray;
@end

@implementation ViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)cellHeightArray
{
    if (!_cellHeightArray) {
        _cellHeightArray = [NSMutableArray array];
    }
    return _cellHeightArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    
     Masonry使用注意事项:
     
     用mas_makeConstraints的那个view需要在addSubview之后才能用这个方法
     mas_equalTo适用数值元素，equalTo适合多属性的比如make.left.and.right.equalTo(self.view)
     方法and和with只是为了可读性，返回自身，比如make.left.and.right.equalTo(self.view)和make.left.right.equalTo(self.view)是一样的。
     因为iOS中原点在左上角所以注意使用offset时注意right和bottom用负数。
     
     */
    
    // 填充model
    NSArray *names = @[@"李开复",@"陈元淳",@"王之一"];
    NSArray *picths = @[@"教育背景：中国科技大学金融管理学学士，英国政治经济学院金融学硕士。\n工作经历：曾在鼎晖旗下从事5年的PE项目，拥有丰富帮助企业上市的经验。\n创业经历：现当任岩海投资有限公司 投资经理",@"浙江大学创新技术研究院有限公司项目经理",@"王小忠，新源资本董事总经理，深圳市彩讯科技战略投资总监，TMT领域投资专家，投资过杭州友声、上海飞智、广东车联网、奥图思为、百纳游戏、传动未来、上海幻方、彩讯科技、傲天科技等项目。关注种子期、早期、中期、以及pre-ipo项目。"];
    NSArray *loctaion = @[@"北京",@"",@"沙哈拉"];
    NSArray *rounds = @[@"A轮",@"种子轮",@"C轮后"];
    
    
    _tableView = [UITableView new];
    _tableView.frame=self.view.bounds;
    _tableView.tableFooterView = [UIView new];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    
    for (int j = 0 ; j<10; j++)
    {
        for (int i =0; i<names.count; i++) {
            Person *person = [Person new];
            person.name = names[i];
            person.pitch = picths[i];
            person.location = loctaion[i];
            person.round = rounds[i];
            [self.dataArray addObject:person];
        }
    }
    
//    // 缓存cell高度
//    for(int i =0;i<self.dataArray.count;i++){
//        CGFloat cell_height=[_tableView az_cacheCellHeightAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] CellClass:[PersonCell class] Identifier:@"PersonCell" ContentConfiguration:^(id  _Nullable cell) {
//            [(PersonCell *)cell setPerson:self.dataArray[i]];
//        }];
//        [self.cellHeightArray addObject:@(cell_height)];
//    }
    

    [_tableView registerClass:[PersonCell class] forCellReuseIdentifier:@"PersonCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [self.cellHeightArray[indexPath.row] floatValue];
    
//    return [tableView az_heightForRowAtIndexPath:indexPath];
    
    return [tableView az_heightForRowAtIndexPath:indexPath CellClass:[PersonCell class] Identifier:@"PersonCell" ContentConfiguration:^(id  _Nullable cell) {
        [(PersonCell *)cell setPerson:self.dataArray[indexPath.row]];
    }];
    
//    return [tableView fd_heightForCellWithIdentifier:@"PersonCell" cacheByIndexPath:indexPath configuration:^(id cell) {
//          [(PersonCell *)cell setPerson:self.dataArray[indexPath.row]];
//    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
    if (!cell) {
        cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.person = self.dataArray[indexPath.row];
    return cell;
}

@end
