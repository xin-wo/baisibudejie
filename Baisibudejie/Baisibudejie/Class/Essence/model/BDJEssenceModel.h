//
//  BDJEssenceModel.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol NSString;
@protocol BDJEssenceComment;
@protocol BDJEssenceTag;
@protocol BDJEssenceDetail;
@class BDJEssenceInfo;
@class BDJEssenceUser;
@class BDJEssenceVideo;


@interface BDJEssenceModel : JSONModel

@property (nonatomic, strong)BDJEssenceInfo<Optional> *info;
@property (nonatomic, strong)NSArray<BDJEssenceDetail, Optional> *list;


@end


@interface BDJEssenceInfo : JSONModel

@property (nonatomic, strong)NSNumber<Optional> *count;
@property (nonatomic, strong)NSNumber<Optional> *np;

@end


@interface BDJEssenceDetail : JSONModel

@property (nonatomic, copy)NSString<Optional> *bookmark;
@property (nonatomic, copy)NSString<Optional> *comment;
@property (nonatomic, strong)NSNumber<Optional> *down;
@property (nonatomic, strong)NSNumber<Optional> *forward;
@property (nonatomic, copy)NSString<Optional> *detailId;
@property (nonatomic, copy)NSString<Optional> *passtime;
@property (nonatomic, copy)NSString<Optional> *share_url;
@property (nonatomic, strong)NSNumber<Optional> *status;
@property (nonatomic, strong)NSArray<BDJEssenceTag, Optional> *tags;
@property (nonatomic, copy)NSString<Optional> *text;
@property (nonatomic, strong)NSArray<BDJEssenceComment, Optional> *top_comments;
@property (nonatomic, copy)NSString<Optional> *type;
@property (nonatomic, strong)BDJEssenceUser<Optional> *u;
@property (nonatomic, copy)NSString<Optional> *up;

@property (nonatomic, strong)BDJEssenceVideo<Optional> *video;

/**用来设置和获取对应cell的高度*/
@property (nonatomic, strong)NSNumber<Optional>  *cellHeight;


@end


@interface BDJEssenceTag : JSONModel


@property (nonatomic, strong)NSNumber<Optional> *tagId;
@property (nonatomic, copy)NSString<Optional> *name;



@end


@interface BDJEssenceComment : JSONModel

@property (nonatomic, copy)NSString<Optional> *cmt_type;
@property (nonatomic, copy)NSString<Optional> *content;
@property (nonatomic, strong)NSNumber<Optional> *commentId;
@property (nonatomic, strong)NSNumber<Optional> *like_count;
@property (nonatomic, copy)NSString<Optional> *passtime;
@property (nonatomic, strong)NSNumber<Optional> *precid;
@property (nonatomic, strong)NSNumber<Optional> *preuid;
@property (nonatomic, strong)NSNumber<Optional> *status;
@property (nonatomic, strong)BDJEssenceUser<Optional> *u;
@property (nonatomic, strong)NSNumber<Optional> *voicetime;
@property (nonatomic, copy)NSString<Optional> *voiceuri;

@end


@interface BDJEssenceUser : JSONModel

@property (nonatomic, copy)NSArray<NSString, Optional> *header;
@property (nonatomic, strong)NSNumber<Optional> *is_v;
@property (nonatomic, strong)NSNumber<Optional> *is_vip;
@property (nonatomic, copy)NSString<Optional> *name;
@property (nonatomic, copy)NSString<Optional> *room_icon;
@property (nonatomic, copy)NSString<Optional> *room_name;
@property (nonatomic, copy)NSString<Optional> *room_role;
@property (nonatomic, copy)NSString<Optional> *room_url;
@property (nonatomic, copy)NSString<Optional> *uid;


@end


@interface BDJEssenceVideo : JSONModel

@property (nonatomic, copy)NSArray<NSString, Optional> *download;
@property (nonatomic, strong)NSNumber<Optional> *duration;
@property (nonatomic, strong)NSNumber<Optional> *height;
@property (nonatomic, strong)NSNumber<Optional> *playcount;
@property (nonatomic, strong)NSNumber<Optional> *playfcount;
@property (nonatomic, copy)NSArray<NSString, Optional> *thumbnail;
@property (nonatomic, copy)NSArray<NSString, Optional> *thumbnail_small;
@property (nonatomic, copy)NSArray<NSString, Optional> *video;
@property (nonatomic, strong)NSNumber<Optional> *width;

@end



