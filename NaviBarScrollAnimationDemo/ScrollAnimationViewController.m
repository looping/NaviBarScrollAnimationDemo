//
//  ScrollAnimationViewController.m
//  NaviBarScrollAnimationDemo
//
//  Created by Looping on 14/9/24.
//  Copyright (c) 2014年 RidgeCorn. All rights reserved.
//

#import "ScrollAnimationViewController.h"
#import "DetailViewController.h"

@interface ScrollAnimationViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIView *headerView;
@property (nonatomic) CGFloat headerHeight;

@end

@implementation ScrollAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];

    _headerHeight = 150.f;
    
    [self.view addSubview:({
        CGRect frame = self.view.frame;
        
        _tableView = [[UITableView alloc] initWithFrame:frame];
        [_tableView setContentInset:UIEdgeInsetsMake(_headerHeight - [self topHeight], 0, 0, 0)];
        [_tableView setScrollIndicatorInsets:UIEdgeInsetsMake(_headerHeight - [self topHeight], 0, 0, 0)];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView.layer setMasksToBounds:NO];
        
        _tableView;
    })];

    [self.view addSubview:({
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, _headerHeight)];
        [_headerView setBackgroundColor:[UIColor darkGrayColor]];
        [_headerView.layer setMasksToBounds:YES];

        [_headerView addSubview:({
            CGRect frame = _headerView.frame;
            frame.origin.x -= 15;
            frame.origin.y -= _headerView.frame.size.height / 3;
            frame.size.width += 30;
            frame.size.height += _headerView.frame.size.height / 3 + 15;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setImage:[UIImage imageNamed:@"bg"]];
            [imageView.layer setMasksToBounds:YES];
            [imageView setTag:100];
            
            UIInterpolatingMotionEffect *effectX;
            
            UIInterpolatingMotionEffect *effectY;
            
            effectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
            
            effectY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            
            effectX.maximumRelativeValue = @(10);
            
            effectX.minimumRelativeValue = @(-10);
            
            effectY.maximumRelativeValue = @(10);
            
            effectY.minimumRelativeValue = @(-10);
            
            [imageView addMotionEffect:effectX];
            
            [imageView addMotionEffect:effectY];
            
            imageView;
        })];
        
        [_headerView addSubview:({
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:effect];
            view.frame = self.view.bounds;
            [view setAlpha:0.f];
            [view setTag:99];
            
            view;
        })];
        
        [_headerView addSubview:({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 25.f, 25.f, 50.f, 50.f)];
            [imageView setImage:[UIImage imageNamed:@"avatar"]];
            [imageView.layer setMasksToBounds:YES];
            [imageView.layer setCornerRadius:5.f];
            [imageView setTag:101];
            
            imageView;
        })];
        
        [_headerView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 80.f, self.view.frame.size.width, 30.f)];
            [label setText:@"Looping"];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:26.f]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTag:102];
            
            label;
        })];
        
        [_headerView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 110.f, self.view.frame.size.width, 40.f)];
            [label setText:@"Navigation Bar Scroll Animation Demonstration"];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:15.f]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setNumberOfLines:2];
            [label setTag:103];
            
            label;
        })];
        
        [_headerView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, _headerView.frame.size.height - .5f, self.view.frame.size.width, .5f)];
            [label setText:@""];
            [label setBackgroundColor:[UIColor lightGrayColor]];
            [label setTextColor:[UIColor clearColor]];
            
            label;
        })];
        
        _headerView;
    })];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if (fabsf(view.frame.size.width - self.navigationController.navigationBar.frame.size.width) <= FLT_EPSILON) {
            [view setHidden:YES];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

//    [self.navigationController.navigationBar.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:nil];

    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if (fabsf(view.frame.size.width - self.navigationController.navigationBar.frame.size.width) <= FLT_EPSILON) {
            [view setHidden:NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( !cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Item #%d", indexPath.row]];
    
    [cell.imageView setImage:[[UIImage imageNamed:@"avatar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    if ([cell.imageView viewWithTag:201]) {
        [[cell.imageView viewWithTag:201] removeFromSuperview];
    }
    
    [cell.imageView addSubview:({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        NSArray *colors = @[[UIColor redColor], [UIColor greenColor],  [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor]];
        
        [view setBackgroundColor:[colors objectAtIndex:indexPath.row % colors.count]];
        [view setTag:201];
        
        view;
    })];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushDetailViewController];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + _headerHeight;
    
    if (offsetY > 0) {
        [self animateHeaderToOffset:_headerHeight - offsetY < [self topHeight] ? _headerHeight - [self topHeight] : offsetY];
    } else {
        [self resetHeader];
    }
}

- (void)resetHeader {
    [_headerView setCenter:CGPointMake(self.view.frame.size.width / 2, _headerHeight / 2)];
    
    [_headerView setBackgroundColor:[UIColor darkGrayColor]];

    [[_headerView viewWithTag:99] setAlpha:0.f];
    
    [[_headerView viewWithTag:100] setCenter:_headerView.center];

    [[_headerView viewWithTag:100] setAlpha:1.f];
    
    [[_headerView viewWithTag:102] setCenter:CGPointMake(_headerView.frame.size.width / 2, 95.f)];
    
    [(UILabel *)[_headerView viewWithTag:102] setTextColor:[UIColor whiteColor]];

    [_headerView viewWithTag:102].transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.f, 1.f);

    [[_headerView viewWithTag:103] setAlpha:1.f];
}

- (void)animateHeaderToOffset:(CGFloat)offset {
    CGFloat rate = (_headerHeight - [self topHeight] - offset) / (_headerHeight - [self topHeight]);

    [_headerView setCenter:CGPointMake(self.view.frame.size.width / 2, _headerHeight / 2 - offset)];
    
    [_headerView setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:.5f + .5f * rate]];

    [[_headerView viewWithTag:99] setAlpha:1.f - rate];

    [[_headerView viewWithTag:100] setCenter:CGPointMake(self.view.frame.size.width / 2, _headerHeight / 2 + offset * 5 / 4)];
    
    [[_headerView viewWithTag:100] setAlpha:.5f + .5f * rate];

    [[_headerView viewWithTag:102] setCenter:CGPointMake(_headerView.frame.size.width / 2, 95.f + (_headerHeight - self.navigationController.navigationBar.frame.size.height / 2 - 95.f) * (1.f -rate))];
    
    [(UILabel *)[_headerView viewWithTag:102] setTextColor:[UIColor colorWithWhite:rate alpha:1.f]];

    [_headerView viewWithTag:102].transform = CGAffineTransformScale(CGAffineTransformIdentity, .8f + .2f * rate, .8f + .2f * rate);

    [[_headerView viewWithTag:103] setAlpha:rate * rate * rate];
}

- (CGFloat)topHeight {
    return self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (void)pushDetailViewController {
    [self.navigationController pushViewController:[DetailViewController new] animated:YES];
}

- (void)dealloc {
    [_tableView setDataSource:nil];
    [_tableView setDelegate:nil];
}

@end
