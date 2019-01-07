//
//  DeviceOperation.m
//  DeviceOperation
//
//  Created by Chan on 13-11-26.
//  Copyright (c) 2013年 77. All rights reserved.
//

#import "XSDeviceInfo.h"

@implementation XSDeviceInfo


#pragma mark -  当前连接的设备（路由器）信息
//_______________________________________________________________________________________________________________

+ (NSString *)ssid {
    NSDictionary *networkInfo = [self networkInfo];
    NSString *name = [networkInfo objectForKey:(NSString *)kCNNetworkInfoKeySSID];
    return (name == nil || [name isEqualToString:@""]) ? @"Not Found":name;
}


+ (NSString *)bssid {
    NSDictionary *networkInfo = [self networkInfo];
    NSString *macAddress = [[networkInfo objectForKey:(NSString *)kCNNetworkInfoKeyBSSID] lowercaseString];
    NSArray *macArr = [macAddress componentsSeparatedByString:@":"];
    NSMutableArray *macMultArr = [NSMutableArray array];
    for (int index = 0; index < macArr.count; index ++) {
        NSString *str = macArr[index];
        if (str.length == 1) {
            str = [@"0" stringByAppendingString:str];
        }else if (str.length == 0){
            str = @"00";
        }
        [macMultArr addObject:str];
    }
    NSString *resultStr = [macMultArr componentsJoinedByString:@":"];
    return (macAddress == nil || [macAddress isEqualToString:@""]) ? @"Not Found":resultStr;
}


//  获取当前连接网络的SSID、BSSID、SSIDDATA
+ (NSDictionary *)networkInfo {
    NSArray *interfaces = (__bridge NSArray *)CNCopySupportedInterfaces();
    NSString *interface = [interfaces objectAtIndex:0];
    NSDictionary *networkInfo = (__bridge NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)interface);
    return networkInfo;
}


#pragma mark - 手机信息
//_______________________________________________________________________________________________________________


// 拿到IP地址
+ (NSString *)ipAddress {
    NSDictionary *dict = [self addrMaskGate];
    NSString *addr = dict[@"ADDR"];
    return addr;
}

+ (NSDictionary *)addrMaskGate {
    struct ifaddrs *interface = NULL;
    int result;
    NSDictionary *dict;
    
    result = getifaddrs(&interface);
    struct ifaddrs *temp_addr;
    
    for (temp_addr = interface; temp_addr != NULL; temp_addr = temp_addr->ifa_next) {
        if (temp_addr->ifa_addr->sa_family == AF_INET) {
            char naddr[INET_ADDRSTRLEN];
            char nmask[INET_ADDRSTRLEN];
            char ngate[INET_ADDRSTRLEN];
            
            if (strcmp(temp_addr->ifa_name, "lo0") != 0 &&
                &((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr != NULL &&
                &((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr != NULL &&
                &((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr != NULL) {
                inet_ntop(AF_INET, &((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr, naddr, INET_ADDRSTRLEN);
                inet_ntop(AF_INET, &((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr, nmask, INET_ADDRSTRLEN);
                inet_ntop(AF_INET, &((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr, ngate, INET_ADDRSTRLEN);
                NSString *addr = [NSString stringWithCString:naddr encoding:NSUTF8StringEncoding];
                NSString *mask = [NSString stringWithCString:nmask encoding:NSUTF8StringEncoding];
                NSString *gate= [NSString stringWithCString:ngate encoding:NSUTF8StringEncoding];
                dict = @{@"ADDR": addr,
                         @"MASK": mask,
                         @"GATE": gate};
            }
        }
    }
    freeifaddrs(interface);
    return dict;
}

@end
