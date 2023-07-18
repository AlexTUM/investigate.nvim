(when vim.g.loaded_investigate_nvim (lua "return "))

(local M {})

(set-forcibly! Help-dev-docs (fn [topic content]
                               (let [url (.. "https://devdocs.io/#q=" topic
                                             "%20" content)]
                                 url)))
(set-forcibly! My-help (fn [content]
                         (let [filetype vim.bo.filetype]
                           (if (or (= filetype :csproj) (= filetype :fsproj))
                               (let [page (.. "https://www.nuget.org/packages/"
                                              content)]
                                 (vim.ui.open page))
                               (= filetype :elixir)
                               (let [page (.. "https://hexdocs.pm/elixir/master/search.html?q="
                                              content)]
                                 (vim.ui.open page))
                               (= filetype :elm)
                               (let [page (.. "https://guide.elm-lang.org/?q="
                                              content)]
                                 (vim.ui.open page))
                               (= filetype :git)
                               (let [page "https://cli.github.com/manual"]
                                 (vim.ui.open page))
                               (= filetype :html)
                               (let [page (Help-dev-docs :html content)]
                                 (vim.ui.open page))
                               (= filetype :java)
                               (let [lower (string.lower content)
                                     page (.. "https://javadocs.org/" lower)]
                                 (print page)
                                 (vim.ui.open page))
                               (= filetype :javascript)
                               (let [page (.. "https://developer.mozilla.org/en-US/search?q="
                                              content :&topic=api&topic=js)]
                                 (vim.ui.open page))
                               (= filetype :lua)
                               (let [page (Help-dev-docs :lua content)]
                                 (vim.ui.open page))
                               (= filetype :rust)
                               (let [page (.. "https://docs.rs/releases/search?query="
                                              content)]
                                 (vim.ui.open page))
                               (print content)))))
(fn M.setup []
  (keymap.set :n :<leader>k
              (fn []
                (.. ":call v:lua.MyHelp('" (___fn___.expand :<cword>) "')"))
              {:expr true})
  (set vim.g.loaded_investigate_nvim 1))
M	
