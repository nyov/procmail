/************************************************************************
 *									*
 *	Known fields when formail is splitting messages (the first	*
 *	"-m nnn" fields encountered should be among them or one of	*
 *	the special From_, Article_ or X- fields).			*
 *									*
 *	If you need to add one (be sure to update "cdigest" below as	*
 *	well!), drop me a mail, I might be interested in including	*
 *	it in the next release.						*
 *									*
 ************************************************************************/
/*$Id: header.h,v 1.1 1992/09/28 14:28:04 berg Exp $*/

static const char
 returnpath[]=		"Return-Path:",				  /* RFC 822 */
 received[]=		"Received:",				/* ditto ... */
 replyto[]=		"Reply-To:",
 Fromm[]=		"From:",
 sender[]=		"Sender:",
 res_replyto[]=		"Resent-Reply-To:",
 res_from[]=		"Resent-From:",
 res_sender[]=		"Resent-Sender:",
 date[]=		"Date:",
 res_date[]=		"Resent-Date:",
 to[]=			"To:",
 res_to[]=		"Resent-To:",
 cc[]=			"Cc:",
 res_cc[]=		"Resent-Cc:",
 bcc[]=			"Bcc:",
 res_bcc[]=		"Resent-Bcc:",
 messageid[]=		"Message-ID:",
 res_messageid[]=	"Resent-Message-ID:",
 inreplyto[]=		"In-Reply-To:",
 references[]=		"References:",
 keywords[]=		"Keywords:",
 subject[]=		"Subject:",
 scomments[]=		"Comments:",
 encrypted[]=		"Encrypted:",
 errorsto[]=		"Errors-To:",		       /* sendmail extension */
 retreceiptto[]=	"Return-Receipt-To:",			/* ditto ... */
 precedence[]=		"Precedence:",
 mssage[]=		"Message:",
 text[]=		"Text:",
 priority[]=		"Priority:",			    /* ELM extension */
 article[]=		"Article:",			 /* USENET extension */
 path[]=		"Path:",				/* ditto ... */
 summary[]=		"Summary:",
 organisation[]=	"Organisation:",
 aorganization[]=	"Organization:",
 newsgroups[]=		"Newsgroups:",
 followupto[]=		"Followup-To:",
 approved[]=		"Approved:",
 lines[]=		"Lines:",
 expires[]=		"Expires:",
 control[]=		"Control:",
 distribution[]=	"Distribution:",
 xref[]=		"Xref:",
 originator[]=		"Originator:",
 nntppostinghost[]=	"Nntp-Posting-Host:",
 cnttype[]=		"Content-Type:",	       /* Internet extension */
 encoding[]=		"Encoding:",				/* ditto ... */
 mimeversion[]=		"MIME-Version:",		   /* MIME extension */
 cnttransferenc[]=	"Content-Transfer-Encoding:",		/* ditto ... */
 cntid[]=		"Content-ID:",
 cntdescription[]=	"Content-Description:",
 status[]=		"Status:";			 /* mailer extension */

static const struct {const char*hedr;int lnr;}cdigest[]=
{ bsl(returnpath),bsl(received),bsl(replyto),bsl(Fromm),bsl(sender),
  bsl(res_replyto),bsl(res_from),bsl(res_sender),bsl(date),bsl(res_date),
  bsl(to),bsl(res_to),bsl(cc),bsl(res_cc),bsl(bcc),bsl(res_bcc),bsl(messageid),
  bsl(res_messageid),bsl(inreplyto),bsl(references),bsl(keywords),bsl(subject),
  bsl(scomments),bsl(encrypted),bsl(errorsto),bsl(retreceiptto),
  bsl(precedence),bsl(mssage),bsl(text),bsl(priority),bsl(article),bsl(path),
  bsl(summary),bsl(organisation),bsl(aorganization),bsl(newsgroups),
  bsl(followupto),bsl(approved),bsl(lines),bsl(expires),bsl(control),
  bsl(distribution),bsl(xref),bsl(originator),bsl(nntppostinghost),
  bsl(cnttype),bsl(encoding),bsl(mimeversion),bsl(cnttransferenc),bsl(cntid),
  bsl(cntdescription),bsl(status)
};
