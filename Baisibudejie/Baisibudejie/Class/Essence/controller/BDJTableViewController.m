//
//  BDJTableViewController.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "BDJTableViewController.h"
#import "BDJEssenceModel.h"
#import "EssenceVideoCell.h"
#import "EssenceImageCell.h"
#import "EssenceTextCell.h"
#import "EssenceAudioCell.h"

@interface BDJTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)BDJEssenceModel *model;
//分页
@property (nonatomic, strong)NSNumber *np;


@end

@implementation BDJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //下载列表数据
    self.np = @(0);
    [self downloadListData];
    
    //创建tableView
    [self createTableView];
    
}

- (void)createTableView {
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //约束
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstPage)];
    
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextPage)];
}

//下拉刷新
- (void)loadFirstPage {
    
    self.np = @(0);
    
    [self downloadListData];
    
}

//上拉加载更多
- (void)loadNextPage {
    
    self.np = self.model.info.np;
    
    [self downloadListData];
    
}



- (void)downloadListData {
    //开始下载
    [ProgressHUD show:@"正在下载" Interaction:NO];
    
    //http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.3/0-20.json
    
    //http://s.budejie.com/topic/list/jingxuan/41/
    
    NSString *urlString = [NSString stringWithFormat:@"%@/bs0315-iphone-4.3/%@-20.json", self.url,self.np];
    
    
    
    [BDJDownloader downloadWithURLString:urlString success:^(NSData *data) {
        NSError *error = nil;
        BDJEssenceModel *model = [[BDJEssenceModel alloc]initWithData:data error:&error];
        if (error) {
            NSLog(@"%@", error);
        } else {
            if (self.np.integerValue == 0) {
                //第一页
                self.model = model;
                
            }else{
                //后面的页数
                
                //1-20  info(np1) list1
                //21-40 info(np2) list2
                
                //info(np1) list1+list2
                //info(np2) list1+list2
                
                NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.model.list];
                [tmpArray addObjectsFromArray:model.list];
                model.list = (NSArray<Optional, BDJEssenceDetail> *)tmpArray;
                
                self.model = model;
            }
            //刷新表格
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                //结束第三方库刷新
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
                [ProgressHUD showSuccess:@"下载成功"];
            });
        }
        
        
    } fail:^(NSError *error) {
       [ProgressHUD showError:@"下载失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceDetail *detail = self.model.list[indexPath.row];
    UITableViewCell *cell = nil;
    if ([detail.type isEqualToString:@"video"]) {
        //视频的cell
        cell = [EssenceVideoCell videoCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    } else if ([detail.type isEqualToString:@"image"]) {
        //图片的cell
        cell = [EssenceImageCell imageCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    } else if ([detail.type isEqualToString:@"text"]) {
        //段子的cell
        cell = [EssenceTextCell textCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    } else if ([detail.type isEqualToString:@"audio"]) {
        //音频的cell
        cell = [EssenceAudioCell audioCellForTableView:tableView atIndexPath:indexPath withModel:detail];
    } else {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceDetail *detail = self.model.list[indexPath.row];
    return detail.cellHeight.floatValue;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  500;
}


@end
