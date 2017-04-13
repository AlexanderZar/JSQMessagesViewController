//
//  JSQMessagesCollectionViewCellOffer.m
//  JSQMessages
//
//  Created by Alexander Zarembovsky on 4/13/17.
//  Copyright © 2017 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellOffer.h"
#import "JSQMessagesCollectionViewLayoutAttributes.h"
#import "UIImage+JSQMessages.h"
#import "NSBundle+JSQMessages.h"

NSString *const JSQMessagesCollectionViewCellOfferButtonNotification = @"JSQMessagesCollectionViewCellOfferButtonNotification";
NSString *const JSQMessagesCollectionViewCellOfferButtonKey = @"JSQMessagesCollectionViewCellOfferButtonKey";

@interface JSQMessagesCollectionViewCellOffer ()

@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@end


@implementation JSQMessagesCollectionViewCellOffer

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellBottomLabel.textAlignment = NSTextAlignmentCenter;
    
    self.yesButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 13.0f);
    self.noButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 13.0f);
    
    [self.yesButton setImage:[UIImage jsq_imageNamed:@"checkmark"]
                    forState:UIControlStateNormal];
    [self.noButton setImage:[UIImage jsq_imageNamed:@"cross"]
                   forState:UIControlStateNormal];
    
    [self.yesButton setTitle:[NSBundle jsq_localizedStringForKey:@"YES"]
                    forState:UIControlStateNormal];
    [self.noButton setTitle:[NSBundle jsq_localizedStringForKey:@"NO"]
                   forState:UIControlStateNormal];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
     JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    
    if (self.noButton.titleLabel.font != customAttributes.offerMessageButtonsFont) {
        self.noButton.titleLabel.font = customAttributes.offerMessageButtonsFont;
    }
    
    if (self.yesButton.titleLabel.font != customAttributes.offerMessageButtonsFont) {
        self.yesButton.titleLabel.font = customAttributes.offerMessageButtonsFont;
    }

    _yesButton.layer.cornerRadius = CGRectGetHeight(_yesButton.bounds) / 2;
    _noButton.layer.cornerRadius = CGRectGetHeight(_noButton.bounds) / 2;
}

#pragma mark - Actions

- (IBAction)noButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JSQMessagesCollectionViewCellOfferButtonNotification
                                                        object:self
                                                      userInfo:@{ JSQMessagesCollectionViewCellOfferButtonKey : @(NO) }];
}

- (IBAction)yesButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JSQMessagesCollectionViewCellOfferButtonNotification
                                                        object:self
                                                      userInfo:@{ JSQMessagesCollectionViewCellOfferButtonKey : @(YES) }];
}

@end
