//
//  ChatManager.m
//  CAManagersLib
//
//  Created by macmini1 on 10.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "ChatManager.h"

@implementation ChatManager
- (void)getMessages:(LoginForm *)byLoginForm forOrder:(AcceptedOrder *)forOrder withCompleteBlock:(void (^)(NSArray *messages))block andFailedBlock:(void(^)(NSException *exception))failedBlock
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,CHAT_ROUTE];    
    if(byLoginForm.accessToken.length==0)
    {
        AuthManager *am = [AuthManager new];
        [am getUser:byLoginForm completeBlock:^(User *user)
         {
             NSString *urlWithParameters = [[NSString alloc] initWithFormat:@"%@?order_id=%@&access_token=%@",url,forOrder.orderCode,user.authKey];
             [[LRResty client] get:urlWithParameters withBlock:^(LRRestyResponse *response)
              {
                  if(response.status==200)
                  {
                      NSString *stringRepresentationOfReponse = [response asString];
                      block([self mapMessages:stringRepresentationOfReponse]);
                  }
              }];
         } failBlock:^(NSException *exception){NSLog(@"%@",[exception description]);}];
    }
    else
    {

        NSString *urlWithParameters = [[NSString alloc] initWithFormat:@"%@?order_id=%@&access_token=%@",url,forOrder.orderCode,byLoginForm.accessToken];
        [[LRResty client] get:urlWithParameters withBlock:^(LRRestyResponse *response)
         {
             if(response.status==200)
             {
                 NSString *stringRepresentationOfReponse = [response asString];
                 block([self mapMessages:stringRepresentationOfReponse]);
             }
         }];
        
    }
    
    
    
}

- (NSArray*)mapMessages:(NSString*) response
{
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray *cmmessages =[EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMCMMappingProvider chatMessageMapping]];
    NSMutableArray *messages = [NSMutableArray new];
    for(DMCMChatMessage *dmmessage in cmmessages)
    {
        ChatMessage *message = [ChatMessage new];
        message.senderName = dmmessage.user;
        message.text = dmmessage.text;
        message.isClient = [dmmessage.type isEqualToString:@"chat_by_user"];

        message.dateAndTime = dmmessage.datetime;
        [messages addObject:message];
    }
    return messages;
}
- (void) sendMessage:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder message:(NSString*)message withCompleteBlock:(void(^)(NSString *status))block andFailedBlock:(void(^)(NSException *exception))failedBlock
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,CHAT_ROUTE];

    if(byLoginForm.accessToken.length == 0)
    {
        AuthManager *am = [AuthManager new];
        [am getUser:byLoginForm completeBlock:^(User *user)
         {
             DMCMClientMessage *newMessage = [DMCMClientMessage new];
             newMessage.text = message;
             newMessage.order_id = forOrder.orderCode;
             newMessage.access_token = user.authKey;
             NSDictionary *jsonDictionary = [EKSerializer serializeObject:newMessage withMapping:[DMCMMappingProvider messageMapping]];
             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
             NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
             [[LRResty client] attachRequestModifier:^(LRRestyRequest *request)
              {
                  [request addHeader:@"Content-Type" value:@"application/json"];
              }];
             [[LRResty client] post:url payload:requestBody withBlock:^(LRRestyResponse *response)
              {
                  NSString *serverStatus = [[NSString alloc] initWithFormat:@"%i",response.status];
                  block(serverStatus);
              }];

         } failBlock:^(NSException *exception){failedBlock(exception);}];
    }
    else
    {
        DMCMClientMessage *newMessage = [DMCMClientMessage new];
        newMessage.text = message;
        newMessage.order_id = forOrder.orderCode;
        newMessage.access_token = byLoginForm.accessToken;
        NSDictionary *jsonDictionary = [EKSerializer serializeObject:newMessage withMapping:[DMCMMappingProvider messageMapping]];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[LRResty client] attachRequestModifier:^(LRRestyRequest *request)
         {
             [request addHeader:@"Content-Type" value:@"application/json"];
         }];
        [[LRResty client] post:url payload:requestBody withBlock:^(LRRestyResponse *response)
         {
             NSString *serverStatus = [[NSString alloc] initWithFormat:@"%i",response.status];
             block(serverStatus);
         }];
        
    }
    
    
    
}
@end
