## 
# Update some configuration files(.zshrc, .irbrc, .gitrc, and .vimrc, so on).
# NOTE: rake(Ruby Make) is required.

# Task definitions #{{{1
HOME = `echo $HOME`.chomp
CONFIG = "#{HOME}/config"

MASTER_DOT_FILES = FileList["#{CONFIG}/dot.*"]
HOME_DOT_FILES = MASTER_DOT_FILES.
  map {|dotfile| "#{HOME}/#{File.basename(dotfile).gsub(/^dot/, '')}"}
zipped = HOME_DOT_FILES.zip(MASTER_DOT_FILES)
DOT_FILES_TABLE = Hash[*zipped.flatten]

MASTER_VIMHOME = "#{CONFIG}/vim"
MASTER_VIMRC = ["#{MASTER_VIMHOME}/dot.vimrc"]
HOME_VIMRC = ["#{HOME}/.vimrc"]
zipped = HOME_VIMRC.zip(MASTER_VIMRC)
VIMRC_TABLE = Hash[*zipped.flatten]

MASTER_VIMDIR = "#{MASTER_VIMHOME}/dot.vim"
HOME_VIMDIR = "#{HOME}/.vim"

MASTER_ALL_VIM_FILES = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| f if File.file? f }# Vim package allfiles
HOME_ALL_VIM_FILES = MASTER_ALL_VIM_FILES.
  map {|file| file.gsub(/#{MASTER_VIMDIR}/, "#{HOME_VIMDIR}") }
zipped = HOME_ALL_VIM_FILES.zip(MASTER_ALL_VIM_FILES)
VIMFILES_TABLE = Hash[*zipped.flatten]

MASTER_ALL_VIM_DIRS = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| f unless File.file? f }
HOME_ALL_VIM_DIRS = MASTER_ALL_VIM_DIRS.
  map {|d| d.gsub(/#{MASTER_VIMDIR}/, "#{HOME_VIMDIR}")}

TASKS = [:update_dot_files, :update_vimrc, :update_vim_files] + HOME_DOT_FILES + HOME_VIMRC + HOME_ALL_VIM_FILES

# Tasks. #{{{1
task :default => TASKS

task "update_dot_files" do # {{{2
  DOT_FILES_TABLE.each {|home, master|
    file home => master do
      cp master, home
    end
  }
end

task "update_vimrc" do #{{{2
  VIMRC_TABLE.each {|home, master|
    file home => master do
      cp master, home
    end
  }
end

# Make target directory tasks. #{{{2
# if need to update Vim files, on the fly make target directories. 
HOME_ALL_VIM_DIRS.each {|dir|
  directory dir
}
task "update_vim_files" do #{{{2
  VIMFILES_TABLE.each {|home, master|
    target = home.gsub(/\/#{File.basename(home)}/, '')
    file home => [master, target] do |t|
      cp master, target
    end
  }
end

# __END__ #{{{1
# vim: foldmethod=marker
