//
//  ViewController.m
//  meow
//
//  Created by Fullscreen on 8/15/17.
//  Copyright © 2017 MB. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MeowCellTableViewCell.h"
#import "MeowLoadingTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _meowTableView.delegate = self;
    _meowTableView.dataSource = self;
    _count = 0;
    [self getMeow:_count];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)getMeow :(NSInteger )count{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *query = [@"https://chex-triplebyte.herokuapp.com/api/cats?page=" stringByAppendingFormat:@"%ld", (long)count];
    [manager GET:query parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        _meowArray = responseObject;
        [_meowTableView reloadData];
        

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_meowArray count];
}
-(MeowCellTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MeowCell";
    NSString *cellIdentifier2 = @"LoadingCell";

    
    NSLog(@"%ld", (long)indexPath.row);
    
    MeowCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MeowLoadingTableViewCell *cellLoad = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];

    if (cell == nil) {
        cell = [[MeowCellTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == [_meowArray count] + 1) {
        cellLoad = [[MeowLoadingTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier:cellIdentifier2];
        [cellLoad.meowLoadingIndicator startAnimating];
        [self getMeow:_count + 1];
        NSLog(@"loading");
        return cellLoad;

    }
    cell.meowTimeLabel = [_meowArray[indexPath.row] objectForKey:@"timestamp"];
    NSString *title = [_meowArray[indexPath.row] objectForKey:@"title"];
    NSString *description = [_meowArray[indexPath.row] objectForKey:@"description"];
    NSString *caption = [[title stringByAppendingString:@"\n"] stringByAppendingString:description];
    cell.meowTitleLabel.text = caption;
    NSURL *url = [NSURL URLWithString:[_meowArray[indexPath.row] objectForKey:@"image_url"]];
    [cell.meowImageView setImageWithURL:url];
    return cell;
}

@end
