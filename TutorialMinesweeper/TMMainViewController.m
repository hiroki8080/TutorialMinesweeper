//
//  TMMainViewController.m
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import "TMMainViewController.h"

@interface TMMainViewController ()

@end

@implementation TMMainViewController
@synthesize header;
@synthesize minesweeper;
@synthesize cellSizeX;
@synthesize cellSizeY;
@synthesize isLongTap;
@synthesize isGameStarted;
@synthesize magnification;
@synthesize timer;
@synthesize time;
@synthesize longPressGesture;
@synthesize isScrolling;
@synthesize cellCache;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // メイン画面ビューにマインスイーパ用セルコレクションビューを登録
    self.collectionView.collectionViewLayout = [[TMMainViewLayout alloc] initWithWidth:640.0f height:720.0f];
    [self initSettings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSettings{
    [self.collectionView registerClass:[TMMainViewCell class] forCellWithReuseIdentifier:@"minesweepercell"];
    header = [[TMMainHeaderView alloc] initWithFrame:CGRectMake(0,0, 320.0f, 60.0f)];
    [header.endButton addTarget:self action:@selector(clickEndButton:)
               forControlEvents:UIControlEventTouchDown];
    [header.resetButton addTarget:self action:@selector(clickResetButton:)
                 forControlEvents:UIControlEventTouchDown];
    [header.pinchiOutButton addTarget:self action:@selector(clickPinchOutButton:)
                     forControlEvents:UIControlEventTouchDown];
    [header.pinchiInButton addTarget:self action:@selector(clickPinchInButton:)
                    forControlEvents:UIControlEventTouchDown];
    header.bombCountLabel.text = [NSString stringWithFormat: @"%d" ,self.minesweeper.bombCount];
    [header.configButton addTarget:self action:@selector(clickConfigButton:)
                  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:header];
    [self.collectionView setBackgroundColor:[UIColor grayColor]];
    longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPressGesture.minimumPressDuration = 2.0;
    [self.view addGestureRecognizer:longPressGesture];
    self.magnification = 1;
    self.time = 0;
    self.isGameStarted = false;
    
    CGRect r = [[UIScreen mainScreen] bounds];
    CGFloat w = r.size.width; // セルを正方形にするため、高さは横幅と同じにする
    self.cellSizeX = floor(w/self.minesweeper.sizeX);
    self.cellSizeY = floor(w/self.minesweeper.sizeY);
    
}

// タイマーをカウントアップ
-(void)addTimerCount:(NSTimer*)timer{
    time++;
    header.timerLabel.text = [NSString stringWithFormat: @"%d" ,time];
}

// ヘッダーサイズを返す
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0.0f, 60.0f);
}

// ロングプレス時の処理
- (void) longPress:(UILongPressGestureRecognizer *)sender
{
    if(!sender.enabled){
        return;
    }
    CGPoint p = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    TMMainViewCell *cell = (TMMainViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            cell.isFlag = !cell.isFlag;
            if (cell.isFlag) {
                self.minesweeper.bombCount--;
                header.bombCountLabel.text = [NSString stringWithFormat: @"%d" ,self.minesweeper.bombCount];
            }else{
                self.minesweeper.bombCount++;
                header.bombCountLabel.text = [NSString stringWithFormat: @"%d" ,self.minesweeper.bombCount];
            }
            [cell tapToChangeBackGround];
            [cell setExpansion];
            break;
            
        case UIGestureRecognizerStateEnded:
            [cell resetExpansion];
            break;
        default:
            break;
    }
}

//自動画面回転の設定
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //縦画面のみ有効
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown || interfaceOrientation == UIInterfaceOrientationPortrait);
}

