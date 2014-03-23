//
//  mergMarkdown.c
//  mergMarkdown
//
//  Created by Monte Goulding on 24/03/13.
//  Copyright (c) 2013 mergExt. All rights reserved.
//

#include <stdio.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "external.h"

#include "markdown.h"
#include "html.h"
#include "buffer.h"

#define READ_UNIT 1024
#define OUTPUT_UNIT 64

#define LIVECODE_FUNCTION(x) void x(char *p_arguments[], int p_argument_count, char **r_result, Bool *r_pass, Bool *r_err)
#define LIVECODE_ERROR(x) { *r_err = True; 		*r_pass = False; 		*r_result = strdup(x); 		return; }

#define LIVECODE_WRITEVARIABLE(var,number) { \
SetVariable(p_arguments[ number ],var, &success); \
if (success == EXTERNAL_FAILURE) { \
LIVECODE_ERROR("Could not write variable"); \
} \
}

#define LIVECODE_ARG(argn) { if(p_argument_count < argn) { 	LIVECODE_ERROR("Incorrect number of arguments"); }}

#define LIVECODE_RETURN_THIS_STRING(x) { \
*r_err = False; *r_pass = False; \
if (x == NULL) { *r_result = strdup(""); } \
else { *r_result = x; }}

LIVECODE_FUNCTION(mergMarkdownToXHTML)
{
    struct buf *tOutputBuffer;
    char * tReturn;
    
	struct sd_callbacks tCallbacks;
	struct html_renderopt tOptions;
	struct sd_markdown *tMarkdown;
    
    int tExtensions = 0;
    
    LIVECODE_ARG(1);
    
    if (p_argument_count > 1) {
        if (!strcmp(p_arguments[1], "true")) {
            tExtensions = tExtensions | MKDEXT_NO_INTRA_EMPHASIS;
        }
    }
    if (p_argument_count > 2) {
        if (!strcmp(p_arguments[2], "true")) {
            tExtensions = tExtensions | MKDEXT_TABLES;
        }
    }
    if (p_argument_count > 3) {
        if (!strcmp(p_arguments[3], "true")) {
            tExtensions = tExtensions | MKDEXT_FENCED_CODE;
        }
    }
    if (p_argument_count > 4) {
        if (!strcmp(p_arguments[4], "true")) {
            tExtensions = tExtensions | MKDEXT_AUTOLINK;
        }
    }
    if (p_argument_count > 5) {
        if (!strcmp(p_arguments[5], "true")) {
            tExtensions = tExtensions | MKDEXT_STRIKETHROUGH;
        }
    }
    if (p_argument_count > 6) {
        if (!strcmp(p_arguments[6], "true")) {
            tExtensions = tExtensions | MKDEXT_SPACE_HEADERS;
        }
    }
    if (p_argument_count > 7) {
        if (!strcmp(p_arguments[7], "true")) {
            tExtensions = tExtensions | MKDEXT_SUPERSCRIPT;
        }
    }
    if (p_argument_count > 8) {
        if (!strcmp(p_arguments[8], "true")) {
            tExtensions = tExtensions | MKDEXT_LAX_SPACING;
        }
    }
    
    /* performing markdown parsing */
	tOutputBuffer = bufnew(OUTPUT_UNIT);
    
	sdhtml_renderer(&tCallbacks, &tOptions, HTML_USE_XHTML);
	tMarkdown = sd_markdown_new(tExtensions, 16, &tCallbacks, &tOptions);
    
	sd_markdown_render(tOutputBuffer, (const uint8_t *)p_arguments[0], strlen(p_arguments[0]), tMarkdown);
	sd_markdown_free(tMarkdown);
    
    tReturn = (char *)malloc(tOutputBuffer->size+1);
    memcpy(tReturn, tOutputBuffer->data, tOutputBuffer->size);
    tReturn[tOutputBuffer->size] = 0;
    
	/* cleanup */
	bufrelease(tOutputBuffer);
    
    LIVECODE_RETURN_THIS_STRING(tReturn);

}

EXTERNAL_BEGIN_DECLARATIONS("mergMarkdown")
EXTERNAL_DECLARE_FUNCTION("mergMarkdownToXHTML", mergMarkdownToXHTML)
EXTERNAL_END_DECLARATIONS

#if __IPHONE_OS_VERSION_MIN_REQUIRED
  EXTERNAL_LIBINFO(mergMarkdown)
#endif
