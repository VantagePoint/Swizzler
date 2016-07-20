/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "GDCReadStream.h"
#import "GDCWriteStream.h"
#import "GDPortability.h"

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATED_IN_NSFILEMANAGER __attribute__((deprecated("Deprecated in NSFileManager. Do not use.")))
#else
#   define DEPRECATED_IN_NSFILEMANAGER __attribute__((deprecated))
#endif

/**
 * \defgroup gdfilemanagererrordomain GDFileManager Error Domain
 * These constants can be used when handling errors returned by
 * \ref GDFileManager, \ref GDCReadStream, and \ref GDCWriteStream functions.
 *
 * \{
 */

GD_NS_ASSUME_NONNULL_BEGIN

extern NSString* const GDFileManagerErrorDomain;
/**< Error domain for file system errors.
 */

typedef NS_ENUM(NSInteger, GDFileManagerErrorType)
{
    GDFileManagerErrorPathDoesNotExist = 100,
    /**< Specified path does not exist.
     */

    GDFileManagerErrorIOError         = 101,
    /**< IO error occurred during a low-level read or write operation.
     */

    GDFileManagerErrorPermissionError = 102,
    /**< Permissions error when attempting to access part of the filesystem.
     */

    GDFileManagerErrorDirectoryNotEmpty     = 103,
    /**< Attempt to delete a directory that was not empty.
     */

    GDFileManagerErrorPathError  = 104,
    /**< There was a problem with the path.
     */

    GDFileManagerErrorICloudNotSupported  = 105,
    /**< Attempt to access "Ubiquitous" file or directory, i.e.\ one that is in
     *   "cloud" storage.
     */
    
    GDFileManagerErrorPathAlreadyExists  = 106,
    /**< Specified path already exists.
     */

    GDFileManagerErrorDeleteBackupError = 107,
    /**< Unable to delete backup.
     */
    
    GDFileManagerErrorPreservingMetadata = 108,
    /**< Unable to preserve metadata from original file.
     */

    GDFileManagerErrorInvalidFileURL = 109,
    /**< The URL passed in was not a valid file URL.
     */

    GDFileManagerErrorUnknownError    = 500
    /**< An unknown error occured.
     */
};

/** \}
 */

