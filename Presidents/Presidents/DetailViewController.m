//
//  DetailViewController.m
//  Presidents
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "DetailViewController.h"
#import "LanguageListController.h"

@interface DetailViewController ()

@property LanguageListController *languageListController;
@property UIBarButtonItem *languageButton;

@end

@implementation DetailViewController

- (NSString *)modifyUrlForLanguage:(NSString *)url language:(NSString *)lang{
    NSString *newUrl = url;
    
    BOOL fake = YES;
    
    NSString *langStr = lang;
    if (fake) {
        if (langStr) {
            NSRange range = NSMakeRange(8, 2);
            if (![langStr isEqualToString:@""] && ![[url substringWithRange:range] isEqualToString:langStr]) {
                newUrl = [url stringByReplacingCharactersInRange:range withString:langStr];
            }
        }
    }
    
    return newUrl;
    
}

- (void)configureView {
    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
    id detail = self.detailItem;
    if (detail) {
        UILabel *label = self.detailDescriptionLabel;
        if (label) {
            NSDictionary *dict = detail;
            NSString *urlString = dict[@"url"];
            urlString = [self modifyUrlForLanguage:urlString language:self.languageString];
            
            
            label.text = urlString;
            
            // must add
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_webView loadRequest:request];
            NSString *name = dict[@"name"];
            self.title = name;
        }
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    
    self.languageButton = [[UIBarButtonItem alloc] initWithTitle:@"Choose language" style:UIBarButtonItemStylePlain target:self action:@selector(showLanguagePopover)];
    self.navigationItem.rightBarButtonItem = self.languageButton;
    
}

- (void)setLanguageString:(NSString *)languageString{
    [self configureView];
}

- (void)showLanguagePopover{
    if (!self.languageListController) {
        self.languageListController = [[LanguageListController alloc] init];
        self.languageListController.detailViewController = self;
        self.languageListController.modalPresentationStyle = UIModalPresentationPopover;
        
    }
    
    [self presentViewController:self.languageListController animated:YES completion:nil];
    UIPopoverPresentationController *ppc = self.languageListController.popoverPresentationController;
    
    if (ppc) {
        ppc.barButtonItem = self.languageButton;
    }
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
