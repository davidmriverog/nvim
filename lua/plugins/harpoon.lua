-- ============================================================================
-- HARPOON - NAVEGACIÓN RÁPIDA ENTRE ARCHIVOS IMPORTANTES
-- ============================================================================

local conf = require('telescope.config').values
local themes = require('telescope.themes')

-- Función auxiliar para mostrar lista de Harpoon en Telescope
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    local opts = themes.get_ivy({
        prompt_title = "Lista de Archivos Importantes"
    })

    require("telescope.pickers").new(opts, {
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer(opts),
        sorter = conf.generic_sorter(opts),
    }):find()
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()
        
        -- Agregar archivo actual a la lista de Harpoon
        vim.keymap.set("n", "<leader>a", function() 
            harpoon:list():add() 
            print("Archivo agregado a Harpoon")
        end, { desc = "Agregar archivo actual a Harpoon" })
        
        -- Mostrar menú rápido de Harpoon
        vim.keymap.set("n", "<C-e>", function() 
            harpoon.ui:toggle_quick_menu(harpoon:list()) 
        end, { desc = "Mostrar menú rápido de Harpoon" })
        
        -- Mostrar lista de Harpoon en Telescope
        vim.keymap.set("n", "<leader>fl", function() 
            toggle_telescope(harpoon:list()) 
        end, { desc = "Ver archivos de Harpoon en Telescope" })
        
        -- Navegar entre archivos de Harpoon
        vim.keymap.set("n", "<A-[>", function() 
            harpoon:list():prev() 
        end, { desc = "Ir al archivo anterior en Harpoon" })
        
        vim.keymap.set("n", "<A-]>", function() 
            harpoon:list():next() 
        end, { desc = "Ir al siguiente archivo en Harpoon" })
        
        -- Limpiar lista de Harpoon
        vim.keymap.set("n", "<leader>hc", function()
            harpoon:list():clear()
            print("Lista de Harpoon limpiada")
        end, { desc = "Limpiar toda la lista de Harpoon" })
        
        -- Remover archivo actual de Harpoon
        vim.keymap.set("n", "<leader>hr", function()
            local current_buf = vim.api.nvim_buf_get_name(0)
            harpoon:list():remove(current_buf)
            print("Archivo removido de Harpoon: " .. vim.fn.fnamemodify(current_buf, ":t"))
        end, { desc = "Remover archivo actual de Harpoon" })
    end
}