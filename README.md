#mergMarkDown

mergMarkdown is a simple [LiveCode](http://runrev.com) external for translating a markdown file to XHTML using the [sundown](https://github.com/vmg/sundown) library. It has one function: `mergMarkdownToXHTML`. There are a number of non-standard markdown features implemented in sundown and these can be controlled with optional parameters to the function.

For instance to enable table support use: 

	put mergMarkdownToHTML(theMarkdownText,,true) into theHTML

The parameters are identfied in the demo stack.

##Support
Ask it on [StackOverflow](http://stackoverflow.com) and it shall be answered.

##Binaries
Binaries for this external are available under a free account at [mergExt](http://mergext.com) so there's no point duplicating here.

##Installation

Look [here](http://lessons.runrev.com/s/lessons/m/4071/l/6347-how-to-install-3rd-party-externals-for-use-in-the-ide-and-standalone-builder) for installation instructions for the IDE and desktop standalones.
Look [here](http://www.youtube.com/watch?v=zFTsVu7_QOI) for installation instructions for iOS and Android.
To install in server then you just need to drop the external into the externals folder. For OS X use mergJSON.dylib rather than mergJSON.bundle on server.

##License

This project is MIT licensed as is sundown so appropriate copyright attribution is required. See LICENSE.txt and the sundown readme for more details.

