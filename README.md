# COJSONCore
非侵入式JSON转换框架,方便灵活迁移

## 基本用法

```json
{ "id": 10, "country": "Germany", "dialCode": 49, "isInEurope": true }
```
- [可选]为了降低代码侵入，首先创建继承自JSONCore的基类JSONCoreBase，迁移时修改此类即可
- 创建需Model对象类CountryModel
```objc
@interface CountryModel : JSONCoreBase
@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *dialCode;
@property (nonatomic) BOOL isInEurope;
@end
```

将JSON数据转换为Model对象

```objc
CountryModel *country = [CountryModel objectFromJSONString:myJson];
```

## 关系映射

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
	]
}
```
```objc
@interface ProductModel : JSONCoreBase
@property (nonatomic) NSInteger productId;
@property (nonatomic) NSString *name;
@property (nonatomic) float price;
@end

@interface OrderModel : JSONCoreBase
@property (nonatomic) NSInteger orderId;
@property (nonatomic) float totalPrice;
@property (nonatomic) NSArray *products;
@end

```

### key嵌套映射
```objc
@implementation ProductModel

- (NSDictionary *)keyMappingDictionary {
    return @{@"productId":@"id"};
}

@end
```
### Model嵌套
```objc
@implementation OrderModel

- (NSDictionary *)typeMappingDictionary {
    return @{@"products":[ProductModel class]};
}

@end
```
