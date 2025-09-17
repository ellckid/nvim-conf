return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "none" })
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "E ",
					[vim.diagnostic.severity.WARN] = "W ",
					[vim.diagnostic.severity.INFO] = "I ",
					[vim.diagnostic.severity.HINT] = "H ",
				},
			},
		})
		require("neo-tree").setup({
			close_if_last_window = false,
			window = {
				width = math.floor(vim.o.columns * 0.4),
				position = "left",
			},
			filesystem = {
				follow_current_file = {
					enabled = true, -- автофокус на текущем файле
					leave_dirs_open = false,
				},
			},
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "|",
					last_indent_marker = "`",
					highlight = "NeoTreeIndentMarker",
					with_expanders = true,
					expander_collapsed = "+",
					expander_expanded = "-",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "[+]",
					folder_open = "[-]",
					folder_empty = "[ ]",
					default = "*",
				},
			},
		})
	end,
}
