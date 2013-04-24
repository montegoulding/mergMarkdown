#mergMarkDown

mergMarkdown is a simple external for translating a markdown file to XHTML uing the sundown library. It has one function: `mergMarkdownToXHTML`. There are a number of non-standard markdown features implemented in sundown and these can be controlled with optional parameters to the function.

For instance to enable table support use: 

	put mergMarkdownToHTML(theMarkdownText,,true) into theHTML

The parameters are identfied in the demo stack.

##Binaries

Up to date binaries are avaiable via a free account at http://mergExt.com.

##License

This project is MIT licensed as is sundown so appropriate copyright attribution is required.

