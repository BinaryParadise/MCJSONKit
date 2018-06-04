# MCJSONKit

[![Build Status](https://travis-ci.org/MC-Studio/MCJSONKit.svg?branch=master)](https://travis-ci.org/MC-Studio/MCJSONKit)
[![Coverage Status](https://coveralls.io/repos/github/MC-Studio/MCJSONKit/badge.svg)](https://coveralls.io/github/MC-Studio/MCJSONKit)
[![Version](https://img.shields.io/cocoapods/v/MCJSONKit.svg?style=flat)](http://cocoapods.org/pods/MCJSONKit)
[![License](https://img.shields.io/cocoapods/l/MCJSONKit.svg?style=flat)](http://cocoapods.org/pods/MCJSONKit)
[![Platform](https://img.shields.io/cocoapods/p/MCJSONKit.svg?style=flat)](http://cocoapods.org/pods/MCJSONKit)

- A fast, convenient and nonintrusive conversion between JSON and model.
- 转换速度快、使用简单方便的字典转模型框架

# 目录

* [NSJSONReadingOptions & NSJSONWritingOptions](#jsonreadwriter)
* [更新记录](CHANGELOG.md)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 水平有限，不定期更新
- 一直是拿来主义用的第三方库，总是发现一些不灵活或者不足、不适用的地方，所以自己心血来潮写一个轻量的JSON对象转换库.
- 目前为测试版，可能还有很多问题，会持续更新优化.

- 不改变目标对象的属性类型
- null值不做处理,保持属性的默认值
- 过滤类型不匹配的情况，例如`类型为NSArray，但是JSON数据为字符串的情况`
- `代码覆盖率100`
- 待完善

***

JavaScript Object Notation, or [JSON][], is a lightweight, text-based, serialization format for structured data that is used by many web-based services and API's.  It is defined by [RFC 4627](https://www.ietf.org/rfc/rfc4627.txt).

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

## <span id='jsonreadwriter'>NSJSONReadingOptions</span>

```objc
NSJSONReadingMutableContainers	// 返回可变容器，NSMutableDictionary或NSMutableArray
NSJSONReadingMutableLeaves			// 不仅返回的最外层是可变的, 内部的子数值或字典也是可变对象
NSJSONReadingAllowFragments		// 返回允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment.可以是例如 "10"
```

## NSJSONWritingOptions

```objc
NSJSONWritingPrettyPrinted = (1UL << 0) //是将生成的json数据格式化输出，这样可读性高，不设置则输出的json字符串就是一整行。
NSJSONWritingSortedKeys //输出的json字符串就是一整行
```

## 如何使用

MCJSONKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MCJSONKit"
```

```objc
#import <MCJSONKit/MCJSONKit.h>
```

或者导入MJJSONKit文件夹到你的项目

```objc
#import "MCJSONKit.h"
```
# Examples【示例】

### 创建基础模型YourBaseModel并封装【推荐】
```ruby
使用时再封装一层，方便以后迁移
示例：iOSExample->Weibo->Models->WeiboModel.h（包含MJExtension的实现方式作为对比）
```

```objc
#import <MCJSONKit/MCJSONKit.h>

//示例基础模型
@interface YourBaseJSONModel : NSObject

/**
 通过字典创建模型
 
 @param data 许可类型<NSData,NSDictionary,NSString>
 @return 新创建模型对象
 
 */
+ (instancetype)jsonObjectFromData:(id)data;
+ (NSArray *)arrayOfModelsFromKeyValues:(id)keyValues;

/**
 允许的属性集合，配置后则ignoreSet失效
 */
- (NSSet *)allowedPropertyNames;

/**
 忽略的属性集合
 */
- (NSSet *)ignoreSet;

/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
- (NSDictionary *)keyMappingDictionary;

/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
- (NSDictionary *)typeMappingDictionary;
- (NSDictionary *)toDictionary;
- (NSString *)toJSONString;

@end

#import "YourBaseModel.h"

#import "NSObject+MCJSONKit.h"
#import "MJExtension.h"

@implementation YourBaseModel

+ (void)load {
    //格式化输出JSON字符串，默认为NO
    [self setPrettyPrinted:YES];
}
    
- (void)setCreated_at:(NSString *)created_at {
    NSDateFormatter *dateFmt = [NSDateFormatter new];
    dateFmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dateFmt.locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
    
    NSDate *date = [dateFmt dateFromString:created_at];
    _created_at = @(date.timeIntervalSince1970).stringValue;
}

#pragma mark - 二次封装JSONKit

+ (instancetype)jsonObjectFromData:(id)data {
    return [self mc_objectFromKeyValues:data];
}

+ (NSArray *)arrayOfModelsFromKeyValues:(id)keyValues {
    return [self mc_arrayOfModelsFromKeyValues:keyValues];
}

- (NSSet *)allowedPropertyNames {
    return nil;
}

- (NSDictionary *)keyMappingDictionary {
    return nil;
}

- (NSDictionary *)typeMappingDictionary {
    return nil;
}

- (NSSet *)ignoreSet {
    return nil;
}

- (NSDictionary *)toDictionary {
    return [self mc_toDictionary];
}

- (NSString *)toJSONString {
    return [self mc_JSONString];
}

#pragma mark JSONCoreConfig

- (NSSet *)mc_allowedPropertiesSet {
    return [self allowedPropertyNames];
}

- (NSDictionary *)mc_keyMappingDictionary {
    return [self keyMappingDictionary];
}

- (NSDictionary *)mc_typeMappingDictionary {
    return [self typeMappingDictionary];
}

- (NSSet *)mc_ignorePropertiesSet {
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
@property (nonatomic) NSArray<ProductModel *> *products;
@end
```
### Model name - JSON key mapping【属性和字典的key不同、多级映射】

```objc
@implementation ProductModel
- (NSDictionary *)keyMappingDictionary {
    return @{MCProperty(productID):@"id"};
} 
@end
```

```objc
@implementation OrderModel
- (NSDictionary *)keyMappingDictionary {
    return @{MCProperty(status):@"status.code"};
} 
@end
```

### Model contains array model【包含模型数组】

```objc
//模型中有个数组属性，数组元素映射为其他模型
- (NSDictionary *)typeMappingDictionary {
    return @{MCProperty(products):[ProductModel class]};
}
```

### 解析速度对比

[mock数据](Example/Tests/mock/public_timeline.json)

 100次循环解析			| 平均耗时
--------------------|--------------------
`MCJSONKit`    		| 0.415s
`MJExtension` 		| 0.626s

# TODO
- [x] 解析速度对比分析
- [x] 复杂JSON解析测试
- [x] 全面覆盖测试，找出BUG

## License

MCJSONKit is available under the MIT license. See the LICENSE file for more info.
 
