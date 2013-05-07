//
//  FavoritesTableViewController.h
//  Wasel
//
//  Created by Abdelrahman Mohamed on 4/28/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnotationManager.h"
#import "FavoriteCell.h"

@interface FavoritesTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
}
@property (strong, nonatomic) IBOutlet UITableView *table;

-(IBAction) returnToSuperview:(id) sender;
@end
