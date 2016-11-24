//
//  EssenceVideoCell.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDJEssenceDetail;



@interface EssenceVideoCell : UITableViewCell

//数据
@property (nonatomic, strong)BDJEssenceDetail *detailModel;

+ (EssenceVideoCell *)videoCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath withModel: (BDJEssenceDetail *)detailModel;

@end
