-- Telescope keymaps
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "LSP Document Symbols" })
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Telescope Projects" })


-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })


-- Tab navigation
vim.keymap.set("n", "<leader>nt", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>ct", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>ot", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
vim.keymap.set("n", "<leader>]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })


-- Oil.nvim keymaps
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })



-- LSP keymaps
-- Go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

-- Go to declaration (useful for e.g., class decl vs usage)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

-- Show hover doc (like VSCode's hover tooltip)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- Show implementation (go to class/func implementation)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

-- List references (like VSCode Shift+F12)
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List References" })

-- Rename symbol (like F2 in VSCode)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })

-- Code actions (quick fixes, suggestions)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action (Visual)" })

-- Signature help (parameter info while writing a function)
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- Show diagnostics (current line or cursor)
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Go to next/prev diagnostic (like problems panel)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })


-- toggle comment for the current line
vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment on current line" })

-- toggle comment for the selected block
vim.keymap.set("v", "<leader>/", function()
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment on selection" })

-- Add these for auto-indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true  -- C-style indenting (good for most languages)
vim.opt.softtabstop = 4  -- Makes backspace behave better with spaces

-- Optional: better search behavior
vim.opt.smartcase = true  -- Case sensitive if search contains uppercase


