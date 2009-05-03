## 
# Update some configuration files(.zshrc, .irbrc, .gitrc, and .vimrc, so on).
# NOTE: rake(Ruby Make) is required.
#
require 'yaml'

# Task definitions #{{{1
HOME = ENV['HOME']
CONFIG = "#{HOME}/config"
MANIFEST = "#{CONFIG}/Manifest"

# for some dot files #{{{2
MASTER_DOT_FILES = FileList["#{CONFIG}/dot.*"]
HOME_DOT_FILES = MASTER_DOT_FILES.
  map {|dotfile| "#{HOME}/#{File.basename(dotfile).gsub(/^dot/, '')}" }
zipped = MASTER_DOT_FILES.zip HOME_DOT_FILES
DOT_FILES_TABLE = Hash[*zipped.flatten]
DOT_FILES_RULE = lambda {|x| x.gsub(%r|(#{CONFIG}/)?dot|, "#{HOME}/") }

# for Vim files #{{{2
MASTER_VIMHOME = "#{CONFIG}/vim"
MASTER_VIMRC = ["#{MASTER_VIMHOME}/dot.vimrc"]
HOME_VIMRC = ["#{HOME}/.vimrc"]
zipped = MASTER_VIMRC.zip HOME_VIMRC
VIMRC_TABLE = Hash[*zipped.flatten]

MASTER_VIMDIR = "#{MASTER_VIMHOME}/dot.vim"
HOME_VIMDIR = "#{HOME}/.vim"

MASTER_ALL_VIM_FILES = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| File.file? f } # Vim package allfiles
HOME_ALL_VIM_FILES = MASTER_ALL_VIM_FILES.
  map {|file| file.gsub(/#{MASTER_VIMDIR}/, HOME_VIMDIR) }
zipped = MASTER_ALL_VIM_FILES.zip HOME_ALL_VIM_FILES
VIM_FILES_TABLE = Hash[*zipped.flatten]

MASTER_ALL_VIM_DIRS = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| File.directory? f }
HOME_ALL_VIM_DIRS = MASTER_ALL_VIM_DIRS.
  map {|d| d.gsub(/#{MASTER_VIMDIR}/, HOME_VIMDIR) }
VIM_FILES_RULE = lambda {|x| x.gusb(%r|(#{CONFIG}/)?vim/dot|, "#{HOME}/")}

# for zsh files. #{{{2
ZSHFILES = %w[.zshrc .zshenv]
MASTER_ZSHHOME = "#{CONFIG}/zsh"
MASTER_ZSHFILES = ZSHFILES.map {|f| "#{MASTER_ZSHHOME}/dot" + f }
HOME_ZSHFILES = ZSHFILES.map {|f| "#{HOME}/" + f }
zipped = MASTER_ZSHFILES.zip HOME_ZSHFILES
ZSHFILES_TABLE = Hash[*zipped.flatten]

MASTER_ZSHDIR = "#{MASTER_ZSHHOME}/dot.zsh"
HOME_ZSHDIR = "#{HOME}/.zsh"

MASTER_SUB_ZSHFILES = FileList["#{MASTER_ZSHDIR}/**/*"].
  select {|f| File.file? f }
HOME_SUB_ZSHFILES = MASTER_SUB_ZSHFILES.
  map {|f| f.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") }
zipped = MASTER_SUB_ZSHFILES.zip HOME_SUB_ZSHFILES
SUB_ZSHFILES_TABLE = Hash[*zipped.flatten]

MASTER_SUB_ZSHDIRS = FileList["#{MASTER_ZSHDIR}/**/*"].
  select {|f| File.directory? f }
HOME_SUB_ZSHDIRS = MASTER_SUB_ZSHDIRS.
  map {|d| d.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") }
ZSH_FILES_RULE = lambda {|x| x.gsub(%r|(#{CONFIG}/)?zsh/dot|, "#{HOME}/") }


# Tasks #{{{1
TASKS = [:update_dot_files, :update_vimrc, :update_vim_files, 
  :update_zshfiles, :update_zshsubfiles] +
  HOME_DOT_FILES + HOME_VIMRC + HOME_ALL_VIM_FILES +
  HOME_ZSHFILES  + HOME_SUB_ZSHFILES

task :default => TASKS
task :clean

desc "Update dot files" # {{{2
task "update_dot_files" do 
  DOT_FILES_TABLE.each {|master, home|
    file home => master do
      cp master, home
    end
  }
end

desc "Update .vimrc" #{{{2
task "update_vimrc" do 
  VIMRC_TABLE.each {|master, home|
    file home => master do
      cp master, home
    end
  }
end

desc "Update zsh files" #{{{2
task "update_zshfiles" do 
  ZSHFILES_TABLE.each {|master, home|
    file home => master do
      cp master, home
    end
  }
end

# Make target directory tasks for Vim. #{{{2
# if need to update Vim files, on the fly make target directories. 
HOME_ALL_VIM_DIRS.each {|dir|
  directory dir
}
desc "Update vim files" #{{{2
task "update_vim_files" do
  VIM_FILES_TABLE.each {|master, home| 
    # to check target a directory, exists or not
    target = home.gsub(/\/#{File.basename(home)}/, '')
    file home => [master, target] do |t|
      cp master, target
    end
  }
end

# Make target directory tasks for zsh. #{{{2
# if need to update zsh files, on the fly make target directories.
HOME_SUB_ZSHDIRS.each {|dir|
  directory dir
}
desc "Update zsh subfiles" #{{{2
task "update_zshsubfiles" do
  SUB_ZSHFILES_TABLE.each {|master, home|
    target = home.gsub(/\/#{File.basename(home)}/, '')
    file home => [master, target] do
      cp master, target
    end
  }
end

desc "Cleanup" #{{{2
task "clean" do
  manifest = File.readlines(MANIFEST).map {|f| f.chomp }
  # diff
  # to head files before directories
  diff = manifest.select {|f| !File.exists? f }.sort {|a, b| b <=> a }
  
  # clean and update manifest
  if diff.size > 0
    diff.each {|d|
      case d
      when /^dot\./
        
      when /^vim/

      when /^zsh/

      else
        next
      end
    }

    new = manifest - diff
    File.open(MANIFEST, 'w') {|io| io.puts new }
  end
end

# __END__ #{{{1
# vim: foldmethod=marker
