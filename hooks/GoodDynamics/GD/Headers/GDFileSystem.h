/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#ifndef __GD_FILE_SYSTEM_H__
#define __GD_FILE_SYSTEM_H__

#import <Foundation/Foundation.h>
#import "GDCReadStream.h"
#import "GDCWriteStream.h"
#import <CoreData/CoreData.h>
#import "GDFileStat.h"

// See: http://clang.llvm.org/docs/LanguageExtensions.html
#ifndef __has_extension
#define __has_extension(x) 0  // Compatibility with non-clang compilers.
#endif

#if __has_extension(attribute_deprecated_with_message)
#   define DEPRECATE_GDFILESYSTEM __attribute__((deprecated("Use GDFileManager instead.")))
#else
#   define DEPRECATE_GDFILESYSTEM __attribute__((deprecated))
#endif

/** NSPersistentStoreCoordinator subclass that supports an encrypted binary
 * store type in Core Data.
 * Good Dynamics applications can store Core Data objects in the Secure Store.
 *
 * Using this class instead of the default <TT>NSPersistentStoreCoordinator</TT>
 * allows the use of the following additional Core Data store types:<DL
 * ><DT><TT>GDEncryptedBinaryStoreType</TT></DT><DD
 * >Encrypted binary store that is stored in the Good Dynamics Secure Store.\n
 * Use this in place of <TT>NSBinaryStoreType</TT>.</DD
 * ><DT><TT>GDEncryptedIncrementalStoreType</TT></DT><DD
 * >Encrypted incremental store that is stored in the Good Dynamics Secure
 * Store.\n
 * Use this in place of <TT>NSSQLiteStoreType</TT>.\n
 * This store type is based on <TT>NSIncrementalStoreType</TT> and
 * is therefore only available in iOS 5.0 or later.</DD
 * ></DL>
 *
 *  \htmlonly <div class="bulletlists"> \endhtmlonly
 * Note the following details:
 * - When these store types are in use, the <TT>URL</TT> parameter will be an
 * absolute path within the Secure File System.
 * - Use of this class with store types other than the above results in
 * identical behavior to using the default class.
 * The above additional store types cannot be used with the default class.
 * - Data can be migrated from an <TT>NSSQLiteStoreType</TT> store to a
 * <TT>GDEncryptedIncrementalStoreType</TT> store.
 * Use the Core Data migration API to do this.
 * For an example, see the CoreData sample application supplied with the Good
 * Dynamics SDK.
 * (It is not possible to import an <TT>NSSQLiteStoreType</TT> store file
 * directly into the Secure File System, and then use it as a
 * <TT>GDEncryptedIncrementalStoreType</TT> store.)
 * - Core Data stores of the above types cannot be accessed until Good Dynamics
 * authorization processing has completed.
 * This means that construction of the Managed Object Context, and the
 * population of views, must be deferred until after Good Dynamics authorization.
 * (For an example of deferred construction and population, see the CoreData
 * sample application supplied with the Good Dynamics SDK.)
 *
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/#referencelibrary/GettingStarted/GettingStartedWithCoreData/_index.html%23//apple_ref/doc/uid/TP40005316"
 *     target="_blank"
 * >Core Data Starting Point</A> in the iOS Developer Library on apple.com
 * \see  \link GDFileManager\endlink
 * \see  \link sqlite Secure SQL Database API\endlink
 * \see \link GDiOS\endlink, for Good Dynamics authorization
 *
 *  <H2>Code Snippets</H2> The following code snippets illustrate some common tasks.
 * <H3>Utilize GD Persistent Store Coordinator</H3>
 * \code
 * - (NSPersistentStoreCoordinator *)persistentStoreCoordinator
 * {
 *      if (__persistentStoreCoordinator != nil) {
 *          return __persistentStoreCoordinator;
 *      }
 *
 *      // The URL will be a path in the secure container
 *      NSURL *storeURL = [NSURL URLWithString:@"/example.bin"];
 *
 *      NSError *error = nil;
 *      __persistentStoreCoordinator =
 *          [[GDPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
 *      if (![__persistentStoreCoordinator
 *              addPersistentStoreWithType: GDEncryptedBinaryStoreType
 *                           configuration: nil
 *                                     URL: storeURL
 *                                 options: nil
 *                                   error: &error]
 *      ) {
 *          abort();
 *      }
 *
 *      return __persistentStoreCoordinator;
 * }
 *
 * \endcode
 *
 */


