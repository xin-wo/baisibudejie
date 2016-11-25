//
//  EssenceTextCell.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "EssenceTextCell.h"
#import "BDJEssenceModel.h"


@interface EssenceTextCell()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@property (weak, nonatomic) IBOutlet UIView *tagView;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CommentViewHCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CommentViewYCons;


@end

@implementation EssenceTextCell

+ (EssenceTextCell *)textCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(BDJEssenceDetail *)detailModel {
    static NSString *cellId = @"textCellId";
    EssenceTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceTextCell" owner:nil options:nil]lastObject];
    }
    cell.detailModel = detailModel;
    return cell;
}

- (void)setDetailModel: (BDJEssenceDetail *)detailModel {
    _detailModel = detailModel;
    NSString *headerString = [detailModel.u.header firstObject];
    NSURL *url = [NSURL URLWithString:headerString];
    [self.userImageView sd_setImageWithURL:url];
    
    self.userNameLabel.text = detailModel.u.name;
    
    self.passTimeLabel.text = detailModel.passtime;
    
    self.descLabel.text = detailModel.text;
    
    if (detailModel.top_comments.count>0) {
        BDJEssenceComment *comment = [detailModel.top_comments firstObject];
        self.commentLabel.text = comment.content;
    } else {
        self.commentLabel.text = nil;
    }
    [self layoutIfNeeded];
    
    if (detailModel.top_comments.count > 0) {
        self.CommentViewHCons.constant = self.commentLabel.frame.size.height+20;
        self.CommentViewYCons.constant = 10;
       
    } else {
        self.CommentViewHCons.constant = 0;
        self.CommentViewYCons.constant = 0;
    }
    
    NSMutableString *tagString = [NSMutableString string];
    for (NSInteger i = 0; i<detailModel.tags.count; i++) {
        BDJEssenceTag *tag = detailModel.tags[i];
        [tagString appendFormat:@"%@ ", tag.name];
    }
    self.tagLabel.text = tagString;
    
    [self.dingButton setTitle:[detailModel.down stringValue] forState:UIControlStateNormal];
    [self.caiButton setTitle:[detailModel.down stringValue] forState:UIControlStateNormal];
    [self.shareButton setTitle:[detailModel.forward stringValue] forState:UIControlStateNormal];
    [self.commentButton setTitle:detailModel.comment forState:UIControlStateNormal];
    [self layoutIfNeeded];
    
    detailModel.cellHeight = @(CGRectGetMaxY(self.dingButton.frame)+20);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//更多
- (IBAction)ClickMoreBtn {
}




- (IBAction)dingAction:(id)sender {
}

- (IBAction)caiAction:(id)sender {
}

- (IBAction)shareAction:(id)sender {
}

- (IBAction)commentAction:(id)sender {
}


@end
