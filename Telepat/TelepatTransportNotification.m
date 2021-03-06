//
//  TelepatTransportNotification.m
//  Kraken
//
//  Created by Ovidiu on 26/06/15.
//  Copyright (c) 2015 Appscend. All rights reserved.
//

#import "TelepatTransportNotification.h"

@implementation TelepatTransportNotification

+ (instancetype) notificationOfType:(enum TelepatNotificationType)type withValue:(id)value path:(NSString *)path origin:(TelepatNotificationOrigin)origin {
    TelepatTransportNotification *transportNotification = [[TelepatTransportNotification alloc] init];
    transportNotification.type = type;
    transportNotification.origin = origin;
    transportNotification.value = value;
    transportNotification.path = path;
    
    return transportNotification;
}

@end
