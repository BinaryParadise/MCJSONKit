# MCJSONKit

[![Build Status](https://travis-ci.org/MC-Studio/MCJSONKit.svg?branch=master)](https://travis-ci.org/MC-Studio/MCJSONKit)
[![Version](https://img.shields.io/cocoapods/v/MCJSONKit.svg?style=flat)](http://cocoapods.org/pods/MCJSONKit)
[![License](https://img.shields.io/cocoapods/l/MCJSONKit.svg?style=flat)](http://cocoapods.org/pods/MCJSONKit)
[![Platform](https://img.shields.io/cocoapods/p/MCJSONKit.svg?style=flat)](http://cocoapods.org/pods/MCJSONKit)

- A fast, convenient and nonintrusive conversion between JSON and model.
- 转换速度快、使用简单方便的字典转模型框架

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MCJSONKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'git@github.com:mylcode/Specs.git'
pod 'MCJSONKit'
```

## 水平有限，不定期更新
- 一直是拿来主义用的第三方库，总是发现一些不灵活或者不足、不适用的地方，所以自己心血来潮写一个轻量的JSON对象转换库.
- 目前为测试版，可能还有很多问题，会持续更新优化.

- 不改变目标对象的属性类型
- null值不做处理
- 过滤类型不匹配的情况，例如`类型为NSArray，但是JSON数据为字符串的情况`
- 待完善

## 更新记录
### 2018-2-6
- 统一方法的前缀MC

### 2017-10-03
-	统一前缀标识为MC
-	更新readme文件

### 2016-12-24
-   移除类继承的使用方式
-   优化初始化方法
-   修复JSON数据输出不能正确解析keyPath的问题,并增加是否格式化输出的开关

### 2016-12-08
-	增加NSDate支持
-	修复类型不匹配的问题例如：属性定义为NSString但是JSON数据为Number


***

JavaScript Object Notation, or [JSON][], is a lightweight, text-based, serialization format for structured data that is used by many web-based services and API's.  It is defined by [RFC 4627][].

JSON provides the following primitive types:

* `null`
* Boolean `true` and `false`
* Number
* String
* Array
* Object

These primitive types are mapped to the following Objective-C Foundation classes:

JSON               | Objective-C
-------------------|-------------
`null`             | [`nil`]
`true` and `false` | [`NSNumber`] or [`BOOL`]
Number             | [`NSNumber`] or [`NSDate`]
String             | [`NSString`]
Array              | [`NSArray`]
Object             | [`NSDictionary`]

## 如何使用

### 使用Cocoapods
```objc
pod "MCJSONCore", :git => "https://github.com/mylcode/MCJSONKit.git"
```

### 或者导入MJJSONKit文件夹到你的项目
```objc
#import "MCJSONKit.h"
```
# Examples【示例】

### 创建基础模型YourBaseModel并封装【推荐】
```ruby
为了减少代码入侵，方便以后灵活迁移，可按以下方法封装
示例：iOSExample->Weibo->Models->WeiboModel.h（包含MJExtension的实现方式作为对比）
```

```objc
//示例基础模型
@interface YourBaseModel : NSObject

/**
 通过字典创建模型
 
 @param data 许可类型<NSData,NSDictionary,NSString>
 @return 新创建模型对象
 
 */
+ (instancetype)jsonObjectFromData:(id)data;
+ (NSArray *)arrayOfModelsFromDictionaries:(NSArray *)array;

/**
 允许的属性名
 */
+ (NSArray *)allowedPropertyNames;

/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
+ (NSDictionary *)keyMappingDictionary;

/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
+ (NSDictionary *)typeMappingDictionary;

/**
 忽略,不做处理的属性
 */
+ (NSSet *)ignoreSet;

- (NSDictionary *)toDictionary;
- (NSString *)toJSONString;

@end

#import "YourBaseModel.h"

#import "NSObject+MCJSONKit.h"
#import "MJExtension.h"

@implementation YourBaseModel

+ (void)load {
	 //格式化输出JSON数据
    [self setPrettyPrinted:YES];
}

#pragma mark - JSONKit

+ (instancetype)jsonObjectFromData:(id)data {
    return [self mc_objectFromKeyValues:data];
}

+ (NSArray *)arrayOfModelsFromKeyValues:(id)keyValues {
    return [self mc_arrayOfModelsFromKeyValues:keyValues];
}

+ (NSArray *)allowedPropertyNames {
    return nil;
}

+ (NSDictionary *)keyMappingDictionary {
    return nil;
}

+ (NSDictionary *)typeMappingDictionary {
    return nil;
}

+ (NSSet *)ignoreSet {
    return nil;
}

- (NSDictionary *)toDictionary {
    return [self mc_toDictionary];
}

- (NSString *)toJSONString {
    return [self mc_JSONString];
}

#pragma mark JSONKitConfig

+ (NSDictionary *)mc_allowedPropertyNames {
    return nil;
}

+ (NSDictionary *)mc_keyMappingDictionary {
    return [self keyMappingDictionary];
}

+ (NSDictionary *)mc_typeMappingDictionary {
    return [self typeMappingDictionary];
}

+ (NSSet *)mc_ignoreDictionary {
    return [self ignoreSet];
}

@end

```

### JSONString -> Model【简单模型】

```json
{ "id": 10, "country": "Germany", "dialCode": 49, "isInEurope": true }
```

```objc
@interface CountryModel : YourBaseModel
@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *dialCode;
@property (nonatomic) BOOL isInEurope;
@end
```

```objc
CountryModel *country = [CountryModel jsonObjectFromData:jsonString];
```

## JSONString -> Model【模型嵌套】

```json
{
	"orderId": 104,
	"totalPrice": 103.45,
	"products": [
		{
			"id": 123,
			"name": "Product #1",
			"price": 12.95
		},
		{
			"id": 137,
			"name": "Product #2",
			"price": 82.95
		}
	],
    "status":{
        "code":1,
        "msg":"订单已付款"
    }
}
```

```objc
@interface ProductModel : YourBaseModel
@property (nonatomic) NSInteger productId;
@property (nonatomic) NSString *name;
@property (nonatomic) float price;
@end

@interface OrderModel : YourBaseModel
@property (nonatomic) NSInteger orderId;
@property (nonatomic) float totalPrice;
@property (nonatomic, assign) int status;
@property (nonatomic) NSArray *products;
@end
```
### Model name - JSON key mapping【属性和字典的key不同、多级映射】

```objc
@implementation ProductModel
+ (NSDictionary *)keyMappingDictionary {
    return @{@"productID",@"id"};
} 
@end
```

```objc
@implementation OrderModel
+ (NSDictionary *)keyMappingDictionary {
    return @{@"status":@"status.code"};
} 
@end
```

### Model contains model【模型中数组的元素也是模型】

```objc
//模型中有个数组属性，数组元素映射为其他模型
+ (NSDictionary *)typeMappingDictionary {
    return @{@"products":[ProductModel class]};
}
```

### 解析速度对比

[测试数据](Examples/iOSExample/iOSExample/public_timeline.json)

 100次循环解析			| 平均耗时
--------------------|--------------------
`MCJSONKit`    		| 0.283s
`MJExtension` 		| 0.998s

# TODO
- [x] 解析速度对比分析
- [ ] 复杂JSON解析测试
- [ ] 全面覆盖测试，找出BUG

## License

MCJSONKit is available under the MIT license. See the LICENSE file for more info.
 
