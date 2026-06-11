return {
    'NickJAllen/java-helpers.nvim',
    cmd = {'JavaHelpersNewFile', 'JavaHelpersPickStackTraceLine', 'JavaHelpersPickStackTrace',
           'JavaHelpersGoToStackTraceLine', 'JavaHelpersGoUpStackTrace', 'JavaHelpersGoDownStackTrace',
           'JavaHelpersGoToBottomOfStackTrace', 'JavaHelpersGoToTopOfStackTrace', 'JavaHelpersGoToNextStackTrace',
           'JavaHelpersGoToPrevStackTrace', 'JavaHelpersSendStackTraceToQuickfix', 'JavaHelpersDeobfuscate',
           'JavaHelpersSelectObfuscationFile', 'JavaHelpersForgetObfuscationFile'},

    ---@type JavaHelpers.Config
    opts = {
        new_file = {
            ---Each template has a name and some template source code.
            ---${package_decl} and ${name} will be replaced with the package declaration and name for the Java type being created.
            ---If ${pos} is provided then the cursor will be positioned there ready to type.
            templates = {},

            ---Defines patters to recognize Java source directories in order to determine the package name.
            java_source_dirs = {'src/main/java', 'src/test/java', 'src'},

            ---If true then newly created Java files will be formatted
            should_format = true
        },

        stack_trace = {
            -- Command that is used to deobfuscate stack traces
            deobfuscate_command = 'retrace',

            -- Directory that will be used to select an obfuscation mapping file, if nil or empty the current directory will be used
            obfuscation_mappings_dir = vim.uv.os_homedir() .. '/.obfuscation'
        }
    },
    keys = { -- New file creation
    {
        '<leader>Jc',
        ':JavaHelpersNewFile Class<cr>',
        desc = 'New Java Class'
    }, {
        '<leader>Ji',
        ':JavaHelpersNewFile Interface<cr>',
        desc = 'New Java Interface'
    }, {
        '<leader>Jr',
        ':JavaHelpersNewFile Record<cr>',
        desc = 'New Java Record'
    }, {
        '<leader>Je',
        ':JavaHelpersNewFile Enum<cr>',
        desc = 'New Java Enum'
    } -- Stack trace navigation
    },
    dependencies = {'nvim-lua/plenary.nvim',

    -- This is only needed if you want to use the JavaHelpersPickStackTraceLine or JavaHelpersSelectObfuscationFile commands (but highly recommended)
                    'folke/snacks.nvim'}
}
