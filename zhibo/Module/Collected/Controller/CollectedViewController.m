//
//  CollectedViewController.m
//  zhibo
//
//  Created by K.Lam on 2017/3/3.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "CollectedViewController.h"
#import "AFNetworking.h"

@interface CollectedViewController ()

@end

@implementation CollectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];

}



/**
 *  上传带图片的内容，允许多张图片上传（URL）POST
 *
 *  @param url                 网络请求地址
 *  @param images              要上传的图片数组（注意数组内容需是图片）
 *  @param parameter           图片数组对应的参数
 *  @param parameters          其他参数字典
 *  @param ratio               图片的压缩比例（0.0~1.0之间）
 *  @param succeedBlock        成功的回调
 *  @param failedBlock         失败的回调
 *  @param uploadProgressBlock 上传进度的回调
 */

- (void)startMultiPartUploadTaskWithURL:(NSString *)url
                            imagesArray:(NSArray *)images
                      parameterOfimages:(NSString *)parameter
                         parametersDict:(NSDictionary *)parameters
                       compressionRatio:(float)ratio
                           succeedBlock:(void (^)(id _Nonnull, id _Nonnull))succeedBlock
                            failedBlock:(void (^)(id _Nonnull, NSError * _Nonnull))failedBlock
                    uploadProgressBlock:(void (^)(float, long long, long long))uploadProgressBlock{
    
    //    if (images.count == 0) {
    //        NSLog(@"上传内容没有包含图片");
    //        return;
    //    }
    for (int i = 0; i < images.count; i++) {
        if (![images[i] isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
            return;
        }
    }
    AFHTTPSessionManager *operation = [AFHTTPSessionManager manager];
    operation.responseSerializer = [AFJSONResponseSerializer serializer]; // 申明返回的结果是json类型
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 1;
        //根据当前系统时间生成图片名称
        //        NSDate *date = [NSDate date];
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        //        [formatter setDateFormat:@"yyyy年MM月dd日"];
        //        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"image%d.png",i];
            NSString * nameStr = [NSString stringWithFormat:@"%@%d",parameter, i];
            NSData *imageData;
            if (ratio > 0.0f && ratio < 1.0f) {
                imageData = UIImageJPEGRepresentation(image, ratio);
            }else{
                imageData = UIImageJPEGRepresentation(image, 1.0f);
            }
            
            [formData appendPartWithFileData:imageData name:nameStr fileName:fileName mimeType:@"image/jpeg"];
            i++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgressBlock( uploadProgress.fractionCompleted ,uploadProgress.totalUnitCount,uploadProgress.completedUnitCount );
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(operation,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failedBlock(operation,error);
        
    }];
    
}



@end
