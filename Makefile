NAME = mergMarkdown
EXTERNAL = $(NAME)/external/external.c
SUNDOWN = $(NAME)/sundown/src/markdown.c $(NAME)/sundown/src/stack.c $(NAME)/sundown/src/buffer.c $(NAME)/sundown/src/autolink.c 
HTML = $(NAME)/sundown/html/html.c $(NAME)/sundown/html/html_smartypants.c $(NAME)/sundown/html/houdini_html_e.c $(NAME)/sundown/html/houdini_href_e.c
FILES = $(SUNDOWN) $(HTML)
HEADERS = -I. -I $(NAME)/external -I $(NAME)/sundown/src -I $(NAME)/sundown/html

$(info $(shell mkdir -p build))

$(NAME)-x86.so: $(NAME)/$(NAME).c $(EXTERNAL) $(FILES)
	gcc -v -Wall -Wextra -m32 -O $(HEADERS) -L.-D_LINUX -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined -fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -static -shared $(NAME)/$(NAME).c $(EXTERNAL) $(FILES) -o build/$(NAME)-x86.so

$(NAME)-x64.so: $(NAME)/$(NAME).c $(EXTERNAL) $(FILES)
	gcc -v -Wall -Wextra -fPIC -m64 -O $(HEADERS) -L.-D_LINUX -D_RELEASE -DNDEBUG -DRELEASE -Xlinker -no-undefined -fno-exceptions -Wl,-Bstatic -Wl,-Bdynamic -shared $(NAME)/$(NAME).c $(EXTERNAL) $(FILES) -o build/$(NAME)-x64.so
