
//
//  DeviceOperation.h
//  DeviceOperation
//
//  Created by Chan on 13-11-26.
//  Copyright (c) 2013年 77. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/socket.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <netinet/in.h>
//新增
#include <net/if_dl.h>
#include <sys/sysctl.h>
#include <net/if.h>

/*!
 @brief  获取当前设备信息
 */
@interface XSDeviceInfo : NSObject

//! 获取当前接入的WiFi名称 wifi广播的名称
+ (NSString *)ssid;

//! 获取当前接入设备（路由器）的mac地址
+ (NSString *)bssid;

//! 获取当前设备的IP地址
+ (NSString *)ipAddress;

//! 获取当前设备的IP、掩码、网关
+ (NSDictionary *)addrMaskGate;

@end
