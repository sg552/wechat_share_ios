/**
 * wechat
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "CcHappysoftWechatModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation CcHappysoftWechatModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"2ab35e62-3ac3-4467-aa69-b494307e60b1";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"cc.happysoft.wechat";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
	NSLog(@"======start up===============================");
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
  NSLog(@"release any resources that have been retained by the module");
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
    NSLog(@"the first (of potentially many) listener is being added");
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)sendMessage:(NSString *)title
{
    // example method
    // example method

    _scene = WXSceneSession;
    [WXApi registerApp:@"wx5760f7d9cf3822af"];

    NSLog(@"====注册成功xxxx==================================!!!!!!!!!!!");
    NSLog(@"====打印tilte结束xxxx==================================!!!!!!!!!!!");
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"悦家装";
    message.description = @"悦家装：悦家起航！";
    [message setThumbImage:[UIImage imageNamed:@"appicon.png"]];

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://www.baidu.com/";

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req]; // sendReq 请求调用后，会切到微信终端程序界面

    return @"success";
}

-(id)sendList:(id)args
{
    //读取JS中传来的参数
    NSArray *args_array = (NSArray *)args;
    NSString *title = args_array[0];
    NSString *desc = args_array[1];
    NSString *url = args_array[2];


    _scene = WXSceneSession;
    [WXApi registerApp:@"wx5760f7d9cf3822af"];

    NSLog(@"====注册成功 SendList   hahahaha==================================!!!!!!!!!!!");
    NSLog(title);
    NSLog(desc);
    NSLog(@"====打印tilte结束  sendLIst==================================!!!!!!!!!!!");
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:[UIImage imageNamed:@"appicon.png"]];

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];  // sendReq 请求调用后，会切到微信终端程序界面


    return @"success";
}

//-(id)sendMessage:(NSString *)title description:(NSString *)description image_url:(NSString *)image_url web_url:(NSString *)web_url
//-(id)sendListToFriendCircle:(NSString *)title url:(NSString *)url
-(id)sendListToFriendCircle:(id)args
{
    //读取JS中传来的参数
    NSArray *args_array = (NSArray *)args;
    NSString *title = args_array[0];
    NSString *desc = args_array[1];
    NSString *url = args_array[2];

    _scene = WXSceneTimeline;
    [WXApi registerApp:@"wx5760f7d9cf3822af"];

    NSLog(@"====注册成功===friendCircle===============================!!!!!!!!!!!");
    NSLog(title);
    NSLog(url);
    NSLog(@"====打印tilte结束==================================!!!!!!!!!!!");
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;

    [message setThumbImage:[UIImage imageNamed:@"appicon.png"]];

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;

    message.mediaObject = ext;

    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;

    [WXApi sendReq:req];    // sendReq 请求调用后，会切到微信终端程序界面

    return @"sucess";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}
#pragma Public APIs

//(id)send_message:(NSString *)tilte (NSString *)description (NSString *)webpageUrl (NSString *)imageUrl

//WXApiDelegate协议
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        [alert release];

        NSLog(@"===============onReq 被调用");
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;

        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;

        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    NSLog(@"====req==================================!!!!!!!!!!!");
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    NSLog(@"====resp==================================!!!!!!!!!!!");
}


@end
