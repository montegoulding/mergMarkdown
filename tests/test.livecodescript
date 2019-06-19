script "TestMergMarkdown"

local sRepoRoot

on TestSetup
	local tMode
	if $MODE is empty then
		put "Release" into tMode
	else
		put $MODE into tMode
	end if

	local tExtension, tSuffix, tPath
	switch the platform
	case "linux"
		put "so" into tExtension
		put "build" into tPath
		if the processor is "x86_64" then
			put "-x64" into tSuffix
		else
			put "-x86" into tSuffix
		end if
		break 
	case "macOS"
		put "bundle" into tExtension
		put "build/" & tMode into tPath
		break 
	case "win32"
		put "dll" into tExtension
		if the processor is "x86_64" then
			put "_build/" & tMode & "/x64" into tPath
			put "-x64" into tSuffix
		else
			put "_build/" & tMode & "/Win32" into tPath
			put "-x86" into tSuffix
		end if
		break 
	end switch

	set the itemDelimiter to slash
	put item 1 to -3 of the filename of me into sRepoRoot
	TestDiagnostic sRepoRoot & return & the filename of me

	_TestLoadExternal format("%s/%s/mergMarkdown%s.%s", \
		sRepoRoot, \
		tPath,\
		tSuffix, \
		tExtension)
end TestSetup

on _TestLoadExternal pExternal
	TestDiagnostic pExternal
	set the externals of the templateStack to pExternal

	create stack pExternal && "External"
	start using it
	if the externalCommands of it is empty and \
			the externalFunctions of it is empty then
		write "Cannot load external" && pExternal & return to stderr
		quit 1
	end if
end _TestLoadExternal

on TestReadme
	local tSuccess
	put true into tSuccess
	
	attemptLoad format("%s/README.md", sRepoRoot)
	if the result is not empty then
		TestDiagnostic the result
		put false into tSuccess
	end if

	get mergMarkdownToXHTML(it, true, true, true, true, true, true, true, true)
	 
	TestAssert "Test parsing README", it is not empty and tSuccess
end TestReadme

private command attemptLoad pFilename
	local tText
	local tUrlResult
	put url ("binfile:" & pFilename) into tText
	put the result into tUrlResult
	if tUrlResult is not empty then
		TestDiagnostic merge("Failed to load [[pFilename]]: [[tUrlResult]]")
		return "read failed" for error
	end if

	return tText for value
end attemptLoad