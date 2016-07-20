/*
 File Description:
  
	**************************
	** Foundation NSString  **
	**************************

	The NSString class declares the programmatic interface for an object that manages immutable strings. 
	An immutable string is a text string that is defined when it is created and subsequently cannot be changed. 
	NSString is implemented to represent an array of Unicode characters, in other words, a text string.

*/
%group NSString
%hook NSString

/*
 Creating and Initializing Strings

 + string
 - init
 - initWithBytes:length:encoding:
 - initWithBytesNoCopy:length:encoding:freeWhenDone:
 - initWithCharacters:length:
 - initWithCharactersNoCopy:length:freeWhenDone:
 - initWithString:
 - initWithCString:encoding:
 - initWithUTF8String:
 - initWithFormat:
 - initWithFormat:arguments:
 - initWithFormat:locale:
 - initWithFormat:locale:arguments:
 - initWithData:encoding:
 + stringWithFormat:
 + localizedStringWithFormat:
 + stringWithCharacters:length:
 + stringWithString:
 + stringWithCString:encoding:
 + stringWithUTF8String:


 Creating and Initializing a String from a File
 
 + stringWithContentsOfFile:encoding:error:
 - initWithContentsOfFile:encoding:error:
 + stringWithContentsOfFile:usedEncoding:error:
 - initWithContentsOfFile:usedEncoding:error:


 Creating and Initializing a String from an URL
 
 + stringWithContentsOfURL:encoding:error:
 - initWithContentsOfURL:encoding:error:
 + stringWithContentsOfURL:usedEncoding:error:
 - initWithContentsOfURL:usedEncoding:error:
*/

 
/*
 Writing to a File or URL
 
 - writeToFile:atomically:encoding:error:
 - writeToURL:atomically:encoding:error:
*/

// - (BOOL)writeToFile:(NSString *)path
//          atomically:(BOOL)useAuxiliaryFile
//            encoding:(NSStringEncoding)enc
//               error:(NSError **)error
// {

// }

// - (BOOL)writeToURL:(NSURL *)url
//         atomically:(BOOL)useAuxiliaryFile
//           encoding:(NSStringEncoding)enc
//              error:(NSError **)error
// {
	
// }


/*
 Getting a String’s Length

 - lengthOfBytesUsingEncoding:
 - maximumLengthOfBytesUsingEncoding:
 

 Getting Characters and Bytes
 
 - characterAtIndex:
 - getCharacters:range:
 - getBytes:maxLength:usedLength:encoding:options:range:remainingRange:
 
 
 Getting C Strings
 
 - cStringUsingEncoding:
 - getCString:maxLength:encoding:
 

 Combining Strings
 
 - stringByAppendingFormat:
 - stringByAppendingString:
 - stringByPaddingToLength:withString:startingAtIndex:
 

 Dividing Strings
 
 - componentsSeparatedByString:
 - componentsSeparatedByCharactersInSet:
 - stringByTrimmingCharactersInSet:
 - substringFromIndex:
 - substringWithRange:
 - substringToIndex:
 

 Finding Characters and Substrings
 - rangeOfCharacterFromSet:
 - rangeOfCharacterFromSet:options:
 - rangeOfCharacterFromSet:options:range:
 - rangeOfString:
 - rangeOfString:options:
 - rangeOfString:options:range:
 - rangeOfString:options:range:locale:
 - enumerateLinesUsingBlock:
 - enumerateSubstringsInRange:options:usingBlock:



 Replacing Substrings
 
 - stringByReplacingOccurrencesOfString:withString:
 - stringByReplacingOccurrencesOfString:withString:options:range:
 - stringByReplacingCharactersInRange:withString:
 
 
 Determining Line and Paragraph Ranges
 
 - getLineStart:end:contentsEnd:forRange:
 - lineRangeForRange:
 - getParagraphStart:end:contentsEnd:forRange:
 - paragraphRangeForRange:
 
 
 Determining Composed Character Sequences
 
 - rangeOfComposedCharacterSequenceAtIndex:
 - rangeOfComposedCharacterSequencesForRange:
 
 
 Converting String Contents Into a Property List
 
 - propertyList
 - propertyListFromStringsFileFormat


 Identifying and Comparing Strings
 
 - caseInsensitiveCompare:
 - localizedCaseInsensitiveCompare:
 - compare:
 - localizedCompare:
 - compare:options:
 - compare:options:range:
 - compare:options:range:locale:
 - localizedStandardCompare:
 - hasPrefix:
 - hasSuffix:
 - isEqualToString:


 Folding Strings
 
 - stringByFoldingWithOptions:locale:


 Getting a Shared Prefix
 
 - commonPrefixWithString:options:


 Changing Case

 - capitalizedStringWithLocale:
 - lowercaseStringWithLocale:
 - uppercaseStringWithLocale:


 Working with Encodings
 
 + availableStringEncodings
 + defaultCStringEncoding
 + localizedNameOfStringEncoding:
 - canBeConvertedToEncoding:
 - dataUsingEncoding:
 - dataUsingEncoding:allowLossyConversion:
 

 Working with Paths
 
 + pathWithComponents:
 - completePathIntoString:caseSensitive:matchesIntoArray:filterTypes:
 - getFileSystemRepresentation:maxLength:
 - stringByAppendingPathComponent:
 - stringByAppendingPathExtension:
 - stringsByAppendingPaths: 
 

 Working with URLs
 
 - stringByAddingPercentEscapesUsingEncoding:
 - stringByReplacingPercentEscapesUsingEncoding:
 - stringByAddingPercentEncodingWithAllowedCharacters:
 - stringByRemovingPercentEncoding
 

 Linguistic Tagging and Analysis
 
 - enumerateLinguisticTagsInRange:scheme:options:orthography:usingBlock:
 - linguisticTagsInRange:scheme:options:orthography:tokenRanges:

*/




%end
%end