@interface GDPersistentStoreCoordinator : NSPersistentStoreCoordinator {

}

@end

extern NSString * const GDEncryptedBinaryStoreType;
/**< Specify the encrypted binary store type.
 */

extern NSString* const GDEncryptedBinaryStoreErrorDomain;
/**< Specify the encrypted binary store type error domain.
 */

extern NSString* const GDEncryptedIncrementalStoreType;
/**< Specify the encrypted incremental store type.
 */

extern NSString* const GDEncryptedIncrementalStoreErrorDomain;
/**< Specify the encrypted incremental store type error domain.
 */


/**
 * \defgroup gdfilesystemerrordomain GDFileSystem Error Domain
 * These constants can be used when handling errors returned by
 * \ref GDFileSystem, \ref GDCReadStream, and \ref GDCWriteStream
 * functions.\ The constant values in the GDFileSystemErr enumeration also
 * occur in the \link gdfilemanagererrordomain GDFileManagerErrorType\endlink
 * enumeration.\ The labels in the GDFileManagerErrorType enumeration are
 * similar but follow a different convention.\ The semantics are the same.
 *
 * \{
 */

extern NSString* const GDFileSystemErrorDomain;
/**< Error domain for file system errors.
 */

typedef NS_ENUM(NSInteger, GDFileSystemErr)
{
    GDFileSystemErrPathDoesntExist = 100,
    /**< Specified path does not exist.
     */

    GDFileSystemErrIOError         = 101,
    /**< IO error occurred during a low-level read or write operation.
     */

    GDFileSystemErrPermissionError = 102,
    /**< Permissions error when attempting to access part of the filesystem.
     */

    GDFileSystemErrDirNotEmpty     = 103,
    /**< Attempt to delete a directory that was not empty.
     */

    GDFileSystemErrUnknownError    = 500
    /**< An unknown error occured.
     */
};

/** \}
 */

