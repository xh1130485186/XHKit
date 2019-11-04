//
//  NSString+XHRegex.h
//  GrowthCompass
//
//  Created by 向洪 on 17/4/25.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <Foundation/Foundation.h>


// 判断是否为数字（包括小数）
extern NSString * const XHNumberRegex;

/**
 正则表达式验证
 */
@interface NSString (XHRegex)


/**
 正则表达式验证

 @param regex 正则表达式
 @return 是否有效
 */
- (BOOL)xh_isValidateByRegex:(NSString *)regex;

/**
 手机号码验证：分电信、联通、移动 （更精确）

 @return 是否有效
 */
- (BOOL)xh_isMobileNumberClassification;

/**
 手机号验证

 @return 是否有效
 */
- (BOOL)xh_isMobileNumber;

/**
 邮箱验证

 @return 是否有效
 */
- (BOOL)xh_isEmailAddress;

/**
 身份证的简单验证

 @return 是否有效
 */
- (BOOL)xh_simpleVerifyIdentityCardNum;

/**
 身份证的精确验证

 @param value 身份证号
 @return 是否有效
 */
//+ (BOOL)xh_accurateVerifyIDCardNumber:(NSString *)value;

/**
 车牌号验证

 @return 是否有效
 */
- (BOOL)xh_isCarNumber;

/**
 银行卡号码验证

 @return 是否有效
 */
- (BOOL)xh_bankCardluhmCheck;

/**
 ip地址验证

 @return 是否有效
 */
- (BOOL)xh_isIPAddress;

/**
 mac地址验证

 @return 是否有效
 */
- (BOOL)xh_isMacAddress;

/**
 网址有效性（不包括本地）

 @return 是否有效
 */
- (BOOL)xh_isValidUrl;

/**
 邮政编码验证

 @return 是否有效
 */
- (BOOL)xh_isValidPostalcode;

/**
 纯汉字验证

 @return 是否纯汉字
 */
- (BOOL)xh_isValidChinese;

/**
 纯字母验证

 @return 是否纯字母
 */
- (BOOL)xh_isValidPureLetter;

/**
 工商税号验证

 @return 是否有效
 */
- (BOOL)xh_isValidTaxNo;


/**
 是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字

 @param minLenth 最小长度
 @param maxLenth 最长长度
 @param containChinese 是否包含中文
 @param firstCannotBeDigtal 首字母不能为数字
 @return 是否有效
 */
- (BOOL)xh_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;


/**
 是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字

 @param minLenth 最小长度
 @param maxLenth 最长长度
 @param containChinese 是否包含中文
 @param containDigtal 包含数字
 @param containLetter 包含字母
 @param containOtherCharacter 其他字符
 @param firstCannotBeDigtal 首字母不能为数字
 @return 是否有效
 */
- (BOOL)xh_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLetter:(BOOL)containLetter
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 中国移动号码正则表达式

 @return 正则表达式
 */
+ (NSString *)xh_chinaMobileRegex;

/**
 中国联通号码正则表达式

 @return 正则表达式
 */
+ (NSString *)xh_chinaUnicomRegex;

/**
 中国电信号码正则表达式

 @return 正则表达式
 */
+ (NSString *)xh_chinaTelecomRegex;

/**
 手机号有效性的正则表达式

 @return 正则表达式
 */
+ (NSString *)xh_mobileRegex;

/**
 邮箱有效性的正则表达式

 @return 正则表达式
 */
+ (NSString *)xh_emailAddressRegex;

/**
 身份证的简单验证的正则表达式

 @return 正则表达式
 */
+ (NSString *)xh_simpleVerifyIdentityCardNumRegex;

/**
 车牌号验证的正则表达式
 
 @return 正则表达式
 */
+ (NSString *)xh_carRegex;

/**
 mac地址验证的正则表达式
 
 @return 正则表达式
 */
+ (NSString *)xh_macAddressRegex;