/** Secure File System.
 * The secure file system is part of the Good Dynamics Secure Storage
 * feature.
 *
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 * For applications, the Good Dynamics (GD) secure file system behaves like the
 * default file system, with the following differences.
 * - All data within the secure file system is stored on the device
 *   in an encrypted form.
 * - Directory and file names are also encrypted.
 * - The secure file system cannot be accessed until Good Dynamics authorization
 *   processing is complete, see under  \link GDiOS::authorize: authorize (GDiOS)\endlink.
 * .
 * Encryption and decryption is transparent to the application code:
 * - File-writing interfaces accept plain data. The GD Runtime encrypts the data
 *   and stores it on the device.
 * - When a file-reading interface is utilized, the GD Runtime decrypts what was
 *   stored and returns plain data.
 * - Path access interfaces accept plain parameters for directory and file
 *   names. The GD Runtime encrypts the parameter values in order to create
 *   paths in the secure store.
 * - Directory and file names provided as return values are plain. The GD
 *   Runtime decrypts paths in the secure store in order to generate the return
 *   values.
 * .
 *
 * The encryption method used by the GD Runtime generally requires that the user
 * has entered a security password, from which an encryption key is derived.
 *  \htmlonly </div> \endhtmlonly
 *
 * 
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 * <H2>Usage</H2>
 * This class is a subclass of the native <TT>NSFileManager</TT> class. It
 * should be easy to replace references to <TT>NSFileManager</TT> with
 * references to <TT>GDFile</TT><TT>Manager</TT>, in order to convert code that
 * utilizes the native file system into code that utilizes the secure file
 * system.
 *
 * The differences between this class and <TT>NSFileManager</TT> are:
 * - Write access is limited to the secure store.
 * - There is no access to "Ubiquitous" files and directories, i.e. no access to
 *   items in "cloud" storage.
 * - Returned <TT>NSURL</TT> values for locations within the secure file system
 *   can only be utilized to access files and directories by the functions
 *   in this class. They cannot be used by native interfaces, such as
 *   <TT>NSInputStream</TT> or <TT>stringWithContentsOfURL:</TT> for example.
 * - Returned <TT>NSString</TT> values for paths within the secure file system
 *   can only be utilized to access files and directories by the functions
 *   in this class. They cannot be used by native interfaces, such as
 *   <TT>stringByResolvingSymlinksInPath</TT>, or
 *   <TT>dataWithContentsOfFile:</TT> for example.
 * - Error codes could be in the specific <TT>GDFil</TT><TT>eManager</TT> error
 *   domain, or could be general <TT>NS</TT> error codes.
 * .
 *
 * To read and write files in the secure store, use functions in this class.
 * For example, use
 * \link GDFileManager::createFileAtPath:contents:attributes:
 * createFileAtPath:\endlink
 * or
 * \link GDFileManager::getWriteStream:appendmode:error: getWriteStream:\endlink
 * to write, and use
 * \link GDFileManager::contentsAtPath: contentsAtPath:\endlink
 * or
 * \link GDFileManager::getReadStream:error: getReadStream:\endlink
 * to read. Don't use file-reading and -writing functions in the native
 * <TT>NS</TT> classes.
 *
 * Best practice for building paths for use with this class is as follows. First
 * use an <TT>NSSearchPathDirectory</TT> value to generate a path prefix, for
 * example by calling the <TT>NSSearchPathForDirectoriesInDomains:</TT>
 * function. Then append to the prefix, for example by calling the
 * <TT>NSString</TT> <TT>stringByAppendingPath:</TT> function or the
 * <TT>NSURL</TT> <TT>URLByAppendingPathComponent</TT> function.
 * 
 * The functions in this API utilize <TT>NSError</TT> in a conventional way. Function calls accept as a parameter the location of a pointer to <TT>NSError</TT>, i.e. a pointer to a pointer, with type <TT>NSError**</TT>. The location may be <TT>nil</TT>. If the location is not <TT>nil</TT>, and an error occurs, the Good Dynamics Runtime overwrites the pointer at the specified location with the address of an object that describes the error that occurred.
 *
 * The documentation of this class includes descriptions for functions and
 * other API elements that:
 * - Have different semantics to the corresponding elements in the base class.
 * - Are not present in the base class.
 * .
 * API elements of the base class that are overriden, but have the same
 * semantics, are listed in the documentation of this class, but not described
 * further. API elements of the base class that are not overriden are not
 * listed. See the documentation of the base class, <TT>NSFileManager</TT>, for
 * full descriptions.
 *  \htmlonly </div> \endhtmlonly
 *
 * \see <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSFileManager_Class/"
 *     target="blank"
 * >NSFileManager class reference</A> in the iOS Developer Library on apple.com
 * \see <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_Functions/#//apple_ref/c/func/NSSearchPathForDirectoriesInDomains"
 *     target="_blank"
 * >NSSearchPathForDirectoriesInDomains function reference</A> in the iOS
 * Developer Library on apple.com
 * \see \ref gdfilemanagererrordomain
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorHandling/ErrorHandling.html"
 *     target="_blank"
 * >Error Handling Programming Guide</A> in the iOS Developer Library on
 * apple.com
 * \see  \link sqlite Secure SQL Database API\endlink
 * \see \ref GDPersistentStoreCoordinator
 * \see \ref capilist
 * 
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Simple conversion to secure file system</H3>
 * The following code snippets illustrate simple conversion of a function that
 * uses the native file system to use the secure files system instead.
 *
 * The second function in the snippet is the original; the third is the
 * converted version. The changed line is flagged with a comment. The first
 * function in the snippet is a utility that is used by both the original and
 * the converted function, with no changes.
 * \code
 * - (NSString *)documentsFolderPathForFileNamed:(NSString *)fileName
 * {
 *     NSArray *paths =
 *     NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
 *                                         NSUserDomainMask,
 *                                         YES);
 *     NSString *documentsDirectory = [paths objectAtIndex:0];
 *     return [documentsDirectory stringByAppendingPathComponent:fileName];
 * }
 * 
 * - (BOOL)writeMyFile
 * {
 *     NSString *text = @"Text that is not protected.";
 *     NSData *fileData = [text dataUsingEncoding:NSUTF8StringEncoding];
 *     
 *     BOOL fileCreated =
 *     [[NSFileManager defaultManager]
 *      createFileAtPath:[self
 *                        documentsFolderPathForFileNamed:@"MyFile.txt"]
 *      contents:fileData
 *      attributes:nil];
 *     return fileCreated;
 * }
 * 
 * - (BOOL)writeMyFileGD
 * {
 *     NSString *text = @"Text to be protected by GD encryption.";
 *     NSData *fileData = [text dataUsingEncoding:NSUTF8StringEncoding];
 *
 *     // Following assignment uses GDFileManager instead of NSFileManager.
 *     BOOL fileCreated =
 *     [[GDFileManager defaultManager]
 *      createFileAtPath:[self
 *                        documentsFolderPathForFileNamed:@"MyFile.txt"]
 *      contents:fileData
 *      attributes:nil];
 *     return fileCreated;
 * }
 * \endcode
 */