// セルが選択された際の処理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TMMainViewCell *cell = (TMMainViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    // タイマー開始
    if(self.timer == Nil || !self.timer.isValid){
        self.timer =
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(addTimerCount:) userInfo:nil repeats:YES];
        self.isGameStarted = true;
    }
    // フラグとクエスチョンの切り替え
    if(cell.isFlag||cell.isQuestion){
        if(cell.isFlag){
            cell.isFlag = false;
            cell.isQuestion = true;
        }else{
            cell.isFlag = true;
            cell.isQuestion = false;
        }
        [self reDrawCells];
        return;
    }
    
    // セルを開く
    BOOL result = [self.minesweeper openCell:[self.minesweeper getCellIndexX:(int)indexPath.row] y:[self.minesweeper getCellIndexY:(int)indexPath.row] isCheck:YES];
    if (result) {
        // セルを開くことに成功した場合=セルの再描画
        [self reDrawCells];
        // 開いたトータルセル数
        int total = self.minesweeper.sizeX * self.minesweeper.sizeY - self.minesweeper.difficulty - self.minesweeper.openCount;
        if(total == 0){
            [self.timer invalidate];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"GameClear!!"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }else{
        // セルを開くことに失敗した場合＝爆弾
        cell.isExplosion = true;
        [self.minesweeper openCell:[self.minesweeper getCellIndexX:(int)indexPath.row] y:[self.minesweeper getCellIndexY:(int)indexPath.row] isCheck:NO];
        [self reDrawCells];
        [self.timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Gameover!!"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

// セルを再描画する処理
- (void)reDrawCells{
    for(int i=0;i<self.minesweeper.sizeY;i++){
        for(int j=0;j<self.minesweeper.sizeX;j++){
            // セルを取得するためのインデックスパス生成
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i*self.minesweeper.sizeY+j inSection:0];
            TMMainViewCell *cell = (TMMainViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            // インデックスパスから、セルの縦・横それぞれの座標を取得
            int indexX = [self.minesweeper getCellIndexX:(int)indexPath.row];
            int indexY = [self.minesweeper getCellIndexY:(int)indexPath.row];
            // 対象のセルの爆弾カウント数を取得
            int status = [self.minesweeper getCellStatusAtIndex:indexX y:indexY];
            cell.bomCount = status;
            // 対象のセルが開けれる状態であれば開く
            if([self.minesweeper isTargetOpen:indexX y:indexY]){
                if (cell.isFlag) {
                    self.minesweeper.bombCount++;
                    header.bombCountLabel.text = [NSString stringWithFormat: @"%d" ,self.minesweeper.bombCount];
                }
                // ゲームオーバー時はすべて開ける状態のため、爆弾も開くようにする
                if (status == BOMB){
                    cell.isBomb = true;
                }
                cell.viewStatus = OPEND;
                [cell tapToChangeBackGround];
            }else {
                cell.viewStatus = CLOSED;
                [cell tapToChangeBackGround];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    // セクションの数
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // セルの数
    return self.minesweeper.sizeX * self.minesweeper.sizeY;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // セルを選択可能にする
    return YES;
}

// セルの取得
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TMMainViewCell *cell = [self getCell:indexPath];
    cell.sizeX = self.cellSizeX;
    cell.sizeY = self.cellSizeY;
    cell.viewStatus = CLOSED;
    if (self.isScrolling) {
        // スクロール中は全てセルを描画しなおす
        [self reDrawCells];
        self.isScrolling = NO;
    }
    return cell;
}

- (TMMainViewCell*)getCell:(NSIndexPath*)indexPath {
    TMMainViewCell *cell = (TMMainViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"minesweepercell" forIndexPath:indexPath];
    return cell;
}

// Endボタンクリック時
- (void)clickEndButton:(id)sender{
    self.isGameStarted = false;
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Newボタンクリック時
- (void)clickResetButton:(UIButton*)button{
    if(!self.isGameStarted){
        // 開始していない場合は処理しない
        return;
    }
    self.collectionView = [self.collectionView initWithFrame:CGRectMake(0,0, 320.0f, 320.0f) collectionViewLayout:[[TMMainViewLayout alloc] initWithWidth:640.0f height:720.0f]];
    self.collectionView.delegate = self;
    [self.collectionView reloadData];
    [self initSettings];
    self.minesweeper = [[TMLogic new] initWithDifficulty:self.minesweeper.difficulty];
    [self reDrawCells];
    self.magnification = 1;
    self.time = 0;
    self.isGameStarted = false;
    [self.timer invalidate];
    header.bombCountLabel.text = [NSString stringWithFormat: @"%d" ,self.minesweeper.bombCount];
    header.timerLabel.text = [NSString stringWithFormat: @"%d" ,0];
}

// 拡大ボタンクリック時
- (void)clickPinchOutButton:(UIButton*)button{
    if(self.magnification == 3){
        return;
    }
    self.magnification++;
    CGAffineTransform t2 = CGAffineTransformMakeScale(self.magnification, self.magnification);
    self.collectionView.transform = t2;
    
    CGRect r = [[UIScreen mainScreen] bounds];
    CGFloat w = r.size.width;
    CGFloat h = r.size.height;
    int magnificationCount = (self.magnification-1) / 0.2;
    self.collectionView.center = CGPointMake(w/2 + (32.0f*magnificationCount), h/2 + (45.0f*magnificationCount));
    [self reDrawCells];
}

// 縮小ボタンクリック時
- (void)clickPinchInButton:(UIButton*)button{
    if(self.magnification == 1){
        return;
    }
    self.magnification--;
    CGAffineTransform t2 = CGAffineTransformMakeScale(self.magnification, self.magnification);
    CGRect r = [[UIScreen mainScreen] bounds];
    CGFloat w = r.size.width;
    CGFloat h = r.size.height;
    self.collectionView.transform = t2;
    self.collectionView.center = CGPointMake(w/2, h/2);
    [self reDrawCells];
}

// Configボタンクリック時
- (void)clickConfigButton:(UIButton*)button{
    TMSettingViewController *config = [self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
    config.touchHoldTime = self.longPressGesture.minimumPressDuration;
    config.delegate = self;
    config.isEnable = self.longPressGesture.enabled;
    [self presentViewController:config animated:YES completion:nil];
}

-(void)settingViewController:(TMSettingViewController *)settingViewController didClose:(NSString *)message enable:(BOOL)enable
{
    self.longPressGesture.minimumPressDuration = [message doubleValue];
    self.longPressGesture.enabled = enable;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.cellSizeX, self.cellSizeY);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reDrawCells];
    self.isScrolling = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.isScrolling = YES;
}

@end
