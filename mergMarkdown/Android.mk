LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := $(EXTERNAL_NAME)

LOCAL_SRC_FILES := mergMarkdown.c external/external.c sundown/src/markdown.c sundown/src/stack.c sundown/src/buffer.c sundown/src/autolink.c sundown/html/html.c sundown/html/html_smartypants.c sundown/html/houdini_html_e.c sundown/html/houdini_href_e.c

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/external \
	$(LOCAL_PATH)/sundown/src \
	$(LOCAL_PATH)/sundown/html \

LOCAL_LDFLAGS += -Wl,-u,getXtable

include $(BUILD_SHARED_LIBRARY)