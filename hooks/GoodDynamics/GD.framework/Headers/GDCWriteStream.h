/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef __GDC_WRITE_STREAM_H__
#define __GDC_WRITE_STREAM_H__

#import <Foundation/Foundation.h>

/** NSOutputStream subclass for writing files in the secure store.
 * This class is a subclass of the Foundation <TT>NSOutputStream</TT> class
 * for use when writing files in the secure store (see \ref GDFileSystem).
 * The subclass supports the <TT>write</TT> and <TT>hasSpaceAvailable</TT>
 * member functions of <TT>NSOutputStream</TT>. The subclass does not
 * support <TT>scheduleInRunLoop</TT> or <TT>removeFromRunLoop</TT> which are
 * not required as the file data can be written immediately.
 *
 * This documentation includes only additional operations provided by
 * GDCWriteStream that are not part of <TT>NSOutputStream</TT>.
 *
 * \see <A
 *    HREF="http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSOutputStream_Class"
 *    target="_blank"
 * >NSOutputStream class reference in the iOS Developer Library on apple.com</A>
 * \see GDCReadStream
 */
@interface GDCWriteStream : NSOutputStream <NSStreamDelegate> {
    @private
    void* m_internalWriter;
    int m_streamError;
    NSStreamStatus m_streamStatus;
    id <NSStreamDelegate> m_delegate;
}

- (id) initWithFile:(NSString*)filePath append:(BOOL) shouldAppend;
/**< Constructor that opens or creates a file in the secure store,
 * for writing.
 * Call this function to create a new file in the secure store,
 * or to open an existing file for writing.
 * Files in the secure store are encrypted on the device;
 * data written to the stream returned by this function will be encrypted,
 * transparently to the application.
 *
 * If a file already exists at the specified path, the file can either be
 * appended to, or overwritten.
 *
 * Note. This constructor is used by the
 * \link GDFileSystem::getWriteStream:appendmode:error: getWriteStream\endlink
 * function in the \ref GDFileSystem class.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, that
 * represents the file to be opened.
 *
 * \param shouldAppend Selects the action to take if a file already exists
 * at the path.
 * <TT>YES</TT> to append to the file, or <TT>NO</TT> to overwrite.
 *
 * \returns <TT>nil</TT> if the file could not be opened.
 */

- (NSError*) streamError;
/**< Get the last error.
 * Call this function to get the last error associated with the open stream.
 *
 * \returns Reference to an <TT>NSError</TT> object that describes the error.
 * \see \ref gdfilesystemerrordomain
 */

@end

#endif /* __GDC_WRITE_STREAM_H__ */
