NAME = mergMarkdown
EXTERNAL = LCExternal/external.c
SUNDOWN = sundown/src/markdown.c sundown/src/stack.c sundown/src/buffer.c sundown/src/autolink.c 
HTML = sundown/html/html.c sundown/html/html_smartypants.c sundown/html/houdini_html_e.c sundown/html/houdini_href_e.c
FILES = $(SUNDOWN) $(HTML)
HEADERS = -I. -I LCExternal -I sundown/src -I sundown/html

$(NAME).so: $(NAME).c $(EXTERNAL) $(FILES)
	gcc -m32 -O $(HEADERS) -L.-D_LINUX -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined -fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -static -shared $(NAME).c $(EXTERNAL) $(FILES) -o ../binaries/$(NAME).so

$(NAME).dll: $(NAME).c $(EXTERNAL) $(SUNDOWN) $(HTML)
	gcc -m32 $(HEADERS) -D_WIN32 -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined -fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -static -shared $(NAME).c $(EXTERNAL) $(FILES) -o ../binaries/$(NAME).dll