/** Secure File System (deprecated, use GDFileManager instead).
 * \deprecated This class is deprecated and will be removed in a future release.
 * Use the \ref GDFileManager class instead.
 * 
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
 * The functions in this API utilize <TT>NSError</TT> in a conventional way. Function calls accept as a parameter the location of a pointer to <TT>NSError</TT>, i.e. a pointer to a pointer, with type <TT>NSError**</TT>. The location may be <TT>nil</TT>. If the location is not <TT>nil</TT>, and an error occurs, the Good Dynamics Runtime overwrites the pointer at the specified location with the address of an object that describes the error that occurred.
 * 
 * \see \ref gdfilesystemerrordomain
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
 * <H3>Create Directory and File</H3>
 * \code
 * NSError *err = nil;
 * BOOL OKsofar = [GDFileSystem createDirectoryAtPath:@"/Hello/my"
 *                        withIntermediateDirectories:YES
 *                                         attributes:nil
 *                                              error:&err];
 * if (OKsofar) {
 *     NSLog( @"Directory created OK\n" );
 * }
 * else {
 *     NSLog( @"Directory not created \"%@\"\n", [err localizedDescription] );
 * }
 * 
 * NSString *helloStr = @"Hello my world!";
 * NSData *helloStrAsData =
 * [helloStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
 *      
 * OKsofar = [GDFileSystem writeToFile:helloStrAsData
 *                                name:@"/Hello/my/world.txt"
 *                               error:&err];
 * 
 * if (OKsofar) {
 *     NSLog( @"Wrote OK\n" );
 * }
 * else {
 *     NSLog( @"Not written \"%@\"\n", [err localizedDescription] );
 * }
 * \endcode
 * The above snippet shows the following, in sequence.
 * 
 * Creation of a directory and sub-directory in a single API call, to the
 * <TT>createDirectoryAtPath:</TT> function. The directory is named
 * <TT>Hello/</TT> and is in the root of the secure file system. The
 * sub-directory is named <TT>my/</TT> and is beneath the <TT>Hello/</TT>
 * directory.
 * 
 * Creation of an <TT>NSData</TT> object from an <TT>NSString</TT> containing
 * <TT>"Hello my world!"</TT>.
 * 
 * Creation of a file, <TT>world.txt</TT> in the previously created
 * sub-directory, by writing the contents of the <TT>NSData</TT> object in a
 * single API call, to the <TT>writeToFile:</TT> function.
 *
 * <H3>Get statistics for secure file</H3>
 * \code
 * GDFileStat myStat;
 * NSError *statErr = nil;
 * BOOL statOK = [GDFileSystem getFileStat:@"/Hello/my/world.txt"
 *                                      to:&myStat
 *                                   error:&statErr];
 * if (statOK) {
 *      NSDate *lastModified =
 *      [NSDate dateWithTimeIntervalSince1970:myStat.lastModifiedTime];
 *      NSLog( @"Stat OK. Length: %lld. Last modified: %@\n",
 *             myStat.fileLen, [lastModified description] );
 * }\endcode
 * The above snippet shows getting and then printing the file statistics for the
 * file created in the previous snippet. The statistic for last-modified time is
 * loaded into an <TT>NSDate</TT> object with the
 * <TT>dateWithTimeIntervalSince1970:</TT> function.
 * 
 * <H3>Read secure file</H3>
 * \code
 * - (void) readSecureFile:(NSString*)fileName {
 *     GDCReadStream *iStream = [GDFileSystem getReadStream:filename error:nil];
 *     if(iStream) {
 *         NSInteger nTotalRead = 0;
 *         while([iStream hasBytesAvailable]) {
 *             const NSUInteger buffer_size = 16 * 1024;
 *             NSInteger nRead;
 *             uint8_t buffer[buffer_size];
 *
 *             nRead = [iStream read:buffer maxLength:buffer_size];
 *             NSData *myData = [NSData dataWithBytesNoCopy:buffer length:nRead freeWhenDone:NO];
 *             NSLog(@"Data read of length =%i",nRead);
 *             nTotalRead += nRead;
 *         }
 *         NSLog(@"Total Data read of length =%i",nTotalRead);
 *     }
 * }
 * \endcode
 * <H3>Write secure file</H3>
 * \code
 * - (BOOL) writeSecureFile:(NSString*)filename withData:(NSData*)data
 * {
 *     NSError *wstreamErr = nil;
 *     GDCWriteStream *oStream = [GDFileSystem getWriteStream:filename
 *                                                 appendmode:NO
 *                                                      error:&wstreamErr];
 *     if (oStream) {
 *         [oStream open];
 *         if ([oStream hasSpaceAvailable]) {
 *             NSLog(@"Space available. Stream opened for writing...\n");
 *         }
 *         else {
 *             NSLog(@"Stream opened for writing but no space available.\n");
 *             [oStream close];
 *             return NO;
 *         }
 *     }
 *     else {
 *         NSLog(@"Write stream failed to open \"%@\"\n",
 *               [wstreamErr localizedDescription]);
 *         return NO;
 *     }
 * 
 *     // Allocate a byte buffer and copy the data into it.
 *     const unsigned long datalen = data.length;
 *     uint8_t *oBuffer = malloc(datalen);
 *     if (!oBuffer) {
 *         int my_errno = errno;
 *         NSLog( @"malloc(%ld) failed. %s.\n", datalen, strerror(my_errno) );
 *         [oStream close];
 *         return NO;
 *     }
 *     [data getBytes:oBuffer length:datalen];
 *     
 *     // Do the write, chunk by chunk.
 *     NSUInteger chunksize = 10000;
 *     unsigned long sofar = 0;
 *     while( sofar < datalen ) {
 *         NSUInteger thischunk = chunksize;
 *         if (datalen - sofar < (long) thischunk) {
 *             thischunk = (NSUInteger) (datalen - sofar);
 *         }
 *         NSInteger writeRet = [oStream write:oBuffer + sofar
 *                                   maxLength:thischunk];
 *         if (writeRet > 0) {
 *             sofar += writeRet;
 *             NSLog(@"Stream write: %d. So far %ld of %ld.\n",
 *                   writeRet, sofar, datalen);
 *         }
 *         else {
 *             NSLog(@"Stream write failed \"%@\". Stopping.\n",
 *                   [[oStream streamError] localizedDescription]);
 *             // Discard the buffer to flag that writing failed.
 *             free(oBuffer); oBuffer = NULL;
 *             break;
 *         }
 *     }
 *     NSLog(@"Closing stream...\n");
 *     [oStream close];
 *     NSLog(@"Stream Closed.\n");
 * 
 *     if (oBuffer) {
 *         free(oBuffer); oBuffer = NULL;
 *         return YES;
 *     }
 *     return NO;
 * }
 * \endcode
 * The above snippet shows writing a secure file in a "chunked" manner, after
 * checking that there is space available on the device to store the file.
 *
 * The data to be written is first copied into a byte buffer, allocated with the
 * standard <TT>malloc</TT> function.
 *
 * This snippet is provided to illustrate some of the lower-level functions. In
 * practice, writing a secure file from an <TT>NSData</TT> object would be done
 * by using the <TT>writeToFile</TT> function. This is shown in the Create
 * Directory and File snippet, above.
 */
