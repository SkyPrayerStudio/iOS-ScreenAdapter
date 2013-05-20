//
//  UIDevice+ScreenAdapter.m
//  ScreenAdapter
//
//  Created by py4nt on 13-5-20.
//  Copyright (c) 2013年 net4nt. All rights reserved.
//

#import "UIDevice+ScreenAdapter.h"

@implementation UIDevice (ScreenAdapter)

+ (UIDeviceScreenAdapter)currentResolution
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f)
            {
                return UIDevice_iPhoneStandardRes;
            }
            return (result.height > 960 ? UIDevice_iPhoneNewRetianRes : UIDevice_iPhoneStdRetinaRes);
        }
        else
        {
            return UIDevice_iPhoneStandardRes;
        }
    }
    else
    {
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)] && [[UIScreen mainScreen] scale] == 2) ? UIDevice_iPadRetianRes : UIDevice_iPadStandradRes);
    }
}

+ (BOOL)isRunningOniPhone5
{
    if ([self currentResolution] == UIDevice_iPhoneNewRetianRes)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isRunningOniPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (UIDeviceScreenAdapter)getResoultionWidth
{
    UIDeviceScreenAdapter resolution = [self currentResolution];
    switch (resolution)
    {
        case UIDevice_iPhoneStandardRes:
            resolution = 320;
            break;
        case UIDevice_iPhoneStdRetinaRes:
        case UIDevice_iPhoneNewRetianRes:
            resolution = 640;
            break;
        case UIDevice_iPadStandradRes:
            resolution = 768;
            break;
        case UIDevice_iPadRetianRes:
            resolution = 1536;
            break;
        default:
            resolution = 0;
            break;
    }
    return resolution;
}

+ (UIDeviceScreenAdapter)getResoultionHeight
{
    UIDeviceScreenAdapter resolution = [self currentResolution];
    switch (resolution)
    {
        case UIDevice_iPhoneStandardRes:
            resolution = 480;
            break;
        case UIDevice_iPhoneStdRetinaRes:
            resolution = 960;
            break;
        case UIDevice_iPhoneNewRetianRes:
            resolution = 1136;
            break;
        case UIDevice_iPadStandradRes:
            resolution = 1024;
            break;
        case UIDevice_iPadRetianRes:
            resolution = 2048;
            break;
        default:
            resolution = 0;
            break;
    }
    return resolution;
}

@end
