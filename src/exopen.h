/*$Id: exopen.h,v 1.1 1992/09/28 14:28:00 berg Exp $*/

const char*
 hostname P((void));
void
 ultoan P((unsigned long val,char*dest));
int
 unique Q((const char*const full,char*const p,const mode_t mode)),
 myrename P((const char*const old,const char*const newn));

#define charsSERIAL	4
#define UNIQnamelen	(1+charsSERIAL+HOSTNAMElen+1)
#define bitsSERIAL	(6*charsSERIAL)
#define maskSERIAL	((1L<<bitsSERIAL)-1)
#define rotbSERIAL	2
#define mrotbSERIAL	((1L<<rotbSERIAL)-1)
