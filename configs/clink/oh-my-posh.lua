local localappdata = os.getenv("LOCALAPPDATA") or ""

-- Display Linux-style startup MOTD once on launch
os.execute('motd.cmd')

-- Initialize Oh My Posh for cmd
load(io.popen('oh-my-posh init cmd'):read("*a"))()

-- Register doskey aliases
os.execute('doskey cls=cls $T motd.cmd >nul 2>nul & doskey clear=cls $T motd.cmd >nul 2>nul & doskey ls=eza --icons=auto $* >nul 2>nul & doskey ll=eza -la --icons=auto --git $* >nul 2>nul & doskey tree=eza --tree --icons=auto $* >nul 2>nul & doskey cat=bat $* >nul 2>nul & doskey lg=lazygit $* >nul 2>nul & doskey motd=motd.cmd $* >nul 2>nul & doskey open=open.cmd $* >nul 2>nul & doskey dust=dust.cmd $* >nul 2>nul & doskey tldr=tldr.cmd $* >nul 2>nul')

-- Automatically register visited directories with zoxide
if clink and clink.onendedit then
    clink.onendedit(function ()
        local cwd = os.getcwd()
        if cwd and cwd ~= '' then
            os.execute('zoxide add "' .. cwd .. '" >nul 2>nul')
        end
    end)
end
