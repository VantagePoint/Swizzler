/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

#ifndef GD_C_FILESYSTEM_H
#define GD_C_FILESYSTEM_H

#include <stddef.h>
#include <stdarg.h>
#include <stdio.h>
#include <sys/stat.h>

/** \addtogroup capilist
 * @{
 */

typedef size_t GD_FILE;
/**< C API file structure, for accessing secure storage.
 *
 */

typedef size_t GD_DIR;
/**< C API directory structure, for accessing secure storage.
 *
 */

/** @}
 */

#ifdef __cplusplus
extern "C" {
#endif

#ifndef GD_C_API
# define GD_C_API
#endif

#ifndef GD_C_API_EXT
# define GD_C_API_EXT
#endif
    
#if defined(_WIN32)
# define GD_ATTRIBUTE(ignore)
#else
# define GD_ATTRIBUTE __attribute__
#endif
    
#include <stdio.h>

/** \addtogroup capilist
 * @{
 */

GD_C_API GD_FILE* GD_fopen(const char* filename, const char* mode);
/**< Open a file that is in the secure store, for reading or writing.
 * Call this function to open a file in the secure store for reading or writing.
 * Files in the secure store are encrypted on the device; this
 * function provides access to decrypted data.
 *
 * \param filename <TT>const char*</TT> pointer to a C string containing the path, within the secure store, that
 * represents the file to be opened.
 *
 * \param mode <TT>const char*</TT> pointer to a C string of the mode. The values are
 * analogous to the standard C call <TT>fopen</TT> and can be:\n
 *
 * write            "w"\n
 * read             "r"\n
 * append           "a"\n
 *
 * Note that the "+" qualifier is supported for opening a file for both reading and writing.
 *
 * The "b" and "t" qualifiers are not currently supported.
 *
 * \returns <TT>GD_FILE*</TT> object pointer (analogous to the FILE* file pointer returned from <TT>fopen</TT>) which can
 * be used for subsequent file access, or NULL if the file could not be opened / created.\n
 *
 */


GD_C_API int GD_fclose(GD_FILE* filePointer);
/**< Close a file that was previously opened.
 * Call this function to close a file that was previously opened by a call to GD_fopen.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * Note that this should always be called when file access is no longer required. It also forces a flush
 * of any uncommitted write operation.
 *
 * \returns <TT>int</TT> 0 if successful, EOF otherwise
 *
 */

GD_C_API size_t GD_fread(void* ptr, size_t size, size_t count, GD_FILE* filePointer);
/**< Read from a file that is in the secure store, previously opened in read mode with <TT>GD_fopen</TT>
 * Call this function to read a file in the secure store previously opened with <TT>GD_open</TT> in a read
 * mode such as "r" or "w+".
 *
 * \param ptr <TT>void*</TT> pointer to a buffer to receive the read data.
 *
 * \param size <TT>size_t</TT> size of the data block.
 *
 * \param count <TT>size_t</TT> number of data blocks
 *
 * \param filePointer <TT>GD_FILE*</TT> a pointer to a valid GD_FILE* object
 *
 * (Note that the underlying library simply reads size * count bytes from the encrypted file system)
 *
 * \returns <TT>size_t</TT> The total number of elements successfully read is returned.
 * If this number differs from the count parameter, either a reading error occurred or the end-of-file was reached while reading.
 * In both cases, the proper indicator is set, which can be checked with ferror and feof, respectively.
 * If either size or count is zero, the function returns zero and both the stream state and the content pointed by ptr remain unchanged.
 * size_t is an unsigned integral type.
 *
 */

GD_C_API size_t GD_fwrite(const void* ptr, size_t size, size_t count, GD_FILE* filePointer);
/**< Write to a file that is in the secure store, previously opened in write mode with <TT>GD_fopen</TT>
 * Call this function to read a file in the secure store previously opened with <TT>GD_open</TT> in a read
 * mode such as "w" or "r+".
 *
 * \param ptr <TT>void*</TT> pointer to a buffer containing the data to be written
 *
 * \param size <TT>size_t</TT> size of the data block.
 *
 * \param count <TT>size_t</TT> number of data blocks
 *
 * \param filePointer <TT>GD_FILE*</TT> a pointer to a valid GD_FILE* object
 *
 * (Note that the underlying library simply writes size * count bytes to the encrypted file system)
 *
 * \returns <TT>size_t</TT> The total number of elements successfully written is returned.
 * If this number differs from the count parameter, a writing error prevented the function from completing. In this case, the error indicator (ferror) will be set for the stream.
 * If either size or count is zero, the function returns zero and the error indicator remains unchanged.
 * size_t is an unsigned integral type.
 *
 */

GD_C_API int GD_remove(const char* filename);
/**< Delete a file.
 * Call this function to delete a file by path
 *
 * \param filename <TT>const char*</TT> the path of the field to be deleted
 *
 * \returns <TT>int</TT> 0 if successful, -1 otherwise.
 */

GD_C_API long int GD_ftell(GD_FILE* filePointer);
/**< Get the current position of the file pointer.
 * Call this function obtain the current file pointer position.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>long int</TT> the position of the file pointer or -1 if an error has occurred.
 *
 */

GD_C_API off_t GD_ftello(GD_FILE* filePointer);
/**< Get the current position of the file pointer.
 * Call this function obtain the current file pointer position.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>off_t</TT> the position of the file pointer or -1 if an error has occurred.
 *
*/
    
GD_C_API int GD_fseek(GD_FILE* filePointer, long int offset, int origin);
/**< Set the position of the file pointer
 * Call this function to set the file pointer position.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \param offset <TT>long int</TT> offset relative to the origin parameter
 *
 * \param origin <TT>int</TT> one of SEEK_SET, SEEK_CUR, SEEK_END
 *
 * \returns <TT>int</TT> 0 for success or -1 for failure
 *
 */
    
GD_C_API int GD_fseeko(GD_FILE* filePointer, off_t offset, int origin);
/**< Set the position of the file pointer
 * Call this function to set the file pointer position.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \param offset <TT>off_t</TT> offset relative to the origin parameter
 *
 * \param origin <TT>int</TT> one of SEEK_SET, SEEK_CUR, SEEK_END
 *
 * \returns <TT>int</TT> 0 for success or -1 for failure
 *
 */
    
GD_C_API int GD_fscanf(GD_FILE* filePointer, const char*  format, ...) GD_ATTRIBUTE((format(scanf,2,3)));
/**< Read formatted data from stream.
 * Reads data from the stream and stores them according to the parameter format into the locations pointed by 
 * the additional arguments. The additional arguments should point to already allocated objects of the type specified 
 * by their corresponding format specifier (subsequences beginning with %) within the format string.
 *
 * \param filePointer Pointer to a <TT>GD_FILE</TT> object that identifies an input stream to read data from.
 *
 * \param format C string that contains a sequence of characters that control how characters extracted from the stream are treated.
 *
 * \returns <TT>int</TT> On success, the function returns the number of items of the argument list successfully filled.
 * On error, the function returns EOF and sets the error indicator (ferror).
 */

    
GD_C_API int GD_vfscanf(GD_FILE* filePointer, const char * format, va_list args) GD_ATTRIBUTE((format(scanf,2,0)));
/**< Read formatted data from stream into variable argument list.
 * Reads data from the stream and stores them according to parameter format into the locations pointed to by the elements
 * in the variable argument list identified by args.
 *
 * Internally, the function retrieves arguments from the list identified by arg as if va_arg was used on it, 
 * and thus the state of arg is likely to be altered by the call.
 *
 * In any case, arg should have been initialized by va_start at some point before the call, 
 * and it is expected to be released by va_end at some point after the call.
 *
 * \param filePointer Pointer to a <TT>GD_FILE</TT> object that identifies an input stream.
 *
 * \param format C string that contains a format string that follows the same specification as scanf (see scanf for details).
 *
 * \param args A value identifying a variable arguments list initialized with va_start. va_list is a special type defined in &lt;stdarg.h&gt; file.
 *
 * \returns <TT>int</TT> On success, the function returns the number of items of the argument list successfully filled.
 * On error, the function returns EOF and sets the error indicator (ferror).
 */
    
GD_C_API int GD_feof(GD_FILE* filePointer);
/**< Test if the file pointer is at the end of the file
 * Call this function to check if the file pointer is at the end of the file.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>int</TT> non-zero if the end of file indicator is set, otherwise 0
 */

GD_C_API char* GD_tmpnam(char* str);
/**< Generate a unique file name
 * Call this function to check or generate a unique file name
 *
 * \param str <TT>char*</TT> an array of bytes of at least <TT>L_tmpnam</TT> length to contain the proposed file name. If
 * this argument is NULL then an internal static array is used.
 *
 * \returns <TT>char*</TT> a pointer to a unique filename. If the <TT>str</TT> argument is not NULL then the pointer will refer to
 * this array otherwise it will point to an internal static array. If the function cannot create a unique filename then NULL is
 * returned.
 */

GD_C_API int GD_truncate(const char* filename, off_t length);
/**< Truncate a file that is in the secure store.
 * Call this function to truncate a file in the secure store to a specified length.
 * If file was previously larger than the length specified, the file will be truncated and the
 * extra data lost. If the file was previously smaller than the length specified, the file will be
 * extended and padded with null bytes ('\0').
 *
 * \param filename <TT>const char*</TT> pointer to a C string containing the path, within the secure store, that
 * represents the file to be truncated.
 *
 * \param length <TT>off_t</TT> in bytes of the file once truncated.
 *
 * \returns <TT>int</TT> 0 for success or -1 for failure
 */

GD_C_API int GD_ftruncate(GD_FILE* filePointer, off_t length);
/**< Truncate a file that is in the secure store.
 * Call this function to truncate a file in the secure store to a specified length.
 * If file was previously larger than the length specified, the file will be truncated and the extra
 * data lost. If the file was previously smaller than the length specified, the file will be
 * extended and padded with null bytes ('\0').
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \param length <TT>off_t</TT> in bytes of the file once truncated.
 *
 * \returns <TT>int</TT> 0 for success or -1 for failure
 */

GD_C_API GD_FILE* GD_freopen(const char* filename, const char* mode, GD_FILE* filePointer);
/**< Reopen stream with different file or mode.
 * Reuses stream to either open the file specified by filename or to change its access mode.
 * If a new filename is specified, the function first attempts to close any file already associated with filePointer
 * (third parameter) and disassociates it.
 * Then, independently of whether that filePointer was successfuly closed or not, 
 * freopen opens the file specified by filename and associates it with the filePointer just as fopen would do using the specified mode.
 * If filename is a null pointer, the function attempts to change the mode of the filePointer. 
 * The error indicator and eof indicator are automatically cleared (as if clearerr was called).
 *
 * \param filename <TT>const char*</TT> C string containing the name of the file to be opened.
 *
 * \param mode <TT>const char*</TT> pointer to a C string of the mode. The values are
 * analogous to the standard C call <TT>fopen</TT> and can be:\n
 *
 * write            "w"\n
 * read             "r"\n
 * append           "a"\n
 *
 * Note that the "+" qualifier is supported for opening a file for both reading and writing.
 *
 * The "b" and "t" qualifiers are not currently supported.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>GD_FILE*</TT>  If the file is successfully reopened, the function returns the pointer passed as parameter filePointer, 
 * which can be used to identify the reopened stream.
 * Otherwise, a null pointer is returned.
 */

GD_C_API int GD_fgetpos(GD_FILE* filePointer, fpos_t* pos);
/**< Get current position in stream.
 * Retrieves the current position in the stream. 
 * The function fills the fpost_t object pointed by pos with the information needed from the filePointer's position indicator 
 * to restore the stream to its current position (and multibyte state, if wide-oriented) with a call to fsetpos.
 * The ftell function can be used to retrieve the current position in the stream as an integer value.
 * 
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 * 
 * \param pos <TT>fpos_t</TT> Pointer to a fpos_t object.
 *
 * \returns <TT>int</TT> On success, the function returns zero.
 * In case of error, errno is set to a platform-specific positive value and the function returns a non-zero value.
 */
   
GD_C_API int GD_fsetpos(GD_FILE* filePointer, const fpos_t* pos);
/**< Set position indicator of stream.
 * Restores the current position in the stream to pos.
 * The internal file position indicator associated with stream is set to the position represented by pos, 
 * which is a pointer to an fpos_t object whose value shall have been previously obtained by a call to fgetpos.
 * The end-of-file internal indicator of the stream is cleared after a successful call to this function, 
 * and all effects from previous calls to ungetc on this stream are dropped.
 * On streams open for update (read+write), a call to fsetpos allows to switch between reading and writing.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \param pos <TT>fpos_t</TT> Pointer to a fpos_t object containing a position previously obtained with fgetpos.
 *
 * \returns <TT>int</TT> On success, the function returns zero.
 * On failure, a non-zero value is returned and errno is set to a system-specific positive value.
 */

GD_C_API void GD_rewind(GD_FILE* filePointer);
/**< Set position of stream to the beginning.
 * Sets the position indicator associated with stream to the beginning of the file.
 * The end-of-file and error internal indicators associated to the stream are cleared after a successful call to this function,
 * and all effects from previous calls to ungetc on this stream are dropped.
 * TBC::On streams open for update (read+write), a call to rewind allows to switch between reading and writing.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 * 
 * \returns none
 */

GD_C_API int GD_fgetc(GD_FILE* filePointer);
/**< Get character from stream
 * Returns the character currently pointed by the internal file position indicator of the specified stream. 
 * The internal file position indicator is then advanced to the next character.
 * If the stream is at the end-of-file when called, the function returns EOF and sets the end-of-file indicator for the stream (feof). 
 * If a read error occurs, the function returns EOF and sets the error indicator for the stream (ferror).
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 * 
 * \returns <TT>int</TT> On success, the character read is returned (promoted to an int value).
 * The return type is int to accommodate for the special value EOF, which indicates failure:
 * If the position indicator was at the end-of-file, the function returns EOF and sets the eof indicator (feof) of stream.
 * If some other reading error happens, the function also returns EOF, but sets its error indicator (ferror) instead.
 */
    
GD_C_API char* GD_fgets(char* buf, int count, GD_FILE* filePointer);
/**< Get string from stream.
 * Reads characters from stream and stores them as a C string into str 
 * until (num-1) characters have been read or either a newline or the end-of-file is reached, whichever happens first.
 * A newline character makes fgets stop reading, but it is considered a valid character by the function and included in the string copied to str.
 * A terminating null character is automatically appended after the characters copied to str.
 *
 * \param buf <TT>char*</TT> Pointer to an array of chars where the string read is copied.
 *
 * \param count <TT>int</TT> Maximum number of characters to be copied into str (including the terminating null-character).
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>char*</TT> On success, the function returns str.
 * If the end-of-file is encountered while attempting to read a character, the eof indicator is set (feof).
 * If this happens before any characters could be read, the pointer returned is a null pointer 
 * (and the contents of str remain unchanged).
 * If a read error occurs, the error indicator (ferror) is set and a null pointer is also returned 
 * (but the contents pointed by str may have changed).
 */
    
GD_C_API int GD_fputc(int character, GD_FILE* filePointer);
/**< Write character to stream.
 * Writes a character to the stream and advances the position indicator.
 * The character is written at the position indicated by the internal position indicator of the stream, 
 * which is then automatically advanced by one.
 * 
 * \param character <TT>int</TT> The int promotion of the character to be written.
 * The value is internally converted to an unsigned char when written.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>int</TT> On success, the character written is returned.
 * If a writing error occurs, EOF is returned and the error indicator (ferror) is set.
 */
 
GD_C_API int GD_fputs(const char* buf, GD_FILE* filePointer);
/**< Write string to stream.
 * Writes the C string pointed by str to the stream.
 * The function begins copying from the address specified (str) until it reaches the terminating null character ('\0'). 
 * This terminating null-character is not copied to the stream.
 *
 * \param buf <TT>const char*</TT> C string with the content to be written to stream.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>int</TT> On success, a non-negative value is returned.
 * On error, the function returns EOF and sets the error indicator (ferror).
 */

GD_C_API int GD_fprintf(GD_FILE* filePointer, const char*  format, ...) GD_ATTRIBUTE((format(printf,2,3)));
/**< Write formatted data to stream.
 * Writes the C string pointed by format to the stream. If format includes format specifiers (subsequences beginning 
 * with %), the additional arguments following format are formatted and inserted in the resulting string replacing 
 * their respective specifiers.
 *
 * \param filePointer Pointer to a <TT>GD_FILE</TT> object that identifies an output stream.
 *
 * \param format C string that contains the text to be written to the stream. It can optionally contain embedded format
 * specifiers that are replaced by the values specified in subsequent additional arguments and formatted as requested.
 *
 * \returns <TT>int</TT> On success, the total number of characters written is returned.
 * On error, the function returns EOF and sets the error indicator (ferror).
 */

GD_C_API int GD_vfprintf(GD_FILE* filePointer, const char * format, va_list args) GD_ATTRIBUTE((format(printf,2,0)));
/**< Write formatted data from variable argument list to stream.
 * Writes the C string pointed by format to the stream, replacing any format specifier in the same way as printf does, but 
 * using the elements in the variable argument list identified by arg instead of additional function arguments.
 *
 * Internally, the function retrieves arguments from the list identified by arg as if va_arg was used on it, and thus the 
 * state of arg is likely altered by the call.
 *
 * In any case, arg should have been initialized by va_start at some point before the call, and it is expected to be released 
 * by va_end at some point after the call.
 *
 * \param filePointer Pointer to a <TT>GD_FILE</TT> object that identifies an output stream.
 *
 * \param format C string that contains a format string that follows the same specifications as format in printf (see printf for details).
 *
 * \param args A value identifying a variable arguments list initialized with va_start. va_list is a special type defined in the &lt;stdarg.h&gt; file.
 *
 * \returns <TT>int</TT> On success, the total number of characters written is returned.
 * On error, the function returns EOF and sets the error indicator (ferror).
 */
    
GD_C_API int GD_rename(const char* oldname, const char* newname);
/**< Rename file.
 * Changes the name of the file or directory specified by oldname to newname.
 * This is an operation performed directly on a file; No streams are involved in the operation.
 * If oldname and newname specify different paths and this is supported by the system,
 * the file is moved to the new location.
 * If newname names an existing file, the function may either fail or override the existing file,
 * depending on the specific system and library implementation.
 *
 * \param oldname <TT>const char*</TT> C string containing the name of an existing file to be renamed and/or moved.
 *
 * \param newname <TT>const char*</TT> C string containing the new name for the file.
 *
 * \returns <TT>int</TT> If the file is successfully renamed, a zero value is returned.
 * On failure, a nonzero value is returned.
 */
  
GD_C_API int GD_setvbuf(GD_FILE* filePointer, char* buf, int mode, size_t size);
/**< Change stream buffering
 * Specifies a buffer for stream. The function allows to specify the mode and size of the buffer (in bytes).
 * If buffer is a null pointer, the function automatically allocates a buffer (using size as a hint on the size to use).
 * Otherwise, the array pointed by buffer may be used as a buffer of size bytes.
 * This function should be called once the stream has been associated with an open file, 
 * but before any input or output operation is performed with it.
 * A stream buffer is a block of data that acts as intermediary between the i/o operations and the physical file associated to the stream:
 * For output buffers, data is output to the buffer until its maximum capacity is reached, then it is flushed
 * (i.e.: all data is sent to the physical file at once and the buffer cleared).
 * Likewise, input buffers are filled from the physical file, from which data is sent to the operations until exhausted,
 * at which point new data is acquired from the file to fill the buffer again.
 * Stream buffers can be explicitly flushed by calling fflush. 
 * They are also automatically flushed by fclose and freopen, or when the program terminates normally.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \param buf <TT>char*</TT> User allocated buffer. Shall be at least size bytes long.
 * If set to a null pointer, the function automatically allocates a buffer.
 *
 * \param mode <TT>int</TT> Specifies a mode for file buffering.(_IOFBF, _IOLBF and _IONBF)
 *
 * \param size <TT>size_t</TT> Buffer size, in bytes.
 * If the buffer argument is a null pointer, this value may determine the size automatically allocated by the function for the buffer.
 *
 * \returns <TT>int</TT> If the buffer is correctly assigned to the file, a zero value is returned.
 * Otherwise, a non-zero value is returned; 
 * This may be due to an invalid mode parameter or to some other error allocating or assigning the buffer.
 */

GD_C_API void GD_setbuffer(GD_FILE* filePointer, char* buf, int size);
/**< Change stream buffering
 * Specifies a buffer for stream. The function allows to specify the size of the buffer (in bytes).
 * If buffer is a null pointer, the function automatically allocates a buffer (using size as a hint on the size to use).
 * Otherwise, the array pointed by buffer may be used as a buffer of size bytes.
 * This function should be called once the stream has been associated with an open file,
 * but before any input or output operation is performed with it.
 * A stream buffer is a block of data that acts as intermediary between the i/o operations and the physical file associated to the stream:
 * For output buffers, data is output to the buffer until its maximum capacity is reached, then it is flushed
 * (i.e.: all data is sent to the physical file at once and the buffer cleared).
 * Likewise, input buffers are filled from the physical file, from which data is sent to the operations until exhausted,
 * at which point new data is acquired from the file to fill the buffer again.
 * Stream buffers can be explicitly flushed by calling fflush.
 * They are also automatically flushed by fclose and freopen, or when the program terminates normally.
 *
 * Except for the lack of a return value, the GD_setbuffer function is exactly equivalent to the call
 * setvbuf(stream, buf, buf ? _IOFBF : _IONBF, size);
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \param buf <TT>char*</TT> User allocated buffer. Shall be at least size bytes long.
 * If set to a null pointer, the function automatically allocates a buffer.
 *
 * \param size <TT>int</TT> Buffer size, in bytes.
 * If the buffer argument is a null pointer, this value may determine the size automatically allocated by the function for the buffer.
 */

GD_C_API void GD_setbuf(GD_FILE* filePointer, char* buf);
/**< Change stream buffering
 * Specifies a buffer for stream.
 * If buffer is a null pointer, the function automatically allocates a buffer.
 * Otherwise, the array pointed by buffer may be used as a buffer of size BUFSIZ.
 * This function should be called once the stream has been associated with an open file,
 * but before any input or output operation is performed with it.
 * A stream buffer is a block of data that acts as intermediary between the i/o operations and the physical file associated to the stream:
 * For output buffers, data is output to the buffer until its maximum capacity is reached, then it is flushed
 * (i.e.: all data is sent to the physical file at once and the buffer cleared).
 * Likewise, input buffers are filled from the physical file, from which data is sent to the operations until exhausted,
 * at which point new data is acquired from the file to fill the buffer again.
 * Stream buffers can be explicitly flushed by calling fflush.
 * They are also automatically flushed by fclose and freopen, or when the program terminates normally.
 *
 * Except for the lack of a return value, the GD_setbuf() function is exactly equivalent to the call
 * GD_setvbuf(filePointer, buf, buf ? _IOFBF : _IONBF, BUFSIZ);
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \param buf <TT>char*</TT> User allocated buffer. Shall be BUFSIZ bytes long.
 * If set to a null pointer, the function automatically allocates a buffer.
 *
 */
    
GD_C_API int GD_fflush(GD_FILE* filePointer);
/**< Flush stream
 * If the given stream was open for writing (or if it was open for updating and the last i/o operation was an output operation) 
 * any unwritten data in its output buffer is written to the file.
 * If stream is a null pointer, all such streams are flushed.
 * In all other cases, the behavior depends on the specific library implementation.
 * In some implementations, flushing a stream open for reading causes its input buffer to be cleared (but this is not portable expected behavior).
 * The stream remains open after this call.
 * When a file is closed, either because of a call to fclose or because the program terminates, all the buffers associated with it are automatically flushed.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>int</TT> A zero value indicates success.
 * If an error occurs, EOF is returned and the error indicator is set (see ferror).
 */
    
GD_C_API void GD_clearerr(GD_FILE* filePointer);
/**< Clear error indicators
 * Resets both the error and the eof indicators of the stream.
 * When a i/o function fails either because of an error or because the end of the file has been reached, 
 * one of these internal indicators may be set for the stream. 
 * The state of these indicators is cleared by a call to this function, 
 * or by a call to any of: rewind, fseek, fsetpos and freopen.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns None
 */
    
GD_C_API int GD_ferror(GD_FILE* filePointer);
/**< Check error indicator.
 * Checks if the error indicator associated with stream is set, returning a value different from zero if it is.
 * This indicator is generally set by a previous operation on the stream that failed, 
 * and is cleared by a call to clearerr, rewind or freopen.
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>int</TT> A non-zero value is returned in the case that the error indicator associated with the stream is set.
 * Otherwise, zero is returned.
 */

GD_C_API int GD_mkdir(const char* dirname, mode_t mode);
/**< Create a directory at the specified path
 * The directory path is created at the path specified. The mode parameter is not used and exists here for compatability.
 *
 * \param dirname <TT>const char*</TT> directory path to be created.
 *
 * \param mode <TT>mode</TT> not used (all directories are rwx)
 *
 * \returns <TT>int</TT>
 */
    
GD_C_API GD_DIR* GD_opendir(const char *dirname);
/**< Open a directory at specified path.
 * The opendir() function opens the directory named by dirname, associates a directory stream with it, and returns a pointer 
 * to be used to identify the directory stream in subsequent operations.  The pointer NULL is returned if dirname cannot be 
 * accessed or if it cannot malloc(3) enough memory to hold the whole thing.
 *
 * \param dirname <TT>char*</TT> string of the path to the directory.\n
 *
 * \returns <TT>GD_DIR*</TT> object which represents the directory, NULL is returned in the case of an error.\n
 */
    
GD_C_API int GD_closedir(GD_DIR *dirp);
/**< Close an already opened directory stream.
 * The closedir() function closes the named directory stream and frees the structure associated with the dirp pointer, 
 * returning 0 on success.  On failure, -1 is returned and the global variable errno is set to indicate the error.
 *
 * \param dirp <TT>GD_DIR*</TT> directory stream to close
 *
 * \returns <TT>int</TT> 0 on success, -1 on failure
 */
    
GD_C_API struct dirent* GD_readdir(GD_DIR *dirp);
/**< 
 * The readdir() function returns a pointer to the next directory entry.  It returns NULL upon reaching the end of the 
 * directory or detecting an invalid seekdir() operation.
 *
 * \param dirp <TT>dirp</TT> directory stream to read from.\n
 *
 * \returns <TT>struct dirent*</TT> pointer to a directory entry or NULL if the end has been reached.\n
 */
    
GD_C_API int GD_readdir_r(GD_DIR* dirp, struct dirent* entry, struct dirent** result);
/**<
 * readdir_r() provides the same functionality as readdir(), but the caller must provide a directory entry buffer to 
 * store the results in.  If the read succeeds, result is pointed at the entry; upon reaching the end of the directory, 
 * result is set to NULL.  readdir_r() returns 0 on success or an error number to indicate failure.
 *
 * \param dirp <TT>GD_DIR*</TT> directory stream to use.\n
 *
 * \param entry <TT>struct dirent*</TT> caller provided buffer to store the directory entry.\n
 *
 * \param result <TT>struct dirent**</TT> on sucess result is pointed to entry.\n
 *
 * \returns <TT>int</TT> 0 on success, -1 on failure.\n
 */
    
GD_C_API void GD_rewinddir(GD_DIR *dirp);
/**<
 * The rewinddir() function resets the position of the named directory stream to the beginning of the directory.
 *
 * \param dirp <TT>GD_DIR*</TT> directory stream to use.\n
 */
    
GD_C_API void GD_seekdir(GD_DIR *dirp, long loc);
/**<
 * The seekdir() function sets the position of the next readdir() operation on the directory stream.  The new 
 * position reverts to the one associated with the directory stream when the telldir() operation was performed.
 * 
 * \param dirp <TT>GD_DIR*</TT> directory stream to use.\n
 *
 * \param loc <TT>long</TT> position to seek to.\n
 */
    
GD_C_API long GD_telldir(GD_DIR *dirp);
/**<
 * The telldir() function returns the current location associated with the named directory stream.  Values 
 * returned by telldir() are good only for the lifetime of the DIR pointer (e.g., dirp) from which they are 
 * derived.  If the directory is closed and then reopened, prior values returned by telldir() will no longer 
 * be valid.
 *
 * \param dirp <TT>GD_DIR*</TT> directory stream to use.\n
 * 
 * \return <TT>long</TT> current location in the stream.\n
 */
    
GD_C_API int GD_stat(const char* path, struct stat* buf);
/**<
 * The stat() function obtains information about the file pointed to by path.  Read, write or execute permission 
 * of the named file is not required, but all directories listed in the path name leading to the file must be
 * searchable.
 *
 * \param path <TT>const char*</TT> pointer to a C string containing the path to the file.\n
 *
 * \param buf <TT>struct stat*</TT> buffer in which to write the stat data.\n
 *
 * \return <TT>int</TT> 0 on success, -1 on failure.\n
 */
    
GD_C_API int GD_getc(GD_FILE* filePointer);
/**< Get character from stream.
 * Returns the character currently pointed by the internal file position indicator of the specified stream.
 * The internal file position indicator is then advanced to the next character.
 * If the stream is at the end-of-file when called, the function returns EOF and sets the end-of-file indicator for the stream (feof).
 * If a read error occurs, the function returns EOF and sets the error indicator for the stream (ferror).
 *
 * \param filePointer <TT>GD_FILE*</TT> object which was returned by a previous call to <TT>GD_fopen</TT>.\n
 *
 * \returns <TT>int</TT> On success, the character read is returned (promoted to an int value).
 * The return type is int to accommodate for the special value EOF, which indicates failure:
 * If the position indicator was at the end-of-file, the function returns EOF and sets the eof indicator (feof) of stream.
 * If some other reading error happens, the function also returns EOF, but sets its error indicator (ferror) instead.
 */

GD_C_API int GD_ungetc(int character, GD_FILE* filePointer);
/**<
 * The GD_ungetc() function pushes the character c (converted to an unsigned char) back onto the input stream
 * pointed to by stream.  The pushed-back characters will be returned (in reverse order) by subsequent reads
 * on the stream.  A successful intervening call to one of the file positioning functions using the same stream,
 * will discard the pushed-back characters.
 *
 * \returns The <TT>GD_ungetc</TT> function returns the character pushed-back after the conversion, or EOF if the operation
 * fails.  If the value of the argument c character equals EOF, the operation will fail and the stream will
 * remain unchanged.
 */
    
#ifdef __cplusplus
}
#endif

/** @}
 */

#endif // GD_C_FILESYSTEM_H
