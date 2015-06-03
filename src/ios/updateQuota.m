/********* updateQuota.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <sqlite3.h>

@interface updateQuota : CDVPlugin {
  // Member variables go here.
}

- (void)updateStorageQuota:(CDVInvokedUrlCommand*)command;

@end

@implementation updateQuota

- (BOOL)updateLocalDb: (int) newQuota
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if (paths == NULL || paths.count <= 0)
    {
        return NO;
    }

    NSString *cachesDirectory = [paths objectAtIndex: 0];
    NSString *databaseFile = [cachesDirectory stringByAppendingPathComponent: @"Databases.db"];

    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath: databaseFile] == NO)
    {
        NSLog(@"Database file does not exist: %@", databaseFile);
        return NO;
    }

    sqlite3 *db;
    if (sqlite3_open([databaseFile UTF8String], &db) == SQLITE_OK)
    {
        const char *updateSQL = [[NSString stringWithFormat:
                               @"update Origins set quota = %d", newQuota] UTF8String];

        sqlite3_stmt *statement;
        sqlite3_prepare_v2(db, updateSQL, -1, &statement, NULL);

        if(sqlite3_step(statement) != SQLITE_DONE)
        {
            NSLog(@"Failed to execute statement");
            sqlite3_finalize(statement);
            sqlite3_close(db);
            return NO;
        }

        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    else
    {
        NSLog(@"Unable to open database");
        return NO;
    }
    return YES;
}

- (void)updateStorageQuota:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString *strQuota = [command.arguments objectAtIndex:0];

    if([strQuota isEqual:[NSNull null]])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    else
    {
        int quota = [strQuota intValue];
        if ([self updateLocalDb:quota] == YES)
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        else
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
