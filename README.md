# JSONCore
## 水平有限，欢迎各位大牛批评指教
- 一直是拿来主义用的第三方库，总是发现一些不灵活或者不足、不适用的地方，所以自己心血来潮写一个轻量的JSON对象转换库。
- 目前为测试版，可能还有很多问题，找工作中暂时没啥心情，也许会维护更新，学习研究才能进步。

- 不改变目标对象的属性类型
- null值不做处理
- 过滤类型不匹配的情况，例如`类型为NSArray，但是JSON数据为字符串的情况`
- 使用时建议创建一个继承自JSONCore的基类，然后所有的Model基础这个基类，方便后续迁移
- 待完善

## 更新记录
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

## 基本用法

```json
    为了减少代码入侵可以创建一个封装JSONCore的基类,详见示例项目iOSExample->Weibo->Models->WeiboModel.h
    其中也封装了MJExtension的实现方式，作为对比可以无缝切换
``` 

```objc
导入JSONCore文件夹到你的项目，并引用：
#import "NSObject+JSONCore.h"
```

JSONString -> Model【简单模型】

```json
{ "id": 10, "country": "Germany", "dialCode": 49, "isInEurope": true }
```

```objc
@interface CountryModel : WeiboModel
@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *dialCode;
@property (nonatomic) BOOL isInEurope;
@end
```

```objc
CountryModel *country = [CountryModel objectFromJSONString:myJson];
```

JSONString -> Model【模型嵌套】

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
    status:{
        "code":1,
        "msg":"订单已付款"
    }
}
```

```objc
@interface ProductModel : WeiboModel
@property (nonatomic) NSInteger productId;
@property (nonatomic) NSString *name;
@property (nonatomic) float price;
@end

@implementation ProductModel

//模型中的属性名和字典中的key不同
+ (NSDictionary *)keyMappingDictionary {
    return @{@"productId":@"id"};
}

@interface OrderModel : WeiboModel
@property (nonatomic) NSInteger orderId;
@property (nonatomic) float totalPrice;
@property (nonatomic, assign) int status;
@property (nonatomic) NSArray *products;
@end

@implementation OrderModel

//key多级映射
+ (NSDictionary *)keyMappingDictionary {
    return @{@"status":@"status.code"};
} 

//模型中有个数组属性，数组元素映射为其他模型
+ (NSDictionary *)typeMappingDictionary {
    return @{@"products":[ProductModel class]};
}

```

# TODO
- [ ] 复杂JSON解析测试
- [x] 解析速度对比分析
- [ ] 全面覆盖测试，找出BUG
