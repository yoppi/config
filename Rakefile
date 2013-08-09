##
# Update some configuration files(.zshrc, .irbrc, .gitrc, and .vimrc, so on).
# NOTE: rake(Ruby Make) is required.
#

# Task definitions #{{{1
HOME = ENV['HOME']
CONFIG = File.expand_path(File.dirname(__FILE__))


# for some dot files #{{{2
MASTER_DOT_FILES = FileList["#{CONFIG}/dot.*"].select {|f| !File.directory? f}
HOME_DOT_FILES = MASTER_DOT_FILES.
  map {|dotfile| "#{HOME}/#{File.basename(dotfile).gsub(/^dot/, '')}" }

MASTER_DOT_DIR_FILES = FileList["#{CONFIG}/dot.*/**/*"].select {|f| !File.directory? f}
HOME_DOT_DIR_FILES =
  MASTER_DOT_DIR_FILES.map {|dotfile| dotfile.gsub(%r|#{CONFIG}/dot|, "#{HOME}/") }
HOME_DOT_DIRS =
  MASTER_DOT_DIR_FILES.map {|f| File.dirname(f).gsub(%r|#{CONFIG}/dot|, "#{HOME}/") }.uniq

DOT_FILES_TABLE =
  (Hash[*MASTER_DOT_FILES.zip(HOME_DOT_FILES).flatten]).
    merge(Hash[*MASTER_DOT_DIR_FILES.zip(HOME_DOT_DIR_FILES).flatten])

# for zsh files #{{{2
ZSHRC = %w[.zshrc .zshenv]
MASTER_ZSHHOME = "#{CONFIG}/zsh"
MASTER_ZSHRC = ZSHRC.map {|f| "#{MASTER_ZSHHOME}/dot" + f }
HOME_ZSHRC = ZSHRC.map {|f| "#{HOME}/" + f }
ZSHRC_TABLE = Hash[*MASTER_ZSHRC.zip(HOME_ZSHRC).flatten]

MASTER_ZSHDIR = "#{MASTER_ZSHHOME}/dot.zsh"
HOME_ZSHDIR = "#{HOME}/.zsh"

MASTER_ZSH_FILES = FileList["#{MASTER_ZSHDIR}/**/*"].select {|f| File.file? f }
HOME_ZSH_FILES = MASTER_ZSH_FILES.map {|f| f.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") }
ZSH_FILES_TABLE = Hash[*MASTER_ZSH_FILES.zip(HOME_ZSH_FILES).flatten]

MASTER_ZSH_DIRS = FileList["#{MASTER_ZSHDIR}/**/*"].select {|f| File.directory? f }
HOME_ZSH_DIRS = MASTER_ZSH_DIRS.map {|d| d.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") } << HOME_ZSHDIR

# make directory rule #{{{2
ALL_DIRS = HOME_DOT_DIRS + HOME_ZSH_DIRS

# Tasks #{{{1
TASKS = HOME_DOT_FILES + HOME_DOT_DIR_FILES + HOME_ZSHRC + HOME_ZSH_FILES

task :default => TASKS
task :clean

desc "Update dot files" # {{{2
DOT_FILES_TABLE.each {|master, home|
  target = File.dirname home
  file home => [master, target] do |t|
    cp master, home
  end
}

desc "Update zshrc" #{{{2
ZSHRC_TABLE.each {|master, home|
  file home => master do
    cp master, home
  end
}

desc "Update zsh files" #{{{2
ZSH_FILES_TABLE.each {|master, home|
  target = File.dirname home
  file home => [master, target] do |t|
    cp master, home
  end
}

# Make target directory tasks. #{{{2
# if need to update Vim files, on the fly make target directories.
ALL_DIRS.each {|dir|
  directory dir
}


# __END__ #{{{1
# vim: foldmethod=marker
