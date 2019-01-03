# iOS12-mac-bug
Important
To use this function in iOS 12 and later, enable the Access WiFi Information capability for your app in Xcode. When you enable this capability, Xcode automatically adds the Access WiFi Information entitlement to your entitlements file and App ID.
通过上面我们可以了解到，要在iOS12以上的系统中继续使用方法，就需要获取授权。如果你使用的是自动签名，授权之后Xcode会自动在App ID和应用的权限列表中增加WiFi的权限。如果你使用的是手动签名，可能还需要去App ID中配置一下权限，并生成新的profile文件。
具体的操作如下
设置Capabilities步骤：Target -> Capabilities  -> Access WiFi Information -> ON

如果项目使用的是手动签名，上面打开Access WiFi Information之后，可能Add the Access WiFi Information feature to your App ID这一项会报错，需要手动去App ID账号中设置。
打开Access WiFi Information之后，工程会在.entitlements 文件中添加Access WiFi Information信息，如果没有.entitlements文件会同时创建文件
