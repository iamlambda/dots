import cat
config.load_autoconfig(False)

config.unbind('J')
config.unbind('K')

config.bind(',m', 'hint links spawn -d mpv {hint-url}')
config.bind(',cm', 'spawn -d mpv {url}')
config.bind(',cd', 'spawn -d youtube-dl -P $HOME/dls {url}')
config.bind(',d', 'hint links spawn -d youtube-dl -P $HOME/dls {hint-url}')
config.bind(',od', 'open {url:domain}')
config.bind(',Od', 'open -t {url:domain}')
config.bind(',op', 'hint links spawn sh -c "curl '{hint-url}' | zathura -"')
config.bind(',w', 'config-cycle colors.webpage.bg "#fdf6e3" "#1e1e2e"')
config.bind(',f', 'fullscreen')

config.bind('j', 'search-next')
config.bind('h', 'set-cmd-text -s :open')
config.bind('H', 'set-cmd-text -s :open -t')
config.bind('l', 'mode-enter insert')

config.bind('n', 'scroll left')
config.bind('N', 'back')
config.bind('e', 'scroll down')
config.bind('E', 'tab-next')
config.bind('i', 'scroll up')
config.bind('I', 'tab-prev')
config.bind('o', 'scroll right')
config.bind('O', 'forward')

c.content.notifications.enabled = False

c.hints.chars = "arstgmneio"

c.url.searchengines['gh'] = 'https://github.com/search?q={}'
c.url.searchengines['yt'] = 'https://invidious.snopyta.org/search?q={}'
c.url.searchengines['aw'] = 'https://wiki.archlinux.org/index.php?search={}'

c.fonts.default_family = "Source Code Pro"
c.fonts.web.family.standard = "Source Code Pro"
c.fonts.web.family.cursive = "Source Code Pro"
c.fonts.web.family.fantasy = "Source Code Pro"
c.fonts.web.family.fixed = "Source Code Pro"
c.fonts.web.family.serif = "Source Code Pro"

c.completion.shrink = True

c.colors.webpage.bg = "#fdf6e3"

c.tabs.show = "multiple"
c.tabs.favicons.show = "never"

c.downloads.location.directory = "$HOME/dls"

c.editor.command = ['alacritty', '-e', 'vim', '{}']

cat.setup(c, "macchiato")
