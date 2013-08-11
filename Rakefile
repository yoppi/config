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

# Tasks #{{{1
TASKS = HOME_DOT_FILES + HOME_DOT_DIR_FILES

task :default => TASKS
task :clean

desc "Update dot files" # {{{2
DOT_FILES_TABLE.each {|master, home|
  target = File.dirname home
  file home => [master, target] do |t|
    cp master, home
  end
}

# Make target directory tasks. #{{{2
# if need to update dot files, on the fly make target directories.
HOME_DOT_DIRS.each {|dir|
  directory dir
}


# __END__ #{{{1
# vim: foldmethod=marker
