return {
  -- Core para DB
  { "tpope/vim-dadbod" },

  -- UI para dadbod
  { "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    config = function()
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_win_position = "right"
    end
  },

  -- SQL workbench / snippets
	{ "vim-scripts/Vim-SQL-Workbench" },

}
