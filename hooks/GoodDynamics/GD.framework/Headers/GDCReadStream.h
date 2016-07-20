/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef __GDC_READ_STREAM_H__
#define __GDC_READ_STREAM_H__

#import <Foundation/Foundation.h>

/** NSInputStream subclass for reading files that are in the secure store.
 * This class is a subclass of the Foundation <TT>NSInputStream</TT> class
 * for use when reading files in the secure store (see \ref GDFileSystem).
 * The subclass supports the <TT>read</TT> and <TT>hasBytesAvailable</TT>
 * member functions of <TT>NSInputStream</TT>. The subclass does not support
 * <TT>getBuffer</TT>, which will always return <TT>NO</TT>. And it does not
 * support  <TT>scheduleInRunLoop</TT> or <TT>removeFromRunLoop</TT> which
 * are not required as the file data can be read immediately.
 *
 * This documentation includes only additional operations provided by
 * GDCReadStream that are not part of <TT>NSInputStream</TT>.
 *
 * \par Notes on use of the read function
 * This class's <TT>read</TT> function will work best when the supplied buffer
 * is a multiple of 16 bytes in length.
 * The <TT>maxLength</TT> parameter should reflect the size of the buffer, and
 * not the amount of data remaining to be read from the file.
 * To read a particular number of bytes, <EM>B</EM>, supply a buffer whose size
 * is <EM>B </EM>rounded up to the next multiple of 16.\n
 * The return value of this class's <TT>read</TT> function must always be
 * checked by the application. It must <EM>not </EM>be assumed that a
 * file has been completely read into a buffer, even if the buffer is large
 * enough to accomodate the whole file.
 *
 * \see <A
 *     HREF="http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSInputStream_Class"
 *     target="_blank"
 * >NSInputStream class reference in the iOS Developer Library on apple.com</A>
 * \see \ref GDCWriteStream
 */
@interface GDCReadStream : NSInputStream <NSStreamDelegate> {
    @private
    void* m_internalReader;
    int m_streamError;
    unsigned int m_offset;
    NSStreamStatus m_streamStatus;
    id <NSStreamDelegate> m_delegate;
}

- (id) initWithFile:(NSString*)filePath;
/**< Constructor that opens a file in the secure store, for reading.
 * Call this function to open a file in the secure store for reading.
 * Files in the secure store are encrypted on the device; this
 * function provides access to decrypted data.
 *
 * Note. This constructor is used by the
 * \link GDFileSystem::getReadStream:error: getReadStream\endlink function in
 * the \ref GDFileSystem class.
 *
 * \param filePath <TT>NSString</TT> of the path, within the secure store, that
 * represents the file to be opened.
 *
 * \returns <TT>nil</TT> if the file could not be opened.
 */

- (BOOL)seekToFileOffset:(unsigned long long)offset;
/**< Seek in an open file in the secure file system.
 * Call this function to move the file pointer to a specific offset
 * from the start of the stream.
 *
 * \param offset Required offset, expressed as a number of bytes
 * from the start of the file. Zero means the start of the file.
 *
 * \returns <TT>YES</TT> if the file pointer was moved to the required
 * offset.
 * \returns <TT>NO</TT> Otherwise.
 */


- (NSError*) streamError;
/**< Get the last error.
 * Call this function to get the last error associated with the open stream.
 *
 * \returns Reference to an <TT>NSError</TT> object that describes the error.
 * \see \ref gdfilesystemerrordomain
 */

@end

#endif /* __GDC_READ_STREAM_H__ */
