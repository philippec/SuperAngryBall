//
//  CViewController.m
//  AngryBirdsClone
//
//  Created by Jonathan Wight on 10/29/11.
//  Copyright (c) 2011 toxicsoftware.com. All rights reserved.
//

#import "CViewController.h"

#import "CRendererView.h"
#import "CGameRenderer.h"
#import "CGameView.h"

@interface CViewController ()
@property (readwrite, nonatomic, strong) IBOutlet CGameView *rendererView;
@end

@implementation CViewController

@synthesize rendererView;

- (void)viewDidLoad
    {
    [super viewDidLoad];
    
    CGameRenderer *theRenderer = [[CGameRenderer alloc] init];
    
    self.rendererView.renderer = theRenderer;
    self.rendererView.rootNode = theRenderer.rootNode;
    }
    
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
    {
    return(YES);
    }

@end
