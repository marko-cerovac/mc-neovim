-- Load necessary modules
-- local telescope = require('telescope')
local actions = require('telescope.actions')
local state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local sorters = require 'telescope.sorters'
local finders = require('telescope.finders')
-- local conf = require('telescope.config').values

local M = {}

-- local center_prompt = {
--     layout_strategy = 'vertical',
--     layout_config = {
--         height = 15,
--         width = 0.4,
--         prompt_position = 'top',
--     },
--     sorting_strategy = 'ascending',
-- }

local enter = function(prompt_bufnr)
    local selected = state.get_selected_entry(prompt_bufnr)
    vim.cmd(selected.value)
end

M.find = function()
    -- Get the list of user commands
    local commands = {}

    for name, _ in pairs(vim.api.nvim_get_commands { builtin = false }) do
        table.insert(commands, name)
    end

    -- Create a picker for Telescope
    pickers.new({}, {
        prompt_title = 'Commands',
        finder = finders.new_table {
            results = commands,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry,
                    ordinal = entry,
                }
            end,
        },
        sorter = sorters.get_fzy_sorter({}),
        attach_mappings = function(_, map)
            -- Map to execute the selected command
            map('i', '<CR>', function(prompt_bufnr)
                enter(prompt_bufnr)
                actions.close(prompt_bufnr)
            end)
            map('n', '<CR>', function(prompt_bufnr)
                enter(prompt_bufnr)
                actions.close(prompt_bufnr)
            end)
            return true
        end,
    }):find()
end

return M
