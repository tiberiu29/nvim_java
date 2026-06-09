local function get_jdtls()
    local mason_registry = require("mason-registry")
    local jdtls = mason_registry.get_package("jdtls")

    -- We use mason so expect jdtls path to point to ~/local/share/nvim/mason
    local jdtls_path = jdtls:get_install_path()

    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local SYSTEM = "linux"

    local config = jdtls_path .. "/config_" .. SYSTEM

    local lombok = jdtls_path .. "/lombok.jar"

    return launcher, config, lombok

end

local function get_bundles()
    local mason_registry = require("mason-registry")

    local java_debug = mason_registry.get_package("java-debug-adapter")
    local java_debug_path = java_debug:get_install_path()

    local bundles = {vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)}
    local java_test = mason_registry.get_package("java-test")
    local java_test_path = java_test:get_install_path()
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

    return bundles
end

local function java_keymaps()

    -- Enable usages of commandes in nvim
    --
    vim.cmd(
        "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
    -- Enable usage of JdtUpdateConfig - updating indexes whenever mvn clean install is run or whenever new dependencies are added
    vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    -- Decompile bytecode to java classes
    vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
    vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

    -- Keymaps

    -- Organize imports keymaps
    vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", {
        desc = "[J]ava [O]rganize Imports"
    })

    -- Extract to a variable
    vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", {
        desc = "[J]ava [E]xtract Variable"
    })
    vim.keymap.set('v', '<leader>Jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", {
        desc = "[J]ava [E]xtract Variable"
    })

    -- Extract to a constant
    vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>", {
        desc = "[J]ava Extract [C]onstant"
    })
    vim.keymap.set('v', '<leader>JC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", {
        desc = "[J]ava Extract [C]onstant"
    })

    -- Test run
    vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", {
        desc = "[J]ava [T]est method"
    })
    vim.keymap.set('v', '<leader>Jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", {
        desc = "[J]ava [T]est method"
    })
    vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", {
        desc = "[J]ava [T]est Class"
    })

    -- Similar to maven reload from intellij (update dependencies in workspace/indexes post maven clean install)
    vim.keymap.set('n', '<leader>Ju', "<Cmd> JdtUpdateConfig<CR>", {
        desc = "[J]ava [U]pdate Config"
    })
end

local function setup_jdtls()
    local jdtls = require("jdtls")

    local launcher, os_config, lombok = get_jdtls()
    local bundles = get_bundles()

    -- Define how to find the root of a project for jdtls. Search for git/nvm/poms/gradle/etc..
    local root_dir = require("jdtls.setup").find_root({"pom.xml", "build.gradle", "gradlew", "mvnw"})
    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = false
                }
            }
        }
    }

    -- APPEND CMP capabilities 
    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    for k, v in pairs(cmp_capabilities) do
        capabilities[k] = v
    end

    capabilities.workspace.configuration = true
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- Spin up JDTLS server
    local cmd = {'java', '-Declipse.application=org.eclipse.jdt.ls.core.id1', '-Dosgi.bundles.defaultStartLevel=4',
                 '-Declipse.product=org.eclipse.jdt.ls.core.product', '-Dlog.protocol=true', '-Dlog.level=ALL',
                 '-Xmx1g', '--add-modules=ALL-SYSTEM', '--add-opens', 'java.base/java.util=ALL-UNNAMED', '--add-opens',
                 'java.base/java.lang=ALL-UNNAMED', '-javaagent:' .. lombok, '-jar', launcher, '-configuration',
                 os_config, '-data', workspace_dir}

    local settings = {
        java = {
            autobuild = {
                enabled = true
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle"
                }
            },
            eclipse = {
                downloadSource = true
            },
            maven = {
                downloadSources = true
            },
            signatureHelp = {
                enabled = true
            },
            -- use fernflower decompiler when using javap for decompile bytecode to java classes
            contentProvider = {
                preferred = "fernflower"
            },
            -- On save organize imports
            saveActions = {
                organizeImports = true
            },
            completion = {
                -- When using unimported static method, how should LSP rank possible places to import the static method from
                favoriteStaticMembers = {"org.hamcrest.MatcherAssert.assertThat", "org.hamcrest.Matchers.*",
                                         "org.hamcrest.CoreMatchers.*", "org.junit.jupiter.api.Assertions.*",
                                         "java.util.Objects.requireNonNull", "java.util.Objects.requireNonNullElse",
                                         "org.mockito.Mockito.*"},
                -- Don't suggest imports
                filteredTypes = {"com.sun.*", "io.micrometer.shaded.*", "java.awt.*", "jdk.*", "sun.*"},
                importOrder = {"java", "jakarta", "javax", "com", "org"}
            },
            sources = {
                -- How many classes before we import with *
                organizeImports = {
                    startThreshold = 9999,
                    staticThreshold = 9999
                }
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true
                },
                useBlocks = true
            },
            configuration = {
                updateBuildConfiguration = "automatic"
            },
            referencesCodeLens = {
                enabled = true
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all"
                }
            }

        }
    }

    local init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities
    }

    local on_attach = function(_, bufnr)
        java_keymaps()

        require('jdtls.dap').setup_dap()

        -- Find the main method of the application so the debug adapter can successfully start up the application
        require('jdtls.dap').setup_dap_main_class_configs()

        -- require('jdtls_setup').add_commands()

        -- Code lens enable features such as code references count, implementations count, etc
        vim.lsp.codelens.refresh()

        -- Setup a function that automatically runs every time a java file is saved to refresh code lens
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = {"*.java"},
            callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
            end
        })
    end

    local config = {
        cmd = cmd,
        root_dir = root_dir,
        settings = settings,
        init_options = init_options,
        capabilities = capabilities,
        on_attach = on_attach
    }

    require('jdtls').start_or_attach(config)

end

return {
    setup_jdtls = setup_jdtls
}
