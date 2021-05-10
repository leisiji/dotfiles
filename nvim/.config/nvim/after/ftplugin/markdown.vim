setlocal expandtab

if exists('g:my_markdown_loaded') | finish | endif

let g:markdown_fenced_languages = [
	\ 'vim', 'cpp', 'c', 'java', 'python', 'lua', 'sh', 'make',
	\ 'groovy', 'sql', 'javascript', 'json', 'html'
	\ ]

lua require('plugins.markdownlint').config()
let g:my_markdown_loaded = 1
