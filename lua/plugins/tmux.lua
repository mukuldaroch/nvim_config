return {
	'vimpostor/vim-tpipeline',
	config = function ()
		vim.g.tpipeline_autombed = 1;
		vim.g.tpipeline_restore= 1;
		vim.g.tpipeline_clearstl= 1;
	end
}
