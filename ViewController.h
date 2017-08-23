//
//  ViewController.h
//  meow
//
//  Created by Fullscreen on 8/15/17.
//  Copyright © 2017 MB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSMutableArray* meowArray;
@property (nonatomic) NSInteger count;
@property (weak, nonatomic) IBOutlet UITableView *meowTableView;


@end

