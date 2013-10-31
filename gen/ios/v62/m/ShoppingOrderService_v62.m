/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
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

#import "ShoppingOrderService_v62.h"

/**
 * author Bruno Farache
 */
@implementation ShoppingOrderService_v62

- (NSDictionary *)updateOrder:(long)groupId orderId:(long)orderId ppTxnId:(NSString *)ppTxnId ppPaymentStatus:(NSString *)ppPaymentStatus ppPaymentGross:(double)ppPaymentGross ppReceiverEmail:(NSString *)ppReceiverEmail ppPayerEmail:(NSString *)ppPayerEmail {
	NSDictionary *_params = @{
		@"groupId": @(groupId),
		@"orderId": @(orderId),
		@"ppTxnId": ppTxnId,
		@"ppPaymentStatus": ppPaymentStatus,
		@"ppPaymentGross": @(ppPaymentGross),
		@"ppReceiverEmail": ppReceiverEmail,
		@"ppPayerEmail": ppPayerEmail
	};

	NSDictionary *_command = @{@"/shoppingorder/update-order": _params};

	return (NSDictionary *)[self.session invoke:_command];
}

- (void)deleteOrder:(long)groupId orderId:(long)orderId {
	NSDictionary *_params = @{
		@"groupId": @(groupId),
		@"orderId": @(orderId)
	};

	NSDictionary *_command = @{@"/shoppingorder/delete-order": _params};

	[self.session invoke:_command];
}

- (NSDictionary *)getOrder:(long)groupId orderId:(long)orderId {
	NSDictionary *_params = @{
		@"groupId": @(groupId),
		@"orderId": @(orderId)
	};

	NSDictionary *_command = @{@"/shoppingorder/get-order": _params};

	return (NSDictionary *)[self.session invoke:_command];
}

- (void)completeOrder:(long)groupId number:(NSString *)number ppTxnId:(NSString *)ppTxnId ppPaymentStatus:(NSString *)ppPaymentStatus ppPaymentGross:(double)ppPaymentGross ppReceiverEmail:(NSString *)ppReceiverEmail ppPayerEmail:(NSString *)ppPayerEmail serviceContext:(NSDictionary *)serviceContext {
	NSDictionary *_params = @{
		@"groupId": @(groupId),
		@"number": number,
		@"ppTxnId": ppTxnId,
		@"ppPaymentStatus": ppPaymentStatus,
		@"ppPaymentGross": @(ppPaymentGross),
		@"ppReceiverEmail": ppReceiverEmail,
		@"ppPayerEmail": ppPayerEmail,
		@"serviceContext": serviceContext
	};

	NSDictionary *_command = @{@"/shoppingorder/complete-order": _params};

	[self.session invoke:_command];
}

- (void)sendEmail:(long)groupId orderId:(long)orderId emailType:(NSString *)emailType serviceContext:(NSDictionary *)serviceContext {
	NSDictionary *_params = @{
		@"groupId": @(groupId),
		@"orderId": @(orderId),
		@"emailType": emailType,
		@"serviceContext": serviceContext
	};

	NSDictionary *_command = @{@"/shoppingorder/send-email": _params};

	[self.session invoke:_command];
}

@end