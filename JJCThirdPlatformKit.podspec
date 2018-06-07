Pod::Spec.new do |s|

    s.name                       = 'JJCThirdPlatformKit'

    s.version                    = '1.0.0'

    s.summary                    = '第三方平台组件化工具'

    s.homepage                   = 'https://github.com/JJCSoftDeveloper/JJCThirdPlatformKit'

    s.license                    = { :type => 'MIT', :file => 'LICENSE' }

    s.author                     = { 'JJC' => '499927993@qq.com' }

    s.social_media_url           = 'http://weibo.com/1642366375'

    s.source                     = { :git => 'https://github.com/JJCSoftDeveloper/JJCThirdPlatformKit.git', :tag => s.version }

    s.platform                   = :ios

    s.ios.deployment_target      = '8.1'

    # 设置默认的模块，如果在pod文件中导入pod项目没有指定子模块，导入的是这里指定的模块
    s.default_subspec = 'Core'

    # 定义一个核心模块，用户存放抽象的接口、基类以及一些公用的工具类和头文件
    s.subspec 'Core' do |subspec|
        # 源代码
        subspec.source_files = 'JJCThirdPlatformKit/BaseManager/**/*'
        # 配置系统Framework
        subspec.frameworks = 'CoreMotion'
        subspec.dependency 'SDWebImage'
        # 添加依赖的系统静态库
        subspec.libraries = 'xml2', 'z', 'c++', 'stdc++.6', 'sqlite3'
    end

    # 支付宝模块
    s.subspec 'AlipayManager' do |subspec|
        # 源代码
        subspec.source_files = 'JJCThirdPlatformKit/AlipayManager/**/*'
        # 添加资源文件
        subspec.resource = 'JJCThirdPlatformKit/AlipayManager/**/*.bundle'
        # 添加依赖第三方的framework
        subspec.vendored_frameworks = 'JJCThirdPlatformKit/AlipayManager/**/*.framework'
        # 添加依赖系统的framework
        subspec.frameworks = 'CoreTelephony', 'SystemConfiguration'
        # 依赖的核心模块
        subspec.dependency 'JJCThirdPlatformKit/Core'
    end

    # QQ模块
    s.subspec 'TencentManager' do |subspec|
        # 源代码
        subspec.source_files = 'JJCThirdPlatformKit/TencentManager/**/*'
        # 添加资源文件
        #subspec.resource = 'JJCThirdPlatformKit/TencentManager/**/*.bundle'
        # 添加依赖第三方的framework
        subspec.vendored_frameworks = 'JJCThirdPlatformKit/TencentManager/**/*.framework'
        # 添加依赖系统的framework
        subspec.frameworks = 'SystemConfiguration'
        # 依赖的核心模块
        subspec.dependency 'JJCThirdPlatformKit/Core'
    end

    # 微博模块
    s.subspec 'WeiboManager' do |subspec|
        # 源代码
        subspec.source_files = 'JJCThirdPlatformKit/WeiboManager/**/*'
        # 依赖的微博pod库
        subspec.dependency 'WeiboSDK'
        subspec.dependency 'JJCThirdPlatformKit/Core'
    end


    # 微信模块
    s.subspec 'WechatManager' do |subspec|
        # 源代码
        subspec.source_files = 'JJCThirdPlatformKit/WechatManager/**/*'
        # 依赖的微信pod库
        subspec.dependency 'WechatOpenSDK'
        subspec.dependency 'JJCThirdPlatformKit/Core'
    end

    # 招商支付模块
    s.subspec 'CMBManager' do |subspec|
        # 源代码
        subspec.source_files = 'JJCThirdPlatformKit/CMBManager/**/*'
        # 依赖的微信pod库
        # 添加依赖第三方的framework
        subspec.vendored_frameworks = 'JJCThirdPlatformKit/CMBManager/**/*.framework'
        subspec.dependency 'JJCThirdPlatformKit/Core'
    end
end