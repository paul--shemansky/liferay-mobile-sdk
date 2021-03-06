/**
 * Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

#import "LRBaseService.h"

/**
 * @author Bruno Farache
 */
@interface LRMembershipRequestService_v62 : LRBaseService

- (NSDictionary *)addMembershipRequestWithGroupId:(long long)groupId comments:(NSString *)comments serviceContext:(LRJSONObjectWrapper *)serviceContext error:(NSError **)error;
- (void)deleteMembershipRequestsWithGroupId:(long long)groupId statusId:(int)statusId error:(NSError **)error;
- (NSDictionary *)getMembershipRequestWithMembershipRequestId:(long long)membershipRequestId error:(NSError **)error;
- (void)updateStatusWithMembershipRequestId:(long long)membershipRequestId reviewComments:(NSString *)reviewComments statusId:(int)statusId serviceContext:(LRJSONObjectWrapper *)serviceContext error:(NSError **)error;

@end