@interface GDFileManager : NSFileManager <NSStreamDelegate>
{

}

+ (GDFileManager *)defaultManager;

+ (GD_NSNULLABLE GDCReadStream*) getReadStream:(NSString*)filePath error:(NSError** ) error;
/**< Open a file that is in the secure store, for reading.
 * Call this function to open a file in the secure store for reading.
 * Files in the secure store are encrypted on the device; this
 * function provides access to decrypted data.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, that
 * represents the file to be opened.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>GDCReadStream</TT> object from which the file's data can be read,
 * or a null pointer if the file could not be opened.
 */

+ (GD_NSNULLABLE GDCWriteStream*) getWriteStream:(NSString*)filePath appendmode:(BOOL) flag error:(NSError**) error;
/**< Open a file in the secure store, for writing.
 * Call this function to create a new file in the secure store,
 * or to open an existing file for writing.
 * Files in the secure store are encrypted on the device;
 * data written to the stream returned by this function will be encrypted,
 * transparently to the application.
 *
 * If a file already exists at the specified path, the file can either be
 * appended to, or overwritten.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, that
 * represents the file to be opened.
 * \param flag Selects the action to take if a file already exists at the path.
 * <TT>YES</TT> to append to the file, or <TT>NO</TT> to overwrite.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>GDCWriteStream</TT> object to which data can be written,
 * or a null pointer if the file could not be opened.
 */

+ (GD_NSNULLABLE NSString*)getAbsoluteEncryptedPath:(NSString*)filePath;
/**< Get the absolute encrypted path of a file within the secure store.
 * This function returns the encrypted path for a file or directory within the
 * secure store. The principal usage for this function is to provide a
 * path that is compatible with the SQL ATTACH command.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, that
 * represents the item for which the encrypted path is required.
 *
 * \return <TT>NSString</TT> containing the encrypted path.
 */

+ (BOOL)exportLogFileToDocumentsFolder:(NSError**) error;
/**< Dump Good Dynamics logs out to an accessible folder.
 * Call this function to create a dump of Good Dynamics activity logs. The
 * logs will be dumped to a file that is outside the secure store, in the
 * Documents folder.
 * The file will not be encrypted.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * The log file can be copied from the device in the normal way, and sent to
 * Good Technology to assist in support analysis.
 *
 * \see  \link GDFileManager::uploadLogs: uploadLogs:\endlink
 */

