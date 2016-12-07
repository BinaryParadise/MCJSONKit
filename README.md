# COJSONCore
非侵入式JSON转换框架,方便灵活迁移

## 基本用法

<p>具体可参考示例：COTestModel.h
</p>

### JSON数据定义
```json
{ "id": 10, "country": "Germany", "dialCode": 49, "isInEurope": true }
```
- 创建继承自JSONCore的基类，最低代码侵入
- 创建需要解析的目标对象类
```objc
@interface CountryModel : [JSONCore](可以是你的自定义并继承自JSONCore的基类减少代码侵入)
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
