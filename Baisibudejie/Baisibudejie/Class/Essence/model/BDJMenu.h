//
//  BDJMenu.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class BDJDefault;

@protocol BDJMenuList;
@protocol BDJSubMenu;


@interface BDJMenu : JSONModel

@property (nonatomic, strong)BDJDefault<Optional> *default_menu;
@property (nonatomic, strong)NSArray<Optional,BDJMenuList> *menus;


@end

@interface BDJDefault : JSONModel

@property (nonatomic, copy)NSString<Optional> *initial;
@property (nonatomic, copy)NSString<Optional> *offline_day_3;
@property (nonatomic, copy)NSString<Optional> *offline_day_7;

@end


@interface BDJMenuList : JSONModel

@property (nonatomic, copy)NSString<Optional> *name;
@property (nonatomic, strong)NSArray<Optional,BDJSubMenu> *submenus;

@end


@interface BDJSubMenu : JSONModel

@property (nonatomic, copy)NSString<Optional> *entrytype;
@property (nonatomic, copy)NSString<Optional> *god_topic_type;
@property (nonatomic, copy)NSString<Optional> *name;

@property (nonatomic, copy)NSString<Optional> *recsys_url;
@property (nonatomic, copy)NSString<Optional> *type;
@property (nonatomic, copy)NSString<Optional> *url;

@end