+ (BOOL)uploadLogs:(NSError**) error;
/**< Upload Good Dynamics logs to Good Technology.
 * Call this function to upload Good Dynamics activity logs for support
 * purposes.
 * The logs will be uploaded to a server in the Good Technology Network
 * Operation Center (NOC).
 * 
 * Upload takes place in background and is retried as necessary.
 * This function returns immediately.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * Good Technology support staff have access to the server to which log files
 * are uploaded, and can use the data for support analysis.
 * This function can be used to upload logs even if authorization has failed.
 * The end user's enterprise email address will be needed by support staff,
 * to identify uploaded files. If authorization has failed or been cancelled
 * without an email address being successfully entered no logs will be uploaded.
 *
 * \see  \link GDFileManager::exportLogFileToDocumentsFolder:  exportLogFileToDocumentsFolder:\endlink
 */

// Working with directories.

- (GD_NSNULLABLE NSURL *)URLForDirectory:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domain appropriateForURL:(GD_NSNULLABLE NSURL *)url create:(BOOL)shouldCreate error:(NSError **)error;

- (GD_NSArray(NSURL *) *)URLsForDirectory:(NSSearchPathDirectory)directory inDomains:(NSSearchPathDomainMask)domainMask;

- (GD_NSNULLABLE GD_NSArray(NSURL*)*)contentsOfDirectoryAtURL:(NSURL *)url includingPropertiesForKeys:(GD_NSNULLABLE GD_NSArray(NSString*)*)keys options:(NSDirectoryEnumerationOptions)mask error:(NSError **)error;

- (GD_NSNULLABLE GD_NSArray(NSString*)*)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error;

- (GD_NSNULLABLE GD_NSDirectoryEnumerator(NSURL *) *)enumeratorAtURL:(NSURL *)url includingPropertiesForKeys:(GD_NSNULLABLE GD_NSArray(NSString *) *)keys options:(NSDirectoryEnumerationOptions)mask errorHandler:(GD_NSNULLABLE BOOL (^)(NSURL * url, NSError * error))handler;

- (GD_NSNULLABLE GD_NSDirectoryEnumerator(NSString *) *)enumeratorAtPath:(NSString *)path;

- (GD_NSNULLABLE GD_NSArray(NSString*) *)subpathsOfDirectoryAtPath:( NSString *)pathRaw error:(NSError **)error;

- (GD_NSNULLABLE GD_NSArray(NSString*) *)subpathsAtPath:( NSString *)path;

// Creating and deleting items.

- (BOOL)createDirectoryAtURL:( NSURL *)url withIntermediateDirectories:(BOOL)createIntermediates attributes:(GD_NSNULLABLE GD_NSDictionary(NSString*, id)*)attributes error:(NSError **)error;

- (BOOL)createDirectoryAtPath:( NSString*)path withIntermediateDirectories:(BOOL) createIntermediates attributes:(GD_NSNULLABLE GD_NSDictionary(NSString*, id)*)attributes error:(NSError **)error;

- (BOOL)createFileAtPath:( NSString *)path contents:(GD_NSNULLABLE NSData *)contents attributes:(GD_NSNULLABLE GD_NSDictionary(NSString*, id)*)attributes;

- (BOOL)removeItemAtURL:( NSURL *)URL error:(NSError **)error;

- (BOOL)removeItemAtPath:( NSString*)filePath error:(NSError **)error;

- (BOOL)replaceItemAtURL:( NSURL *)originalItemURL withItemAtURL:( NSURL *)newItemURL backupItemName:(GD_NSNULLABLE NSString *)backupItemName options:(NSFileManagerItemReplacementOptions)options resultingItemURL:(NSURL * GD_NSNULLABLE_CPP * GD_NSNULLABLE_CPP)resultingURL error:(NSError **)error;

// Moving and copying items.

- (BOOL)copyItemAtURL:( NSURL *)srcURL toURL:( NSURL *)dstURL error:(NSError **)error;

- (BOOL)copyItemAtPath:( NSString *)srcPath toPath:( NSString *)dstPath error:(NSError **)error;

- (BOOL)moveItemAtURL:( NSURL *)srcURL toURL:( NSURL *)dstURL error:(NSError **)error;

- (BOOL)moveItemAtPath:( NSString*)srcPath toPath:( NSString*)dstPath error:(NSError **)error;

