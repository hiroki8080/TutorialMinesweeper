//
//  TMLogic.m
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import "TMLogic.h"

@implementation TMLogic
@synthesize sizeX;
@synthesize sizeY;
@synthesize bombCount;
@synthesize openCount;

const int MODE_EASY = 10;
const int MODE_NORMAL = 40;
const int MODE_HARD = 199;
// パネルの状態
// 爆弾:-1, 閉じている:0, 開いている:9, ボーダー:-2, フラグ:-3
const int BOMB = -1;
const int CLOSED = 0;
const int OPEND = 9;
const int BORDER = -2;
const int FLAG = -3;
const int kScanX[] = {-1,0,1,-1,1,-1,0,1};
const int kScanY[] = {-1,-1,-1,0,0,1,1,1};

- (id)initWithDifficulty:(int)difficulty{
    self = [super init];
    if (self) {
        self.difficulty = difficulty;
        switch (difficulty) {
            case MODE_EASY:
                self.sizeX = 9;
                self.sizeY = 9;
                self.bombCount = MODE_EASY;
                break;
            case MODE_NORMAL:
                self.sizeX = 16;
                self.sizeY = 16;
                self.bombCount = MODE_NORMAL;
                break;
            case MODE_HARD:
                self.sizeX = 32;
                self.sizeY = 32;
                self.bombCount = MODE_HARD;
                break;
            default:
                break;
        }
        tableOpenedMap = [self resetTable:tableOpenedMap];
        tableBombMap = [self resetTable:tableBombMap];
        [self setBombs];
        self.openCount = 0;
    }
    return self;
}

- (NSMutableArray*)resetTable:(NSMutableArray*)table{
    table = [NSMutableArray array];
    for(int i=0; i<self.sizeY+2;i++){
        NSMutableArray *row = [NSMutableArray array];
        for (int j=0; j<self.sizeX+2;j++){
            if(i==0 || i==self.sizeY+1 || j == 0 || j == self.sizeX+1){
                [row addObject:[NSNumber numberWithInt:BORDER]];
            }else{
                [row addObject:[NSNumber numberWithInt:CLOSED]];
            }
        }
        [table addObject:row];
    }
    return table;
}

- (void)setBombs{
    // 爆弾の配置
    srand((unsigned)time(NULL));
    int count = self.bombCount;
    while(count>0){
        int x = rand() % self.sizeX;
        int y = rand() % self.sizeY;
        if ([[self getCellData:tableBombMap x:x y:y] intValue]!= BOMB){
            [self setCellData:tableBombMap x:x y:y value:BOMB];
            count--;
        }
    }
    // 爆弾カウントの計算と設定
    for(int i=0; i<self.sizeY;i++){
        for (int j=0; j<self.sizeX;j++){
            int scanX;
            int scanY;
            for(int k=0;k<8;k++){
                scanX = j+kScanX[k];
                scanY = i+kScanY[k];
                if([[self getCellData:tableBombMap x:scanX y:scanY] intValue] == BOMB && [[self getCellData:tableBombMap x:j y:i] intValue] != BOMB ){
                    [self setCellData:tableBombMap x:j y:i value:[[self getCellData:tableBombMap x:j y:i] intValue]+1];
                }
            }
        }
    }
}

- (int)getCellStatusAtIndex:(int)x y:(int)y{
    return [[self getCellData:tableBombMap x:x y:y] intValue];
}

- (BOOL)isTargetOpen:(int)x y:(int)y{
    int status = [[self getCellData:tableOpenedMap x:x y:y] intValue];
    if (status == OPEND){
        return true;
    }
    return false;
}

- (int)getCellIndexX:(int)index{
    int x = floor(index % self.sizeX);
    return x;
}
- (int)getCellIndexY:(int)index{
    int y = floor(index / self.sizeX);
    return y;
}

- (NSNumber*)getCellData:(NSMutableArray*)target x:(int)x y:(int)y{
    return [[target objectAtIndex:y + 1] objectAtIndex:x + 1];
}
- (void)setCellData:(NSMutableArray*)target x:(int)x y:(int)y value:(int)value{
    [[target objectAtIndex:y + 1] replaceObjectAtIndex:x + 1 withObject:[NSNumber numberWithInt:value]];
}

- (BOOL)openCell:(int)x y:(int)y isCheck:(BOOL)isCheck{
    int result = true;
    
    if (isCheck) {
        if([[self getCellData:tableOpenedMap x:x y:y] intValue] == OPEND){
            // 既に開かれているパネルに対しては処理しない
            return result;
        }
        
        if([[self getCellData:tableBombMap x:x y:y] intValue] > CLOSED){
            // 爆弾カウントがセットされているパネルの場合はテーブルにOPENEDをセットして結果を返す。
            [self setCellData:tableOpenedMap x:x y:y value:OPEND];
            self.openCount++;
            result = true;
            return result;
        }
        if([[self getCellData:tableBombMap x:x y:y] intValue] == BOMB){
            // 爆弾かどうかのチェック
            result = false;
            return result;
        }
    }
    // チェックにヒットしない場合はオープン
    [self setCellData:tableOpenedMap x:x y:y value:OPEND];
    self.openCount++;
    
    // 周囲のセルのスキャン
    for(int i=0;i<8;i++){
        int scanX = x+kScanX[i];
        int scanY = y+kScanY[i];
        
        if([[self getCellData:tableBombMap x:scanX y:scanY] intValue] != BORDER && [[self getCellData:tableOpenedMap x:scanX y:scanY] intValue] == CLOSED) {
            // 外周以外でかつ開いていないセルがあれば開く
            [self openCell: scanX y:scanY isCheck:isCheck];
        }
    }
    return result;
}

@end
