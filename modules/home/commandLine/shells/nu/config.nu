def startssh [] {
  ^ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -r | into record | load-env
}
                
def nixvim [
  version: string
  ...args
] {
  nix run ("github:wadsaek/nixvim#" + $version) ...$args
}

$env.config = {
  show_banner: false,
}
