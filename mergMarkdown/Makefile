NAME = mergMarkdown
EXTERNAL = LCExternal/external.c
SUNDOWN = sundown/src/markdown.c sundown/src/stack.c sundown/src/buffer.c sundown/src/autolink.c 
HTML = sundown/html/html.c sundown/html/html_smartypants.c sundown/html/houdini_html_e.c sundown/html/houdini_href_e.c

$(mergMarkdown).so: $(mergMarkdown).c $(EXTERNAL) $(SUNDOWN) $(HTML)
	gcc -m32 -O -I. -I LCExternal -I sundown/src -I sundown/html -L.-D_LINUX -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined -fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -static -shared $(mergMarkdown).c $(EXTERNAL) $(SUNDOWN) $(HTML) -o $(mergMarkdown).so

$(mergMarkdown).dll: $(mergMarkdown).c $(EXTERNAL) $(SUNDOWN) $(HTML)
	gcc -m32 -I. -I LCExternal -I sundown/src -I sundown/html -D_WIN32 -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined -fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -static -shared $(mergMarkdown).c $(EXTERNAL) $(SUNDOWN) $(HTML) -o $(mergMarkdown).dll
