return {
	project = {
		root = '',
		root_dir_identifications = { '.git/', '.config/', 'pom.xml' }, -- ‘/’结尾表示目录，否则是文件，按顺序来判断, 有前面的文件or目录则不判断后面的
	}
}
