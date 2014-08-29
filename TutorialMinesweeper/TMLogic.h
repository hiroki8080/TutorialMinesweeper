//
//  TMLogic.h
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMLogic : NSObject{
@private
int bombNum;
int openedCell;
int openCellNum;
NSMutableArray *tableBombMap;
NSMutableArray *tableOpenedMap;
}
extern const int kScanX[];
extern const int kScanY[];
extern const int MODE_EASY;
extern const int MODE_NORMAL;
extern const int MODE_HARD;
extern const int BOMB;
extern const int CLOSED;
extern const int OPEND;
extern const int BORDER;
extern const int FLAG;
// 難易度
@property int difficulty;
// 爆弾の数
@property int bombCount;
// セルのサイズ
@property int sizeX;
@property int sizeY;
// 外周を含めたテーブルサイズ
@property int tableX;
@property int tableY;
// 開いた数
@property int openCount;

- (id)initWithDifficulty:(int)difficulty;
- (int)getCellStatusAtIndex:(int)x y:(int)y;
- (BOOL)isTargetOpen:(int)x y:(int)y;
- (int)getCellIndexX:(int)index;
- (int)getCellIndexY:(int)index;
- (BOOL)openCell:(int)x y:(int)y isCheck:(BOOL)isCheck;

@end
