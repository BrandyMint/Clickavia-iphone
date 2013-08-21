//
//  ChatManager.h
//  CAManagersLib
//
//  Created by macmini1 on 10.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginForm.h"
#import "AcceptedOrder.h"
#import "Routes.h"
#import <LRResty/LRResty.h>
#import <Base64/MF_Base64Additions.h>
#import "DMCMMappingProvider.h"
#import "DMCMClientMessage.h"
#import "DMCMChatMessage.h"
#import <EasyMapping/EasyMapping.h>
#import "ChatMessage.h"

@interface ChatManager : NSObject
- (void) getMessages:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder withCompleteBlock:(void(^)(NSArray *messages))block;
- (void) sendMessage:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder message:(NSString*)message withCompleteBlock:(void(^)(NSString *status))block;
@end
