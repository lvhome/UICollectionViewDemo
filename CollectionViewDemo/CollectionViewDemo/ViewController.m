//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by MAC on 2018/11/7.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "LHLeftCollocationView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_RATE  ([UIScreen mainScreen].bounds.size.width/375.0)
static float imageHeight = 80;
#import "CollectionViewCell.h"
#import "CollModel.h"
static NSString * const collectionViewCell = @"CollectionViewCell";
@interface ViewController()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * collectionView3;
@property (nonatomic,strong) NSMutableArray * modelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *appArray = [[self getDict] objectForKey:@"dictInfo"];
    for (int i = 0; i < appArray.count; i++) {
        NSDictionary * appDic = appArray[i];
        CollModel * model = [[CollModel alloc]init];
        model.title = [appDic objectForKey:@"title"];
        model.url = [appDic objectForKey:@"url"];
        [self.modelArray addObject:model];
    }
    [self createCollectionView];
}

- (void)createCollectionView {
    CGFloat pading = 0 * SCREEN_WIDTH/375;
    LHLeftCollocationView * layout = [[LHLeftCollocationView alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = pading;
    layout.minimumInteritemSpacing = pading;
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView3 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, imageHeight * SCREEN_RATE) collectionViewLayout:layout];
    _collectionView3.tag = 33;
    _collectionView3.dataSource = self;
    _collectionView3.delegate = self;
    _collectionView3.bounces = NO;
    _collectionView3.alwaysBounceHorizontal = NO;
    _collectionView3.alwaysBounceVertical = NO;
    _collectionView3.backgroundColor = [UIColor grayColor];
    _collectionView3.showsHorizontalScrollIndicator = NO;
    _collectionView3.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView3];
    [_collectionView3 registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
}

- (NSDictionary *)getDict {
    NSString * string  = @"{\"dictInfo\":[{\"title\":\"你好啊\",\"url\":\"1.jpeg\"},{\"title\":\"你好啊\",\"url\":\"2.jpeg\"},{\"title\":\"你好啊\",\"url\":\"3.jpeg\"},{\"title\":\"你好啊\",\"url\":\"4.jpeg\"},{\"title\":\"你好啊\",\"url\":\"5.jpeg\"},{\"title\":\"你好啊\",\"url\":\"6.jpeg\"},{\"title\":\"是很好\",\"url\":\"7.jpeg\"}]}";
    NSDictionary *infoDic = [self dictionaryWithJsonString:string];
    return infoDic;
}


-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollModel *infoModel = self.modelArray[indexPath.row];
    NSLog(@"section:%ld --- row:%ld -----%@",indexPath.section,indexPath.row,infoModel.title);
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    cell.itemModel = infoModel;
    return cell;
}

// 返回每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat CWidth = 80 * SCREEN_RATE;
    CGFloat CHeight = 80 * SCREEN_RATE;
    return CGSizeMake(CWidth, CHeight);
}



#pragma mark - UICollectionViewDelegate点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollModel *infoModel = self.modelArray[indexPath.row];
    NSLog(@"infoModelArray----%@",infoModel.title);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
