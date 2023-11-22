//
//  RegressionWrapper.h
//  athena
//
//  Created by david Chiu on 12/20/21.
//

#import <Foundation/Foundation.h>
@interface RegressionWrapper : NSObject
- (void) trainWith: (float*)x andY:(float*)y;
- (float) predictWith: (float*)x;
- (void) logisticRegressionTest;
- (void) gradientDescentTest;
- (void) multiRegressionTest;
- (NSMutableArray*) gradientDescentWithX: (const float[])x andLabel: (const float[])y size: (int)size;
- (NSMutableArray*) gradientDescentWithX: (const float[])x feature: (const float[])featureData andLabel: (const float[])y size: (int)size;
- (NSMutableArray*) gradientDescentMulti: (const float[])x feature: (const float[])featureData andLabel: (const float[])y size: (int)size nFeature: (int)nFeature batch:(int) nBatch step: (float)step weight:(const float[])weight lamda: (const double)lamda;
- (NSMutableArray*) matrixInversion: (const float[])x feature: (const float[])featureData andLabel: (const float[])y size: (int)size nFeature:(int)nFeature;

@end
