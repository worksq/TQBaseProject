//
//  NSString+Extension.m
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

+(NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time{
    
    int minute = (int)time / 60;
    int second = (int)time % 60;
    
    if (second > 9) { //2:10
        return [NSString stringWithFormat:@"%d:%d",minute,second];
    }
    
    //2:09
    return [NSString stringWithFormat:@"%d:0%d",minute,second];
}
- (NSString*)md5Encode{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]] lowercaseString];
}

//- (NSData *)HMACSHA1WithKey:(NSString *)key
//{
//    return [[self dataUsingEncoding:NSUTF8StringEncoding] HMACSHA1WithKey:key];
//}

- (NSString*)subSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
- (NSString*)SPbad{
    return  [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString*)urlEncode
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), kCFStringEncodingUTF8));
}

- (NSString *)urlDecode
{
    // bug fix : 将+转换为空格
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)[result mutableCopy], CFSTR(""), kCFStringEncodingUTF8));
}

- (NSDictionary*)parseURLParams {
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if ([kv count] != 2) continue;
        
        NSString *val =
        [[kv objectAtIndex:1]
         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}

- (BOOL)isMobileNumber {
    NSString *stricterFilterString = @"^1[3-8]\\d{9}$";
    NSPredicate *mtNickNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [mtNickNameTest evaluateWithObject:self];
}
- (BOOL)hd_isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSString *)realPath {
    NSURL* url = [NSURL URLWithString:self];
    if (nil == url) return nil;
    
    NSString* realPath = nil;
    if ([url.scheme isEqualToString:@"bundle"]) {
        NSString* filePath = [NSString stringWithFormat:@"%@%@", url.host, url.path];
        realPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:filePath];
    }
    else if ([url.scheme isEqualToString:@"document"]) {
        // 从app的document里面获取文件
        NSString* filePath = [NSString stringWithFormat:@"%@%@", url.host, url.path];
        /// get the document folder;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        /// add file relative path;
        realPath = [docDir stringByAppendingPathComponent:filePath];
    }
    
    return realPath;
}

- (BOOL)isFilePath{
    NSRange range = [self rangeOfString:@"/"];
    if (range.length>0) {
        return YES;
    }else
        return NO;
}


- (CGSize)getTextSizeWithContentSize:(CGSize)contentSize fontofSize:(NSInteger)fontOfSize{
    UIFont *font = [UIFont systemFontOfSize:fontOfSize];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:contentSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    size = CGSizeMake(size.width, size.height);
    return size;
}
- (CGSize)getTextSizeWithContentSize:(CGSize)contentSize fon:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:contentSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    size = CGSizeMake(size.width, size.height);
    return size;
}
- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString
{
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    return subStringsArray;
}

/**
 *  快速返回沙盒中，Documents文件的路径
 *
 *  @return Documents文件的路径
 */
+ (NSString *)hd_pathForDocuments
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  快速返回Documents文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Documents文件中某个子文件的路径
 */
+ (NSString *)hd_filePathAtDocumentsWithFileName:(NSString *)fileName
{
    return  [[self hd_pathForDocuments] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回沙盒中Library下Caches文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)hd_pathForCaches
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)hd_filePathAtCachesWithFileName:(NSString *)fileName
{
    return [[self hd_pathForCaches] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回MainBundle(资源捆绑包的)的路径
 *
 *  @return 快速返回MainBundle(资源捆绑包的)的路径
 */
+ (NSString *)hd_pathForMainBundle
{
    return [NSBundle mainBundle].bundlePath;
}

/**
 *  快速返回MainBundle(资源捆绑包的)下文件的路径
 *
 *  @param fileName MainBundle(资源捆绑包的)下的文件名
 *
 *  @return 快速返回MainBundle(资源捆绑包的)下文件的路径
 */
+ (NSString *)hd_filePathAtMainBundleWithFileName:(NSString *)fileName
{
    return [[self hd_pathForMainBundle] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回沙盒中tmp(临时文件)文件的路径
 *
 *  @return 快速返回沙盒中tmp文件的路径
 */
+ (NSString *)hd_pathForTemp
{
    return NSTemporaryDirectory();
}

/**
 *  快速返回沙盒中，temp文件中某个子文件的路径
 *
 *  @param fileName 子文件名
 *
 *  @return 快速返回temp文件中某个子文件的路径
 */
+ (NSString *)hd_filePathAtTempWithFileName:(NSString *)fileName
{
    return [[self hd_pathForTemp] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回沙盒中，Library下Preferences文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)hd_pathForPreferences
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  快速返回沙盒中，Library下Preferences文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Preferences文件中某个子文件的路径
 */
+ (NSString *)hd_filePathAtPreferencesWithFileName:(NSString *)fileName
{
    return [[self hd_pathForPreferences] stringByAppendingPathComponent:fileName];
}

/**
 *  快速你指定的系统文件的路径
 *
 *  @param directory NSSearchPathDirectory枚举
 *
 *  @return 快速你指定的系统文件的路径
 */
+ (NSString *)hd_pathForSystemFile:(NSSearchPathDirectory)directory
{
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject];
}

/**
 *  快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName
 *
 *  @param directory 你指的的系统文件
 *  @param fileName  子文件名
 *
 *  @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)hd_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName
{
    return [[self hd_pathForSystemFile:directory] stringByAppendingPathComponent:fileName];
}


- (NSString *)hd_md5String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, length, bytes);
    
    return [self hd_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hd_sha1String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, length, bytes);
    
    return [self hd_stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)hd_sha256String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, length, bytes);
    
    return [self hd_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)hd_sha512String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(str, length, bytes);
    
    return [self hd_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hd_stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    return [strM copy];
}

- (NSString *)hd_base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)hd_base64Decode
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(NSMutableAttributedString *)getAttributedStringandKey:(NSArray *)keyarray{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self];
    NSMutableArray *rangeArr = [NSMutableArray array];
    for (NSString *keyw in keyarray) {
        NSString *strTemp=keyw;
        if (keyarray && self) {
            if ([self length]>[keyw length]) {
                for (int i=0; i<[self length]-[keyw length]; i++) {
                    NSRange strRange=NSMakeRange(i,[keyw length]);
                    NSString *str=[self substringWithRange:strRange];
                    if ([str isEqualToString:strTemp]) {
                        NSValue *value=[NSValue valueWithRange:strRange];
                        [rangeArr addObject:value];
                    }
                    
                }
            }
            
        }
    }
    for (NSValue *value in rangeArr) {
        NSRange keywordRange=[value rangeValue];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:keywordRange];
    }
    return attrString;
    
}






@end
