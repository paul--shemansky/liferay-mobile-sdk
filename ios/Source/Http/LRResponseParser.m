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

#import "LRResponseParser.h"

#import "LRBatchSession.h"

NSString *const LR_ERROR_DOMAIN = @"com.liferay.mobile";
NSInteger const LR_ERROR_CODE_SERVER_EXCEPTION = -1;
NSInteger const LR_ERROR_CODE_PARSE = -2;
NSInteger const LR_ERROR_CODE_UNAUTHORIZED = -3;
NSString *const LR_ERROR_EXCEPTION_SECURITY = @"java.lang.SecurityException";
NSString *const LR_ERROR_EXCEPTION_PARSE = @"com.liferay.ParseException";
NSString *const LR_ERROR_EXCEPTION_STATUS = @"com.liferay.StatusException";
NSString *const LR_ERROR_EXCEPTION_GENERIC = @"java.lang.Exception";
const int LR_STATUS_OK = 200;
const int LR_STATUS_UNAUTHORIZED = 401;

/**
 * @author Bruno Farache
 */
@implementation LRResponseParser

+ (id)parse:(NSHTTPURLResponse *)response data:(id)data
		error:(NSError **)error {

	int statusCode = [response statusCode];

	if (statusCode == LR_STATUS_UNAUTHORIZED) {
		NSDictionary *userInfo = @{
			NSLocalizedDescriptionKey: @"Authenticated access required",
			NSLocalizedFailureReasonErrorKey:LR_ERROR_EXCEPTION_SECURITY
		};

		*error = [NSError errorWithDomain:LR_ERROR_DOMAIN
			code:LR_ERROR_CODE_UNAUTHORIZED userInfo:userInfo];

		return nil;
	}

	if (statusCode != LR_STATUS_OK) {
		NSDictionary *userInfo = @{
			NSLocalizedDescriptionKey: @"Unknown server error",
			NSLocalizedFailureReasonErrorKey:LR_ERROR_EXCEPTION_STATUS
		};

		*error = [NSError errorWithDomain:LR_ERROR_DOMAIN code:statusCode
			userInfo:userInfo];

		return nil;
	}

	id json = data;

	if ([data isKindOfClass:[NSData class]]) {
		NSError *parseError;

		json = [NSJSONSerialization JSONObjectWithData:data options:0
			error:&parseError];

		if (parseError) {
			NSDictionary *userInfo = @{
				NSLocalizedDescriptionKey:@"Fatal error happened processing \
					server data",
				NSLocalizedFailureReasonErrorKey:LR_ERROR_EXCEPTION_PARSE,
				NSUnderlyingErrorKey:parseError
			};

			*error = [NSError errorWithDomain:LR_ERROR_DOMAIN
				code:LR_ERROR_CODE_PARSE userInfo:userInfo];

			return nil;
		}
	}

	if ([json isKindOfClass:[NSDictionary class]]) {
		NSError *serverError = [self _checkPortalException:(NSDictionary *)json];

		if (serverError) {
			*error = serverError;

			return nil;
		}
	}

	return json;
}

+ (NSError *)_checkPortalException:(NSDictionary *)response {
	NSString *exception = [response objectForKey:@"exception"];

	if (!exception) {
		return nil;
	}

	NSString *message = [response objectForKey:@"message"];

	if (!message) {
		message = exception;
		exception = LR_ERROR_EXCEPTION_GENERIC;
	}

	NSDictionary *userInfo = @{
		NSLocalizedDescriptionKey: message,
		NSLocalizedFailureReasonErrorKey: exception
	};

	return [NSError errorWithDomain:LR_ERROR_DOMAIN
		code:LR_ERROR_CODE_SERVER_EXCEPTION userInfo:userInfo];
}

@end