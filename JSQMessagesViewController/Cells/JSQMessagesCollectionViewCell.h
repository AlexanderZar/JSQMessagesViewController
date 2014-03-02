//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellLabelHeightDefault;


@interface JSQMessagesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) UILabel *cellTopLabel;
@property (weak, nonatomic, readonly) UILabel *messageBubbleTopLabel;
@property (weak, nonatomic, readonly) UILabel *cellBottomLabel;

@property (weak, nonatomic, readonly) UITextView *textView;

@property (weak, nonatomic) UIImageView *bubbleImageView;
@property (weak, nonatomic) UIImageView *avatarImageView;

@property (assign, nonatomic) CGFloat cellTopLabelHeight;
@property (assign, nonatomic) CGFloat bubbleTopLabelHeight;
@property (assign, nonatomic) CGFloat cellBottomLabelHeight;
@property (assign, nonatomic) CGSize avatarViewSize;

@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;

#pragma mark - Class methods

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

@end