//
//  JSQMessagesCollectionViewCellSystem.m
//  JSQMessages
//
//  Created by Alexander Zarembovsky on 3/23/16.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellSystem.h"

@implementation JSQMessagesCollectionViewCellSystem

#pragma mark - Overrides

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellBottomLabel.textAlignment = NSTextAlignmentCenter;
}
@end
