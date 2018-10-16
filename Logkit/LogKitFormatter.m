// LogKitFormatter.m
//
// Copyright (c) 2018 BANYAN
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LogKitFormatter.h"

static NSString *_processName;

@implementation LogKitFormatter

+ (void)initialize {
    if (self == [LogKitFormatter class]) {
        _processName = [[NSProcessInfo processInfo] processName];
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;

    self.dateFormatter = NSDateFormatter.new;
    [self.dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
    
    switch (logMessage->_flag) {
        case DDLogFlagError   : logLevel = @"Error"; break;
        case DDLogFlagWarning : logLevel = @"Warning"; break;
        case DDLogFlagInfo    : logLevel = @"Info"; break;
        case DDLogFlagDebug   : logLevel = @"Debug"; break;
        default               : logLevel = @"Verbose"; break;
    }
    
    return [NSString stringWithFormat:@"%@ %@[%@] %@ %@:%@ %@",
            [self.dateFormatter stringFromDate:logMessage.timestamp],
            _processName,
            [self queueThreadLabelForLogMessage:logMessage],
            logLevel,
            logMessage->_fileName,
            @(logMessage->_line),
            logMessage->_message];
}

@end