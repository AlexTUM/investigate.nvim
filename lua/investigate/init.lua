if vim.g.loaded_investigate_nvim then
    return
end

function HelpDevDocs(topic, content)
    -- https://devdocs.io/#q=html%20title
    local url = "https://devdocs.io/#q=" .. topic .. "%20" .. content
    return url
end


local M = {}


-- Help
-- Documentation
-- TODO create my own plugin for this
-- https://github.com/Keithbsmiley/investigate.vim
function MyHelp(content)
    local filetype = vim.bo.filetype

    if filetype == 'csproj' or filetype == 'fsproj' then
        local page = 'https://www.nuget.org/packages/' .. content
        vim.ui.open(page)
    elseif filetype == 'elixir' then
        local page = 'https://hexdocs.pm/elixir/master/search.html?q=' .. content
        vim.ui.open(page)
    elseif filetype == 'elm' then
        local page = 'https://guide.elm-lang.org/?q=' .. content
        vim.ui.open(page)
    elseif filetype == 'git' then
        local page = 'https://cli.github.com/manual'
        vim.ui.open(page)
    elseif filetype == 'html' then
        local page = HelpDevDocs('html', content)
        vim.ui.open(page)
    elseif filetype == 'java' then
        local lower = string.lower(content)
        local page = 'https://javadocs.org/' .. lower
        print(page)
        vim.ui.open(page)
    elseif filetype == 'javascript' then
        local page = 'https://developer.mozilla.org/en-US/search?q=' .. content .. '&topic=api&topic=js'
        vim.ui.open(page)
    elseif filetype == 'lua' then
        local page = HelpDevDocs('lua', content)
        vim.ui.open(page)
    elseif filetype == 'rust' then
        local page = 'https://docs.rs/releases/search?query=' .. content
        vim.ui.open(page)
    else
        -- let g:investigate_url_for_cs='https://docs.microsoft.com/en-us/search/?terms=^s&category=Reference&scope=.NET'
        -- " http://fuget.org/
        -- let g:investigate_url_for_sql='https://www.w3schools.com/sql/sql_^s.asp'
        -- let g:investigate_url_for_yaml='https://pub.dev/packages?q=^s'
        print(content)
    end
end


function M.setup()

    vim.keymap.set("n", "<leader>k", function()
        local cword = vim.fn.expand("<cword>")
        return ':lua MyHelp(\'' .. cword .. '\')<cr>'
    end, { silent = true, expr = true, desc = 'Investigate under cursor' })

    -- keymap.set("v", "<leader>k", function()
    --     local selected_text = -- TODO
    --     return ":lua MyHelp('" .. selected_text .. "')"
    -- end, { expr = true })

    vim.g.loaded_investigate_nvim = 1
end

return M