/**
 网址验证的正则表达式（不包括本地文件路径）
 
 @return 正则表达式
 */
+ (NSString *)xh_urlRegex;

/**
 纯中文验证的正则表达式
 
 @return 正则表达式
 */
+ (NSString *)xh_chineseRegex;

/**
 邮政编码验证的正则表达式
 
 @return 正则表达式
 */
+ (NSString *)xh_postalcodeRegex;

/**
 工商号验证的正则表达式
 
 @return 正则表达式
 */
+ (NSString *)xh_taxNoRegex;

/**
 纯字母验证的正则表达式
 
 @return 正则表达式
 */
+ (NSString *)xh_pureLetterRegex;

@end

/**
 *  正则表达式简单说明
 *  语法：
 .       匹配除换行符以外的任意字符
 \w      匹配字母或数字或下划线或汉字
 \s      匹配任意的空白符
 \d      匹配数字
 \b      匹配单词的开始或结束
 ^       匹配字符串的开始
 $       匹配字符串的结束
 *       重复零次或更多次
 +       重复一次或更多次
 ?       重复零次或一次
 {n}     重复n次
 {n,}     重复n次或更多次
 {n,m}     重复n到m次
 \W      匹配任意不是字母，数字，下划线，汉字的字符
 \S      匹配任意不是空白符的字符
 \D      匹配任意非数字的字符
 \B      匹配不是单词开头或结束的位置
 [^x]     匹配除了x以外的任意字符
 [^aeiou]匹配除了aeiou这几个字母以外的任意字符
 *?      重复任意次，但尽可能少重复
 +?      重复1次或更多次，但尽可能少重复
 ??      重复0次或1次，但尽可能少重复
 {n,m}?     重复n到m次，但尽可能少重复
 {n,}?     重复n次以上，但尽可能少重复
 \a      报警字符(打印它的效果是电脑嘀一声)
 \b      通常是单词分界位置，但如果在字符类里使用代表退格
 \t      制表符，Tab
 \r      回车
 \v      竖向制表符
 \f      换页符
 \n      换行符
 \e      Escape
 \0nn     ASCII代码中八进制代码为nn的字符
 \xnn     ASCII代码中十六进制代码为nn的字符
 \unnnn     Unicode代码中十六进制代码为nnnn的字符
 \cN     ASCII控制字符。比如\cC代表Ctrl+C
 \A      字符串开头(类似^，但不受处理多行选项的影响)
 \Z      字符串结尾或行尾(不受处理多行选项的影响)
 \z      字符串结尾(类似$，但不受处理多行选项的影响)
 \G      当前搜索的开头
 \p{name}     Unicode中命名为name的字符类，例如\p{IsGreek}
 (?>exp)     贪婪子表达式
 (?<x>-<y>exp)     平衡组
 (?im-nsx:exp)     在子表达式exp中改变处理选项
 (?im-nsx)       为表达式后面的部分改变处理选项
 (?(exp)yes|no)     把exp当作零宽正向先行断言，如果在这个位置能匹配，使用yes作为此组的表达式；否则使用no
 (?(exp)yes)     同上，只是使用空表达式作为no
 (?(name)yes|no) 如果命名为name的组捕获到了内容，使用yes作为表达式；否则使用no
 (?(name)yes)     同上，只是使用空表达式作为no
 
 捕获
 (exp)               匹配exp,并捕获文本到自动命名的组里
 (?<name>exp)        匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
 (?:exp)             匹配exp,不捕获匹配的文本，也不给此分组分配组号
 零宽断言
 (?=exp)             匹配exp前面的位置
 (?<=exp)            匹配exp后面的位置
 (?!exp)             匹配后面跟的不是exp的位置
 (?<!exp)            匹配前面不是exp的位置
 注释
 (?#comment)         这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读
 
 *  表达式：\(?0\d{2}[) -]?\d{8}
 *  这个表达式可以匹配几种格式的电话号码，像(010)88886666，或022-22334455，或02912345678等。
 *  我们对它进行一些分析吧：
 *  首先是一个转义字符\(,它能出现0次或1次(?),然后是一个0，后面跟着2个数字(\d{2})，然后是)或-或空格中的一个，它出现1次或不出现(?)，
 *  最后是8个数字(\d{8})
 */

