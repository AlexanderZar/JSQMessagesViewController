//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessage.h"


@implementation JSQMessage

#pragma mark - Initialization

+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                               text:(NSString *)text
{
    return [[self alloc] initWithSenderId:senderId
                        senderDisplayName:displayName
                                     date:[NSDate date]
                                     text:text
                          isSystemMessage:NO
                           isOfferMessage:NO];
}

+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                               text:(NSString *)text
                    isSystemMessage:(BOOL)isSystemMessage
                     isOfferMessage:(BOOL)isOfferMessage
{
    return [[self alloc] initWithSenderId:senderId
                        senderDisplayName:displayName
                                     date:[NSDate date]
                                     text:text
                          isSystemMessage:isSystemMessage
                           isOfferMessage:isOfferMessage];
}

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text
{
    NSParameterAssert(text != nil);
    
    self = [self initWithSenderId:senderId
                senderDisplayName:senderDisplayName
                             date:date
                          isMedia:NO
                  isSystemMessage:NO
                   isOfferMessage:NO];
    if (self) {
        _text = [text copy];
    }
    return self;
}

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text
                 isSystemMessage:(BOOL)isSystemMessage
                  isOfferMessage:(BOOL)isOfferMessage
{
    NSParameterAssert(text != nil);

    self = [self initWithSenderId:senderId
                senderDisplayName:senderDisplayName
                             date:date
                          isMedia:NO
                  isSystemMessage:isSystemMessage
                   isOfferMessage:isOfferMessage];
    if (self) {
        _text = [text copy];
    }
    return self;
}

+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                              media:(id<JSQMessageMediaData>)media
{
    return [[self alloc] initWithSenderId:senderId
                        senderDisplayName:displayName
                                     date:[NSDate date]
                                    media:media];
}

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                           media:(id<JSQMessageMediaData>)media
{
    NSParameterAssert(media != nil);

    self = [self initWithSenderId:senderId
                senderDisplayName:senderDisplayName
                             date:date
                          isMedia:YES
                  isSystemMessage:NO
                   isOfferMessage:NO];
    if (self) {
        _media = media;
    }
    return self;
}

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                         isMedia:(BOOL)isMedia
                 isSystemMessage:(BOOL)isSystemMessage
                  isOfferMessage:(BOOL)isOfferMessage
{
    NSParameterAssert(senderId != nil);
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(date != nil);

    self = [super init];
    if (self) {
        _senderId = [senderId copy];
        _senderDisplayName = [senderDisplayName copy];
        _date = [date copy];
        _isMediaMessage = isMedia;
        _isSystemMessage = isSystemMessage;
        _isOfferMessage = isOfferMessage;
    }
    return self;
}

- (NSUInteger)messageHash
{
    return self.hash;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    JSQMessage *aMessage = (JSQMessage *)object;

    if (self.isMediaMessage != aMessage.isMediaMessage) {
        return NO;
    }

    BOOL hasEqualContent = self.isMediaMessage ? [self.media isEqual:aMessage.media] : [self.text isEqualToString:aMessage.text];

    return [self.senderId isEqualToString:aMessage.senderId]
    && [self.senderDisplayName isEqualToString:aMessage.senderDisplayName]
    && ([self.date compare:aMessage.date] == NSOrderedSame)
    && (self.isSystemMessage == aMessage.isSystemMessage)
    && (self.isOfferMessage == aMessage.isOfferMessage)
    && hasEqualContent;
}

- (NSUInteger)hash
{
    NSUInteger contentHash = self.isMediaMessage ? [self.media mediaHash] : self.text.hash;
    return self.senderId.hash ^ self.date.hash ^ contentHash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: senderId=%@, senderDisplayName=%@, date=%@, isMediaMessage=%@, isSystemMessage=%@, text=%@, media=%@>",
            [self class], self.senderId, self.senderDisplayName, self.date, @(self.isMediaMessage), @(self.isSystemMessage), self.text, self.media];
}

- (id)debugQuickLookObject
{
    return [self.media mediaView] ?: [self.media mediaPlaceholderView];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _senderId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderId))];
        _senderDisplayName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderDisplayName))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _isMediaMessage = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isMediaMessage))];
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _media = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(media))];
        _isSystemMessage = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isSystemMessage))];
        _isOfferMessage = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isOfferMessage))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.senderId forKey:NSStringFromSelector(@selector(senderId))];
    [aCoder encodeObject:self.senderDisplayName forKey:NSStringFromSelector(@selector(senderDisplayName))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeBool:self.isMediaMessage forKey:NSStringFromSelector(@selector(isMediaMessage))];
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeBool:self.isSystemMessage forKey:NSStringFromSelector(@selector(isSystemMessage))];
    [aCoder encodeBool:self.isOfferMessage forKey:NSStringFromSelector(@selector(isOfferMessage))];

    if ([self.media conformsToProtocol:@protocol(NSCoding)]) {
        [aCoder encodeObject:self.media forKey:NSStringFromSelector(@selector(media))];
    }
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    if (self.isMediaMessage) {
        return [[[self class] allocWithZone:zone] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:self.date
                                                             media:self.media];
    }

    return [[[self class] allocWithZone:zone] initWithSenderId:self.senderId
                                             senderDisplayName:self.senderDisplayName
                                                          date:self.date
                                                          text:self.text
                                               isSystemMessage:self.isSystemMessage
                                                isOfferMessage:self.isOfferMessage];
}

@end
