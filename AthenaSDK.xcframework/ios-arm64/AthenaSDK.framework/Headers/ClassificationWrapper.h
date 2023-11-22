//
//  ClassificationWrapper.h
//  athena
//
//  Created by david Chiu on 3/17/22.
//  Copyright © 2022 Athena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassificationWrapper : NSObject {
}

- (int) dataTest;
- (int) loadDTWModel: (const char* _Nonnull)file;
- (NSMutableArray*) DTWClassify: (float* _Nonnull * _Nonnull)input size: (int)size dimension:(int)col withTimeStamp: (BOOL)flag;
- (void) dtwTest;
- (NSMutableArray* _Nullable) HMMClassify: (float* _Nonnull * _Nonnull)input size: (int)size dimension:(int)col;
+ (NSMutableArray* _Nullable) DTClassify: (const float []) input size: (int)size model:(int)type;
+ (NSMutableArray* _Nullable) getFFTFeatures: (const float []) input size:(int)row ;
+ (NSMutableArray* _Nullable) getFFTFeatures: (const float ) input;
+ (NSMutableArray* _Nullable) getFFT: (const float ) input;
+ (NSMutableArray* _Nullable) getFFT: (const float [_Nonnull]) input size: (int)size;
+ (NSMutableArray* _Nullable) RFClassify: (const float []) input size: (int)size ;
+ (NSMutableArray* _Nullable) SVMClassify: (const float []) input size: (int)size ;
+ (void)initBrowsingDTModel;
+ (NSMutableArray* _Nullable) DTBrowsingModelClassify: (const float []) input size: (int)size ;
+ (NSMutableArray* _Nullable) eyeGestureClassify: (const float []) input size: (int)size;
+ (void*) newRFClassifier: (const char*)model;
+ (NSMutableArray* _Nullable) eyeGestureClassifyWithModel: (void*)mode input:(const float []) input size: (int)size;
@end

