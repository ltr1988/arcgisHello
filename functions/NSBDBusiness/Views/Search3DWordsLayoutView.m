//
//  Search3DWordsLayoutView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//
#import "Search3DWordsLayoutView.h"


#define WORD_INNER_LEFT_MARGIN   13
#define WORD_INNER_TOP_MARGIN    7
#define WORD_SPACE_HOR   5
#define WORD_SPACE_VER    13
#define WORD_LEFT_MARGIN      14
#define WORD_SPACE_VER_BOTTOM    18

@interface Search3DWordsLayoutView ()
@property(nonatomic,copy) WordsLayoutViewCallback callback;

@property(nonatomic,assign) int lines;

@end

@implementation Search3DWordsLayoutView

- (id)initWithCallback:(WordsLayoutViewCallback)callback
{
    self = [super init];
    if (self) {
        // Initialization code
        self.callback = callback;
    }
    return self;
}

- (void)layOut
{
    if (!_words || [_words count] == 0) {
        return;
    }
    [self clean];
    int actLine=1;
    NSMutableArray *tmpWords = [NSMutableArray arrayWithArray:_words];
    CGFloat offsetX = WORD_LEFT_MARGIN;
    CGFloat offsetY = WORD_SPACE_VER;
    CGFloat viewEdge = kScreenWidth - WORD_LEFT_MARGIN;
    int index = 0;
    while ([tmpWords count] > 0) {
        int  searchIndex = 0;
        BOOL findWord = NO;
        while (searchIndex < [tmpWords count]) {
            NSString *nextWord = [tmpWords objectAtIndex:searchIndex];
            CGFloat wordWidth = [self estimateWordWidth:nextWord];
            if (offsetX + wordWidth +  WORD_INNER_LEFT_MARGIN*2<= viewEdge) {
                CGRect rect = CGRectMake(offsetX, offsetY, wordWidth + WORD_INNER_LEFT_MARGIN*2, 30);
                NSInteger originalIndex = 0;
                for(NSString *word in _words)
                {
                    if ([word isEqualToString:nextWord]) {
                        originalIndex = [_words indexOfObject:word];
                        break;
                    }
                }
                UIButton *btn = [self buttonFotWord:nextWord withRect:rect withTag:originalIndex];
                offsetX += rect.size.width;
                index = searchIndex;
                [self addSubview:btn];
                [tmpWords removeObjectAtIndex:index];
                findWord = YES;
                break;
            }
            searchIndex ++;
        }

        if ([tmpWords count] == 0) {
            [self lineMidAlignment:offsetY];
        }
        else
        {
            offsetX += WORD_SPACE_HOR;
            if (offsetX  >= viewEdge || !findWord) {
                [self lineMidAlignment:offsetY];
                //这行满了
                actLine++;
                offsetX = WORD_LEFT_MARGIN;
                offsetY += WORD_SPACE_VER + 30;
            }
        }

        if (offsetY >= self.bounds.size.height - WORD_LEFT_MARGIN) {
            return;
        }
    }
    _lines = actLine;

}

-(CGFloat) heightForView
{
    return 30 * _lines + WORD_SPACE_VER*(2+(_lines -1));
}

#pragma mark private
- (CGFloat )estimateWordWidth:(NSString *)aWord
{
    CGSize wordSize = [aWord boundingRectWithSize:CGSizeMake(kScreenWidth - WORD_LEFT_MARGIN*2, 30)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}
                                          context:nil].size;
    return wordSize.width;
}

- (UIButton *)buttonFotWord:(NSString *)aWord withRect:(CGRect)rect withTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setTitle:aWord forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.45].CGColor;
    btn.layer.cornerRadius = 15.0;
    btn.tag = tag;
    [btn addTarget:self action:@selector(selectWord:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)clean
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (void)lineMidAlignment:(CGFloat)lineY
{
    NSArray *allBtns = self.subviews;
    //找出坐标为Y的一行
    NSMutableArray *line = [NSMutableArray array];
    for (UIView *btn in allBtns)
    {
        if (btn.frame.origin.y == lineY) {
            [line addObject:btn];
        }
    }
    UIView *lastView = line.lastObject;
    CGFloat space = ((kScreenWidth - WORD_LEFT_MARGIN) - (lastView.frame.origin.x + lastView.frame.size.width))/2;
    if (space < 0) {
        space = 0;
    }
    for(UIView *btn in line)
    {
        btn.frame = CGRectMake(btn.frame.origin.x + space, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
    }
}


- (void)selectWord:(id)sender
{
    _callback([sender tag]);
}

@end
