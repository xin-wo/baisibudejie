//
//  EssenceAudioCell.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDJEssenceDetail;



@interface EssenceAudioCell : UITableViewCell

//数据
@property (nonatomic, strong)BDJEssenceDetail *detailModel;

+ (EssenceAudioCell *)audioCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath withModel: (BDJEssenceDetail *)detailModel;

@end
