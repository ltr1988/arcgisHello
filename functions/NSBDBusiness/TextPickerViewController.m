//
//  TextPickerViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TextPickerViewController.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "TitleDetailTextItem.h"

@interface TextPickerViewController()
{
    BOOL readonly;
}
@property (nonatomic,weak) TitleDetailTextItem *data;
@property (nonatomic,strong) UITextView *textView;
@end

@implementation TextPickerViewController

-(instancetype) initWithData:(TitleDetailTextItem *)data readOnly:(BOOL) readOnly
{
    self = [super init];
    if (self) {
        self.data = data;
        readonly = readOnly;
    }
    
    return self;
}

-(instancetype) initWithData:(TitleDetailTextItem *)data
{
    return [self initWithData:data readOnly:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    
    
}

-(void)saveData
{
    if (readonly) {
        return;
    }
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    }
    
    self.data.detail = @"已填写";
    self.data.text = _textView.text;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TextPickerNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) setupSubViews
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.title = self.data.title?:@"";
    
    if (!readonly) {
        UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
        [self.navigationItem setRightBarButtonItem:saveBtn];
    }
    
    _textView = [UITextView new];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textColor =[UIColor blackColor];

    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.layer.borderWidth = 0.5;
    [self.view addSubview:_textView];
    
    __weak UIView *weakView = self.view;
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(8);
        make.bottom.mas_equalTo(weakView.mas_centerX);
        make.right.mas_equalTo(weakView.mas_right).offset(-8);
        make.left.mas_equalTo(weakView.mas_left).offset(8);
    }];
    
    _textView.editable = !readonly;
    [_textView becomeFirstResponder];
    
    _textView.text = self.data.text?:@"";
    
    UITapGestureRecognizer *_tapToCloseGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToClose:)];
    _tapToCloseGesture.numberOfTapsRequired = 1;
    _tapToCloseGesture.numberOfTouchesRequired = 1;
    _tapToCloseGesture.delegate = self;
    [self.view addGestureRecognizer:_tapToCloseGesture];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:self.textView];
    BOOL locationIsInCenterPanel = CGRectContainsPoint(self.textView.bounds, location);
    
    return !locationIsInCenterPanel;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // never recognize simultaneously because then a table view cell swipe can close a panel
    return NO;
}


- (void)tapToClose:(UITapGestureRecognizer *)gesture
{
    [self.textView resignFirstResponder];
}
@end
