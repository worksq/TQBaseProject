//
//  NSString+Extension.h
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  返回分与秒的字符串 如:01:60
 */
+(NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time;


// encode
- (NSString*)md5Encode;
//- (NSData *)HMACSHA1WithKey:(NSString *)key;

- (NSString*)subSpace;
/**
 *  去空格
 *
 *  @return 
 */
- (NSString*)SPbad;
- (NSString*)urlEncode;
- (NSString *)urlDecode;
- (NSDictionary*)parseURLParams;
- (BOOL)isMobileNumber;
- (BOOL)isEmail;

- (NSString*)realPath;
- (BOOL)isFilePath;

- (CGSize)getTextSizeWithContentSize:(CGSize)contentSize fontofSize:(NSInteger)fontOfSize;
- (CGSize)getTextSizeWithContentSize:(CGSize)contentSize fon:(UIFont *)font;
/**
 *  返回高亮字体
 *
 *  @param self     所有的文字
 *  @param keyarray 关键字数组
 *
 *  @return 返回高亮字体
 */
-(NSMutableAttributedString *)getAttributedStringandKey:(NSArray *)keyarray;
/**
 *  字符串截取
 *
 *  @param fromString 开始截取的字段
 *  @param toString   结束截取的字段
 *
 *  @return 截取完成的数组
 */
- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;

#pragma mark===========路径相关=================
/**
 *  快速返回沙盒中，Documents文件的路径
 *
 *  @return Documents文件的路径
 */
+ (NSString *)hd_pathForDocuments;

/**
 *  快速返回沙盒中，Documents文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Documents文件中某个子文件的路径
 */
+ (NSString *)hd_filePathAtDocumentsWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，Library下Caches文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)hd_pathForCaches;

/**
 *  快速返回沙盒中，Library下Caches文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Caches文件中某个子文件的路径
 */
+ (NSString *)hd_filePathAtCachesWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，MainBundle(资源捆绑包的)的路径
 *
 *  @return 快速返回MainBundle(资源捆绑包的)的路径
 */
+ (NSString *)hd_pathForMainBundle;

/**
 *  快速返回沙盒中，MainBundle(资源捆绑包的)中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回MainBundle(资源捆绑包的)中某个子文件的路径
 */
+ (NSString *)hd_filePathAtMainBundleWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，tmp(临时文件)文件的路径
 *
 *  @return 快速返回沙盒中tmp文件的路径
 */
+ (NSString *)hd_pathForTemp;

/**
 *  快速返回沙盒中，temp文件中某个子文件的路径
 *
 *  @param fileName 子文件名
 *
 *  @return 快速返回temp文件中某个子文件的路径
 */
+ (NSString *)hd_filePathAtTempWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，Library下Preferences文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)hd_pathForPreferences;

/**
 *  快速返回沙盒中，Library下Preferences文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Preferences文件中某个子文件的路径
 */
+ (NSString *)hd_filePathAtPreferencesWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
 *
 *  @param directory NSSearchPathDirectory枚举
 *
 *  @return 快速你指定的系统文件的路径
 */
+ (NSString *)hd_pathForSystemFile:(NSSearchPathDirectory)directory;

/**
 *  快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName
 *
 *  @param directory 你指的的系统文件
 *  @param fileName  子文件名
 *
 *  @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)hd_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName;



#pragma mark===========加密相关=================
/**
 * 命令行测试命令
 *
 *  MD5
 *  $ echo -n abc | openssl md5
 *  SHA1
 *  $ echo -n abc | openssl sha1
 *  SHA256
 *  $ echo -n abc | openssl sha -sha256
 *  SHA512
 *  $ echo -n abc | openssl sha -sha512
 *  BASE64编码(abc)
 *  $ echo -n abc | base64
 *
 *  BASE64解码(YWJj，abc的编码)
 *  $ echo -n YWJj | base64 -D
 */

/**
 *  返回md5加密后的字符串
 */
@property (nonatomic, readonly) NSString *hd_md5String;

/**
 *  返回sha1遍吗后的字符串
 */
@property (nonatomic, readonly) NSString *hd_sha1String;

/**
 *  返回sha256遍吗后的字符串
 */
@property (nonatomic, readonly) NSString *hd_sha256String;

/**
 *  返回sha512遍吗后的字符串
 */
@property (nonatomic, readonly) NSString *hd_sha512String;

/**
 *  返回Base64遍吗后的字符串
 */
@property (nonatomic, readonly) NSString *hd_base64Encode;

/**
 *  返回Base64解码后的字符串
 */
@property (nonatomic, readonly) NSString *hd_base64Decode;
@end


