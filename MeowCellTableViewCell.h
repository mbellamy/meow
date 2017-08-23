//
//  MeowCellTableViewCell.h
//  meow
//
//  Created by Fullscreen on 8/15/17.
//  Copyright © 2017 MB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeowCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *meowImageView;
@property (weak, nonatomic) IBOutlet UILabel *meowTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *meowTitleLabel;
@end
