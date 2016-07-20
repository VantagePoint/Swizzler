/*
 * (c) 2015 Good Technology Corporation. All rights reserved.
 */

//  GDFileStat.h

#ifndef GDMac_GDFileStat_h
#define GDMac_GDFileStat_h

/** \struct GDFileStat
 * Information about a file or directory in the secure store.
 * This structure is used to return information about a file or
 * directory in the secure store.
 * \see \link GDFileSystem::getFileStat:to:error: getFileStat\endlink
 */
typedef struct
{
    unsigned long long fileLen;
    /**< File size in bytes */
    
    unsigned long lastModifiedTime;
    /**< Timestamp for when file was last modified */
    
    bool isFolder;
    /**< <TT>true</TT> for directories, <TT>false</TT> for plain files */
} GDFileStat;


#endif
