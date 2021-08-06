//
//  APIManager.h
//  PartyPlay
//
//  Created by Santino L Ramos on 8/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APIManager <NSObject>

- (void)authWithAPI;

- (void)searchWithAPI:(NSString *)query withCompletion:(void(^)(NSMutableArray *results, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