/*
 
 验证数字：^[0-9]*$
 验证n位的数字：^\d{n}$
 验证至少n位数字：^\d{n,}$
 验证m-n位的数字：^\d{m,n}$
 验证数字和小数点:^[0-9]+([.]{0}|[.]{1}[0-9]+)$
 验证零和非零开头的数字：^(0|[1-9][0-9]*)$
 验证有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
 验证有1-3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
 验证非零的正整数：^\+?[1-9][0-9]*$
 验证非零的负整数：^\-[1-9][0-9]*$
 验证非负整数（正整数 + 0）  ^\d+$
 验证非正整数（负整数 + 0）  ^((-\d+)|(0+))$
 验证长度为3的字符：^.{3}$
 验证由26个英文字母组成的字符串：^[A-Za-z]+$
 验证由26个大写英文字母组成的字符串：^[A-Z]+$
 验证由26个小写英文字母组成的字符串：^[a-z]+$
 验证由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$
 验证由数字、26个英文字母或者下划线组成的字符串：^\w+$
 验证用户密码:^[a-zA-Z]\w{5,17}$ 正确格式为：以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 验证是否含有 ^%&',;=?$\" 等字符：[^%&',;=?$\x22]+
 验证汉字：^[\u4e00-\u9fa5],{0,}$
 验证Email地址：^\w+[-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$
 验证InternetURL：^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$
 验证电话号码：^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$：--正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX。
 验证电话号码及手机:（\d{3}-\d{8}|\d{4}-\d{7}）｜（^((\(\d{3}\))|(\d{3}\-))?13\d{9}|15[89]\d{8}$）
 验证身份证号（15位或18位数字）：^\d{15}|\d{}18$
 验证一年的12个月：^(0?[1-9]|1[0-2])$ 正确格式为：“01”-“09”和“1”“12”
 验证一个月的31天：^((0?[1-9])|((1|2)[0-9])|30|31)$    正确格式为：01、09和1、31。
 整数：^-?\d+$
 非负浮点数（正浮点数 + 0）：^\d+(\.\d+)?$
 正浮点数   ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
 非正浮点数（负浮点数 + 0） ^((-\d+(\.\d+)?)|(0+(\.0+)?))$
 负浮点数  ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
 浮点数  ^(-?\d+)(\.\d+)?$
 
 */