// Unavailable API elements.
// iCloud - unsupported

@property(GD_NSNULLABLE_PROP readonly, copy, atomic) id<NSObject, NSCopying, NSCoding> ubiquityIdentityToken;
/**< Not available.
 * This element of the base class interface is not available in this subclass.
 * See under Usage, above.
 *
 * \returns <TT>nil</TT> always.
 */

- (GD_NSNULLABLE NSURL *)URLForUbiquityContainerIdentifier:(GD_NSNULLABLE NSString *)containerIdentifier;
/**< Not available.
 * This element of the base class interface is not available in this subclass.
 * See under Usage, above.
 *
 * \returns <TT>nil</TT> always.
 */

- (BOOL)isUbiquitousItemAtURL:( NSURL *)url;
/**< Not available.
 * This element of the base class interface is not available in this subclass.
 * See under Usage, above.
 *
 * \returns <TT>NO</TT> always.
 */

- (BOOL)setUbiquitous:(BOOL)flag itemAtURL:( NSURL *)url destinationURL:( NSURL *)destinationURL error:(NSError **)error;
/**< Not available.
 * This element of the base class interface is not available in this subclass.
 * See under Usage, above.
 *
 * \returns <TT>NO</TT> always. Sets <TT>GDFileManagerErrorICloudNotSupported</TT>
 *          if an <TT>error</TT> location is specified.
 */

- (BOOL)startDownloadingUbiquitousItemAtURL:( NSURL *)url error:(NSError **)error;
/**< Not available.
 * This element of the base class interface is not available in this subclass.
 * See under Usage, above.
 *
 * \returns <TT>NO</TT> always. Sets <TT>GDFileManagerErrorICloudNotSupported</TT>
 *          if an <TT>error</TT> location is specified.
 */

- (BOOL)evictUbiquitousItemAtURL:( NSURL *)url error:(NSError **)error;
/**< Not available.
 * This element of the base class interface is not available in this subclass.
 * See under Usage, above.
 *
 * \returns <TT>NO</TT> always. Sets <TT>GDFileManagerErrorICloudNotSupported</TT>
 *          if an <TT>error</TT> location is specified.
 */

- (GD_NSNULLABLE NSURL *)URLForPublishingUbiquitousItemAtURL:( NSURL *)url expirationDate:(NSDate * GD_NSNULLABLE_CPP * GD_NSNULLABLE_CPP)outDate error:(NSError **)error;
/**< Not available.
 * This element of the base class interface is not available in this subclass.
 * See under Usage, above.
 *
 * \returns <TT>nil</TT> always. Sets <TT>GDFileManagerErrorICloudNotSupported</TT>
 *          if an <TT>error</TT> location is specified.
 */

// Linking.

- (BOOL)createSymbolicLinkAtURL:( NSURL *)url withDestinationURL:( NSURL *)destURL error:(NSError **)error;

- (BOOL)createSymbolicLinkAtPath:( NSString *)path withDestinationPath:( NSString *)destPath error:(NSError **)error;

- (BOOL)linkItemAtURL:( NSURL *)srcURL toURL:( NSURL *)dstURL error:(NSError **)error;

- (BOOL)linkItemAtPath:( NSString *)srcPath toPath:( NSString *)dstPath error:(NSError **)error;

- (GD_NSNULLABLE NSString *)destinationOfSymbolicLinkAtPath:( NSString *)path error:(NSError **)error;

// Determining access.

- (BOOL)fileExistsAtPath:( NSString *)path;

- (BOOL)fileExistsAtPath:( NSString*)path isDirectory:(GD_NSNULLABLE BOOL*)isDirectory;

- (BOOL)isReadableFileAtPath:( NSString *)path;

- (BOOL)isWritableFileAtPath:( NSString *)path;

- (BOOL)isExecutableFileAtPath:( NSString *)path;

- (BOOL)isDeletableFileAtPath:( NSString *)path;

- (GD_NSNULLABLE GD_NSDictionary(NSString*, id) *)attributesOfItemAtPath:( NSString *)path error:(NSError **)error;

