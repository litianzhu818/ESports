//
//  DetailNewsCenterCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailNewsCenterCell.h"

@interface DetailNewsCenterCell ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation DetailNewsCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.webView setUserInteractionEnabled:NO];
    [self.webView.scrollView setScrollEnabled:NO];
    [self.webView.scrollView setShowsVerticalScrollIndicator:NO];
    [self.webView.scrollView setShowsHorizontalScrollIndicator:NO];
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.bounces = NO;
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailNew:(DetailNew *)detailNew
{
    _detailNew = detailNew;
    
    [self.activityIndicatorView startAnimating];
    //[self.webView setHidden:YES];
    
    NSData *data = [[NSString stringWithFormat:@"%@%@",@"<style> img{width:100%;height:200} video{width:100%;height:auto} iframe{width:100%;height:auto} body{color:#ffffff;font-size:30pt;} </style>",_detailNew.newsContent] dataUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadData:data
                  MIMEType:@"text/html"
          textEncodingName:@"UTF-8"
                   baseURL:nil];
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineWidth(context, 1);  //线宽
//    CGContextSetAllowsAntialiasing(context, true);
//    CGContextSetStrokeColorWithColor(context, HexColor(0x213954).CGColor);  //线的颜色
//    
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, 8.0, rect.size.height-1.0);  //起点坐标
//    CGContextAddLineToPoint(context, rect.size.width-8.0, rect.size.height-1.0);   //终点坐标
//    CGContextStrokePath(context);
//}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([DetailNewsCenterCell class])
                          bundle:[NSBundle bundleForClass:[DetailNewsCenterCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([DetailNewsCenterCell class]);
}

+ (CGFloat)cellHeight
{
    return 44.0f;
}

#pragma mark -  UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
    webView.hidden = self.needRelaod;
    
    if (self.needRelaod) {
        CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue]/3;
        if (self.cellHeightBlock) {
            self.cellHeightBlock(height+10);
        }
    }
    
    NSLog(@"%@",NSStringFromCGSize(self.webView.scrollView.contentSize));
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicatorView stopAnimating];
    webView.hidden = NO;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
}

@end