/*
 
 匹配中文字符的正则表达式： [\u4e00-\u9fa5]
 评注：匹配中文还真是个头疼的事，有了这个表达式就好办了
 
 匹配双字节字符(包括汉字在内)：[^\x00-\xff]
 评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
 
 匹配空白行的正则表达式：\n\s*\r
 评注：可以用来删除空白行
 
 匹配HTML标记的正则表达式：<(\S*?)[^>]*>.*?</\1>|<.*? />
 评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧没有能力为力
 
 匹配首尾空白字符的正则表达式：^\s*|\s*$
 评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
 
 匹配Email地址的正则表达式：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
 评注：表单验证时很实用
 
 匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
 评注：网上流传的版本功能很有限，上面这个基本可以满足需求
 
 匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 评注：表单验证时很实用
 
 匹配国内电话号码：\d{3}-\d{8}|\d{4}-\d{7}
 评注：匹配形式如 0511-4405222 或 021-87888822
 
 匹配腾讯QQ号：[1-9][0-9]{4,}
 评注：腾讯QQ号从10000开始
 
 匹配中国邮政编码：[1-9]\d{5}(?!\d)
 评注：中国邮政编码为6位数字
 
 匹配身份证：\d{15}|\d{18}
 评注：中国的身份证为15位或18位
 
 匹配ip地址：\d+\.\d+\.\d+\.\d+
 评注：提取ip地址时有用
 
 匹配特定数字：
 ^[1-9]\d*$　 　 //匹配正整数
 ^-[1-9]\d*$ 　 //匹配负整数
 ^-?[1-9]\d*$　　 //匹配整数
 ^[1-9]\d*|0$　 //匹配非负整数（正整数 + 0）
 ^-[1-9]\d*|0$　　 //匹配非正整数（负整数 + 0）
 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$　　 //匹配正浮点数
 ^-([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$　 //匹配负浮点数
 ^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$　 //匹配浮点数
 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$　　 //匹配非负浮点数（正浮点数 + 0）
 ^(-([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$　　//匹配非正浮点数（负浮点数 + 0）
 评注：处理大量数据时有用，具体应用时注意修正
 
 匹配特定字符串：
 ^[A-Za-z]+$　　//匹配由26个英文字母组成的字符串
 ^[A-Z]+$　　//匹配由26个英文字母的大写组成的字符串
 ^[a-z]+$　　//匹配由26个英文字母的小写组成的字符串
 ^[A-Za-z0-9]+$　　//匹配由数字和26个英文字母组成的字符串
 ^\w+$　　//匹配由数字、26个英文字母或者下划线组成的字符串
 
 匹配中文:[\u4e00-\u9fa5]
 
 英文字母:[a-zA-Z]
 
 数字:[0-9]
 
 匹配中文，英文字母和数字及_:
 ^[\u4e00-\u9fa5_a-zA-Z0-9]+$
 
 同时判断输入长度：
 [\u4e00-\u9fa5_a-zA-Z0-9_]{4,10}
 
 ^[\w\u4E00-\u9FA5\uF900-\uFA2D]*$ 1、一个正则表达式，只含有汉字、数字、字母、下划线不能以下划线开头和结尾：
 ^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$  其中：
 ^  与字符串开始的地方匹配
 (?!_)　　不能以_开头
 (?!.*?_$)　　不能以_结尾
 [a-zA-Z0-9_\u4e00-\u9fa5]+　　至少一个汉字、数字、字母、下划线
 $　　与字符串结束的地方匹配
 
 放在程序里前面加@，否则需要\\进行转义 @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$"
 （或者：@"^(?!_)\w*(?<!_)$"    或者  @" ^[\u4E00-\u9FA50-9a-zA-Z_]+$ "  )
 
 2、只含有汉字、数字、字母、下划线，下划线位置不限：
 ^[a-zA-Z0-9_\u4e00-\u9fa5]+$
 
 3、由数字、26个英文字母或者下划线组成的字符串
 ^\w+$
 
 4、2~4个汉字
 @"^[\u4E00-\u9FA5]{2,4}$";
 
 5、
 ^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$
 
 用：(Abc)+    来分析：  XYZAbcAbcAbcXYZAbcAb
 
 XYZAbcAbcAbcXYZAbcAb6、
 [^\u4E00-\u9FA50-9a-zA-Z_]
 34555#5' -->34555#5'
 
 [\u4E00-\u9FA50-9a-zA-Z_]    eiieng_89_   --->   eiieng_89_
 _';'eiieng_88&*9_    -->  _';'eiieng_88&*9_
 _';'eiieng_88_&*9_  -->  _';'eiieng_88_&*9_
 
 最长不得超过7个汉字，或14个字节(数字，字母和下划线)正则表达式
 ^[\u4e00-\u9fa5]{1,7}$|^[\dA-Za-z_]{1,14}$
 ///----------2014.10.07 再次编辑----------------
 匹配月份的正则表达式
 ^[1-9]$|^1[0-2]$
 
 注：个位数月份匹配方式 前面不能加 0。
 
 ^0?[1-9]$|^1[0-2]$
 
 注：个位数月份前可以加0或者不加。
 
 匹配年份19**或者20**
 
 ^(19|20)[0-9]{2}$
 */
