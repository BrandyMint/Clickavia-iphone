//
//  ChatManager.m
//  CAManagersLib
//
//  Created by macmini1 on 10.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "ChatManager.h"

@implementation ChatManager
- (void)getMessages:(LoginForm *)byLoginForm forOrder:(AcceptedOrder *)forOrder withCompleteBlock:(void (^)(NSArray *messages))block
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,CHAT_ROUTE];
    NSString *authString = [[NSString alloc] initWithFormat:@"%@:%@",byLoginForm.email,byLoginForm.password];
    NSLog(@"Base64: %@",authString);
    NSString *urlWithParameters = [[NSString alloc] initWithFormat:@"%@?order_id=%@",url,forOrder.orderCode];
    [[LRResty client] attachRequestModifier:^(LRRestyRequest *request)
     {
         [request addHeader:@"Authorization" value:[[NSString alloc] initWithFormat:@"Basic %@",[authString base64String]]];
         
     }];
    [[LRResty client] get:urlWithParameters withBlock:^(LRRestyResponse *response)
     {
         if(response.status==200)
         {
             NSString *stringRepresentationOfReponse = [response asString];
             block([self mapMessages:stringRepresentationOfReponse]);
         }
     }];
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
- (void) sendMessage:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder message:(NSString*)message withCompleteBlock:(void(^)(NSString *status))block
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,CHAT_ROUTE];
    NSString *authString = [[NSString alloc] initWithFormat:@"%@:%@",byLoginForm.email,byLoginForm.password];
    NSLog(@"Base64: %@",authString);
    
    DMCMClientMessage *newMessage = [DMCMClientMessage new];
    newMessage.text = message;
    newMessage.order_id = forOrder.orderCode;
    
    NSDictionary *jsonDictionary = [EKSerializer serializeObject:newMessage withMapping:[DMCMMappingProvider messageMapping]];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"RequestBody: %@",requestBody);
    
    [[LRResty client] attachRequestModifier:^(LRRestyRequest *request)
     {
         [request addHeader:@"Authorization" value:[[NSString alloc] initWithFormat:@"Basic %@",[authString base64String]]];
         [request addHeader:@"Content-Type" value:@"application/json"];
     }];
    [[LRResty client] post:url payload:requestBody withBlock:^(LRRestyResponse *response)
     {
         NSString *serverStatus = [[NSString alloc] initWithFormat:@"%i",response.status];
         block(serverStatus);
     }];
}
@end
