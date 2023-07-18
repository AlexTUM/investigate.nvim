if vim.g.loaded_neovcs then
    return
end

local M = {}

function HelpDevDocs(topic, content)
    -- https://devdocs.io/#q=html%20title
    local url = "https://devdocs.io/#q=" .. topic .. "%20" .. content
    return url
end

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

keymap.set("n", "<leader>k", function()
    return ":call v:lua.MyHelp('" .. fn.expand("<cword>") .. "')"
end, { expr = true })

-- keymap.set("v", "<leader>k", function()
--     local selected_text = -- TODO
--     return ":call v:lua.MyHelp('" .. selected_text .. "')"
-- end, { expr = true })

return M