- (GD_NSNULLABLE GD_NSDictionary(NSString*, id) *)attributesOfFileSystemForPath:( NSString *)path error:(NSError **)error;

- (BOOL)setAttributes:( GD_NSDictionary(NSString*, id) *)attributes ofItemAtPath:( NSString *)path error:(NSError **)error;

// Getting file contents.

- (GD_NSNULLABLE NSData *)contentsAtPath:( NSString *)path;

- (GD_NSNULLABLE NSString*)convertToSecureContainerPath:( NSString*)path;

- (BOOL)contentsEqualAtPath:( NSString *)path1 andPath:( NSString *)path2;

// Converting paths to strings.

- ( const char *)fileSystemRepresentationWithPath:( NSString *)path;

- ( NSString *)stringWithFileSystemRepresentation:( const char *)string length:(NSUInteger)len;

// Get and set the current working directory of the program.

- (BOOL)changeCurrentDirectoryPath:( NSString *)path;

- ( NSString *)currentDirectoryPath;

// Deprecated methods

- (BOOL)changeFileAttributes:( NSDictionary *)attributes atPath:( NSString *)path DEPRECATED_IN_NSFILEMANAGER;
/**< Deprecated in base class.
 * \deprecated This function is deprecated in the base class. Use
 * \link GDFileManager::setAttributes:ofItemAtPath:error: setAttributes:ofItemAtPath:error:\endlink
 * instead.
 */

- (GD_NSNULLABLE NSDictionary *)fileAttributesAtPath:( NSString *)path traverseLink:(BOOL)flag DEPRECATED_IN_NSFILEMANAGER;
/**< Deprecated in base class.
 * \deprecated This function is deprecated in the base class. Use
 * \link GDFileManager::attributesOfItemAtPath:error: attributesOfItemAtPath:error:\endlink
 * instead.
 */

- (GD_NSNULLABLE NSDictionary *)fileSystemAttributesAtPath:( NSString *)path  DEPRECATED_IN_NSFILEMANAGER;
/**< Deprecated in base class.
 * \deprecated This function is deprecated in the base class. Use
 * \link GDFileManager::attributesOfFileSystemForPath:error: attributesOfFileSystemForPath:error:\endlink
 * instead.
 */

- (GD_NSNULLABLE NSArray *)directoryContentsAtPath:( NSString *)path DEPRECATED_IN_NSFILEMANAGER;
/**< Deprecated in base class.
 * \deprecated This function is deprecated in the base class. Use
 * \link GDFileManager::contentsOfDirectoryAtPath:error: contentsOfDirectoryAtPath:error:\endlink
 * instead.
 */

- (BOOL)createDirectoryAtPath:( NSString *)path attributes:( NSDictionary *)attributes DEPRECATED_IN_NSFILEMANAGER;
/**< Deprecated in base class.
 * \deprecated This function is deprecated in the base class. Use
 * \link GDFileManager::createDirectoryAtPath:withIntermediateDirectories:attributes:error: createDirectoryAtPath:withIntermediateDirectories:attributes:error:\endlink
 * instead.
 */

- (BOOL)createSymbolicLinkAtPath:( NSString *)path pathContent:( NSString *)otherPath DEPRECATED_IN_NSFILEMANAGER;
/**< Deprecated in base class.
 * \deprecated This function is deprecated in the base class. Use
 * \link GDFileManager::createSymbolicLinkAtPath:withDestinationPath:error: createSymbolicLinkAtPath:withDestinationPath:error:\endlink
 * instead.
 */

- (GD_NSNULLABLE NSString *)pathContentOfSymbolicLinkAtPath:( NSString *)path  DEPRECATED_IN_NSFILEMANAGER;
/**< Deprecated in base class.
 * \deprecated This function is deprecated in the base class. Use
 * \link GDFileManager::destinationOfSymbolicLinkAtPath:error: destinationOfSymbolicLinkAtPath:error:\endlink
 * instead.
 */

@end

GD_NS_ASSUME_NONNULL_END
