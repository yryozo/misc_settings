# <http://d.hatena.ne.jp/rubikitch/20100915/anything>

# Exclude regexps (backup files, core files, and so on)
$EXCLUDE_REGEXP = Regexp.union(/~$/, /\#.+\#$/, /[._].*\.swp$/, /core\.\d+$/, # from ack-grep
  /\.(?:elc|o)$/, /,v$/)

# Set default directories to collect
$LS_DIRS = ["~", "/etc", "/var", "/boot"]
