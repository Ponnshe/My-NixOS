return {
  "Olical/conjure",
  ft = { "clojure", "clojurescript", "clojurec" }, -- carga solo en esos filetypes
  opts = {
    log = {
      hud = {
        enabled = true,  -- vim.g["conjure#log#hud#enabled"] = true
      },
    },
    mapping = {
      doc_word = false,  -- vim.g["conjure#mapping#doc_word"] = false
    },
  },
  config = function(_, opts)
    -- Asignar las variables globales como vim.g para Conjure (ya que es legacy Vim script)
    vim.g["conjure#log#hud#enabled"] = opts.log.hud.enabled
    vim.g["conjure#mapping#doc_word"] = opts.mapping.doc_word

    -- Filetype detection adicional
    vim.filetype.add({
      extension = {
        clj = "clojure",
        cljs = "clojure",
        cljc = "clojure",
      },
    })

    -- Keymaps específicos para Conjure
    local keymap_opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", ",ee", "<cmd>ConjureEvalCurrentForm<CR>", keymap_opts)
    vim.api.nvim_set_keymap("n", ",eb", "<cmd>ConjureEvalBuf<CR>", keymap_opts)
    vim.api.nvim_set_keymap("v", ",er", "<cmd>ConjureEvalRange<CR>", keymap_opts)
  end,
}