@interface GDFileSystem : NSObject {

}

+ (BOOL) getFileStat:(NSString*)filePath to:(GDFileStat*)filestat error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Get statistics for a file or directory in the secure store (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::attributesOfItemAtPath:error: GDFileManager::attributesOfItemAtPath:\endlink
 * instead of this function.
 *
 * Call this function to get information about a file or directory in the secure
 * store. The information returned is: length of the file, last modified time,
 * and a flag for whether the path refers to a file or to a directory.
 *
 * The function returns the information by overwriting a <TT>GDFileStat</TT>
 * structure, supplied by reference by the application.
 * If the path does not exist, the structure is not overwritten.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, that
 * represents the file or directory whose stats are required.
 * \param filestat Reference to the <TT>GDFileStat</TT> object to be
 * overwritten.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the path exists, and the filestat object was
 * overwritten.
 * \return <TT>NO</TT> otherwise.
 *
 * \see \link
 *  GDFileSystem::fileExistsAtPath:isDirectory:
 *  fileExistsAtPath\endlink
 */

+ (BOOL) removeItemAtPath:(NSString*)filePath error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Delete a file or directory from the secure store (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::removeItemAtPath:error: GDFileManager::removeItemAtPath:\endlink
 * instead.
 * 
 * Call this function to delete a file or directory from the secure store.
 * If the item is a directory then all its contents, files and sub-directories,
 * will also be deleted.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store,
 * of the file or directory to be deleted.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the file or directory existed, and was deleted.
 * \return <TT>NO</TT> otherwise.
 */


+ (GDCReadStream*) getReadStream:(NSString*)filePath error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Open a file that is in the secure store, for reading (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::getReadStream:error: GDFileManager::getReadStream:\endlink
 * instead.
 * 
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
 *
 * \see \ref readFromFile:error:
 */

+ (GDCWriteStream*) getWriteStream:(NSString*)filePath appendmode:(BOOL)flag error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Open a file in the secure store, for writing (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::getWriteStream:appendmode:error: GDFileManager::getWriteStream:\endlink
 * instead.
 * 
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
 *
 * \see \ref writeToFile:name:error: "writeToFile"
 */

+ (NSData*)readFromFile:(NSString*)name error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Read a file that is in the secure store (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::contentsAtPath: GDFileManager::contentsAtPath:\endlink
 * instead of this function.
 * 
 * Call this function to read a file in the secure store.
 * Files in the secure store are encrypted on the device; this
 * function returns decrypted data.
 *
 * This function reads the contents of the file into an <TT>NSData</TT> object
 * with a single API call.
 * Compare \ref getReadStream:error: "getReadStream".
 *
 * \param name <TT>NSString</TT> of the path, within the secure store, that
 * represents the file to be read.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return Reference to an <TT>NSData</TT> object that contains the file's
 * contents.
 */

+ (BOOL)writeToFile:(NSData*)data name:(NSString*)name error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Write a file in the secure store (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::createFileAtPath:contents:attributes: GDFileManager::createFileAtPath:\endlink
 * instead of this function.
 * 
 * Call this function to write a new file in the secure store,
 * or to overwrite an existing file.
 * Files in the secure store are encrypted on the device;
 * data written to the file will be encrypted,
 * transparently to the application.
 *
 * This function writes the contents of the <TT>NSData</TT> object to a file
 * with a single API call. Compare
 * \ref getWriteStream:appendmode:error: "getWriteStream".
 *
 * \param data <TT>NSData</TT> data to be written
 * \param name <TT>NSString</TT> of the path, within the secure store, that
 * represents the file to be written.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the data was all written to the file.
 * \return <TT>NO</TT> otherwise.
 *
 * This function can create a file but cannot create any directory elements of
 * the path.
 * This function will return <TT>NO</TT> if the directory part of the path does
 * not already exist in the secure store.
 */

+ (BOOL)writeToFile:(NSData*)data name:(NSString*)name fromOffset:(NSInteger)offset error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Write into an existing file in the secure store, at an offset into the
 *   file (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. There is no equivalent function that is not
 * deprecated.
 *
 * Call this function to write into an existing file in the secure store
 * at a specified offset inside the file.
 * This function writes the contents of an <TT>NSData</TT> object into the file.
 * Data currently in the file is overwritten.
 * Writing the new data may make the file longer.
 *
 * See \ref writeToFile:name:error: "writeToFile" for general details of
 * writing to files in the secure store.
 *
 * \param data <TT>NSData</TT> containing the data to be written.
 * \param name <TT>NSString</TT> of the path, within the secure store, that
 * represents the file to be written.
 * \param offset <TT>NSInteger</TT> offset at which to start writing. This is
 * relative to the start of the file, as if the contents were not encrypted.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the data was all written to the file.
 * \return <TT>NO</TT> otherwise.
 *
 * This function will return <TT>NO</TT> if the file does not exist, if the
 * offset specified is beyond the file size, or if the input data is empty.
 */

+ (BOOL) createDirectoryAtPath:(NSString*)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary*)attributes error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Create a new directory in the secure store (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::createDirectoryAtPath:withIntermediateDirectories:attributes:error: GDFileManager::createDirectoryAtPath:\endlink
 * instead.
 * 
 * Call this function to create a new directory within the secure
 * file system. The function can create the parent directory, and any other
 * missing intermediate directories in the path.
 *
 * \param path <TT>NSString</TT> of the path to create within the secure store.
 * \param createIntermediates <TT>YES</TT> to have any missing directories on
 * the path created.\n
 * <TT>NO</TT> not to create any missing directories.
 * \param attributes File system attributes to be set on the newly created
 * directory, and any intermediates that were created.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the directory did not exist, and was created.
 * \return <TT>NO</TT> otherwise. Note that <TT>NO</TT> will be returned if
 * <TT>withIntermediateDirectories:NO</TT> is passed and the parent directory
 * does not already exist.
 */

+ (NSArray*)contentsOfDirectoryAtPath:(NSString*)path error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< List contents of a secure file system directory (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::contentsOfDirectoryAtPath:error: GDFileManager::contentsOfDirectoryAtPath:\endlink
 * instead.
 * 
 * This function returns a list of the file and directory names that are in
 * a specified directory of the secure file system.
 *
 * If an error occurs, a reference to an <TT>NSError</TT> object will be
 * returned. The object will contain details of the error.
 * (<TT>NSError</TT> is the conventional iOS object for returning
 * error details.)
 *
 * \param path <TT>NSString</TT> of the path, within the secure store, that
 * represents the directory to be listed.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>NSArray</TT> of <TT>NSString</TT> objects that contain the
 * file and directory names, or <TT>nil</TT> if the path does not exist.
 */


+ (BOOL)fileExistsAtPath:(NSString*)path isDirectory:(BOOL*)isDirectory  DEPRECATE_GDFILESYSTEM;
/**< Check a path exists in the secure store (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::fileExistsAtPath: GDFileManager::fileExistsAtPath:\endlink
 * instead.
 * 
 * Call this function to check if a path exists in the secure file system.
 * The path could be a plain file or a directory.
 *
 * \param path <TT>NSString</TT> of the path, within the secure store,
 * that is to be checked.
 * \param isDirectory Reference to a <TT>BOOL</TT> that will be set to
 * <TT>YES</TT> if the path refers to a directory, or <TT>NO</TT> otherwise.
 *
 * \return <TT>YES</TT> if the path exists within the secure file system.
 * \return <TT>NO</TT> otherwise.
 */



+ (BOOL)moveItemAtPath:(NSString*)srcPath toPath:(NSString*)dstPath error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Move or rename a file or directory within the secure file system
 *   (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::moveItemAtPath:toPath:error: GDFileManager::moveItemAtPath:\endlink
 * instead.
 * 
 * Call this function to move or rename a file or directory within the
 * secure file system.
 *
 * \param srcPath <TT>NSString</TT> of the path, within the secure store, that
 * represents the source item that is to be moved or renamed.
 * \param dstPath <TT>NSString</TT> of the path, within the secure store, that
 * represents the item's destination.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the file or directory existed at the source
 * location, and was moved to the destination location.
 * \return <TT>NO</TT> otherwise.
 */

+ (BOOL) truncateFileAtPath:(NSString*)filePath
                   atOffset:(unsigned long long)offset
                      error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Truncate a file in the secure store (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. There is no equivalent function that is not
 * deprecated.
 *
 * Call this function to truncate a file in the secure store.
 * The file will be truncated to a length specified in bytes.
 *
 * If the file is longer than the offset specified, the file is truncated and
 * the extra data lost.
 * If the file is shorter than the offset then there is no effect; the file
 * will not be extended.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, of
 * the file to truncate.
 * \param offset <TT>unsigned long long</TT> in bytes of the offset at which to
 * truncate the file.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the file existed, the offset was less than the
 * original file size, and the file was truncated successfully.
 * \return <TT>NO</TT> otherwise.
 */

+ (NSString*)getAbsoluteEncryptedPath:(NSString*)filePath DEPRECATE_GDFILESYSTEM;
/**< Get the absolute encrypted path of a file within the secure file system
 *   (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::getAbsoluteEncryptedPath: GDFileManager::getAbsoluteEncryptedPath:\endlink
 * instead.
 * 
 * This function returns the encrypted path for a file or directory within the
 * secure file system. The principal usage for this function is to provide a
 * path that is compatible with the SQL ATTACH command.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, that
 * represents the item for which the encrypted path is required.
 *
 * \return <TT>NSString</TT> containing the encrypted path.
 */

+ (BOOL)exportLogFileToDocumentsFolder:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Dump Good Dynamics logs out to an accessible folder (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::exportLogFileToDocumentsFolder: GDFileManager::exportLogFileToDocumentsFolder:\endlink
 * instead.
 * 
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

+ (BOOL)uploadLogs:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Upload Good Dynamics logs to Good Technology (deprecated).
 * \deprecated This function is in a deprecated class that will be removed
 * in a future release. Use
 * \link GDFileManager::uploadLogs: GDFileManager::uploadLogs:\endlink
 * instead.
 * 
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

+ (BOOL) moveFileToSecureContainer:(NSString*)absoluteFilenameWithPath error:(NSError**)error DEPRECATE_GDFILESYSTEM;
/**< Move file out of the default file system (deprecated).
 * \deprecated This function is deprecated and will be removed in a future
 * release. The recommended way to move a file into the secure file system is as
 * follows: 
 * -# Open a new destination file in the container, using one of the 
 *    \ref GDFileManager functions for opening a file for writing.
 * -# Open the source file in the default file system, using a native function.
 * -# Read the content of the source and write it into the destination.
 * -# Close the destination file, and check for successful closure.
 * -# If closure was successful, delete the source file.
 * 
 * Call this function to move a file from the default file system into the
 * secure store.
 *
 * The file is first added to the store, in an encrypted form. The original file
 * is then deleted. If adding fails for any reason, the original file is not
 * deleted. If deletion of the original fails, the encrypted file in the store
 * is not deleted.
 *
 * The path of the original file in the default file system will be the path of
 * the encrypted file in the secure file system.
 *
 * Note. There is no reverse function that moves a file out of the secure file
 * system.
 *
 * \param absoluteFilenameWithPath <TT>NSString</TT> containing the full path of
 * the file to be moved.
 * \param error For returning an <TT>NSError</TT> object if an error occurs. If <TT>nil</TT>, no object will be returned.
 *
 * \return <TT>YES</TT> if the file was added to the secure store, and the
 *         original deleted.
 * \return <TT>NO</TT> if any part failed.
 */

@end
#undef DEPRECATE_GDFILESYSTEM
#endif /* __GD_FILE_SYSTEM_H__ */
