/**
 * wechat
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import "WXApi.h"


@interface CcHappysoftWechatModule : TiModule <WXApiDelegate>
{
    enum WXScene _scene;
}

@end
