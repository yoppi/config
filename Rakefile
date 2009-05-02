## 
# Update some configuration files(.zshrc, .irbrc, .gitrc, and .vimrc, so on).
# NOTE: rake(Ruby Make) is required.
#

# Task definitions #{{{1
HOME = `echo $HOME`.chomp
CONFIG = "#{HOME}/config"

# for some dot files #{{{2
MASTER_DOT_FILES = FileList["#{CONFIG}/dot.*"]
HOME_DOT_FILES = MASTER_DOT_FILES.
  map {|dotfile| "#{HOME}/#{File.basename(dotfile).gsub(/^dot/, '')}" }
zipped = HOME_DOT_FILES.zip(MASTER_DOT_FILES)
DOT_FILES_TABLE = Hash[*zipped.flatten]

# for Vim files #{{{2
MASTER_VIMHOME = "#{CONFIG}/vim"
MASTER_VIMRC = ["#{MASTER_VIMHOME}/dot.vimrc"]
HOME_VIMRC = ["#{HOME}/.vimrc"]
zipped = HOME_VIMRC.zip(MASTER_VIMRC)
VIMRC_TABLE = Hash[*zipped.flatten]

MASTER_VIMDIR = "#{MASTER_VIMHOME}/dot.vim"
HOME_VIMDIR = "#{HOME}/.vim"

MASTER_ALL_VIM_FILES = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| File.file? f } # Vim package allfiles
HOME_ALL_VIM_FILES = MASTER_ALL_VIM_FILES.
  map {|file| file.gsub(/#{MASTER_VIMDIR}/, HOME_VIMDIR) }
zipped = HOME_ALL_VIM_FILES.zip(MASTER_ALL_VIM_FILES)
VIMFILES_TABLE = Hash[*zipped.flatten]

MASTER_ALL_VIM_DIRS = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| File.directory? f }
HOME_ALL_VIM_DIRS = MASTER_ALL_VIM_DIRS.
  map {|d| d.gsub(/#{MASTER_VIMDIR}/, HOME_VIMDIR) }

# for zsh files. #{{{2
ZSHFILES = %w[.zshrc .zshenv]
MASTER_ZSHHOME = "#{CONFIG}/zsh"
MASTER_ZSHFILES = ZSHFILES.map {|f| "#{MASTER_ZSHHOME}/dot" + f }
HOME_ZSHFILES = ZSHFILES.map {|f| "#{HOME}/" + f }
zipped = HOME_ZSHFILES.zip(MASTER_ZSHFILES)
ZSHFILES_TABLE = Hash[*zipped.flatten]

MASTER_ZSHDIR = "#{MASTER_ZSHHOME}/dot.zsh"
HOME_ZSHDIR = "#{HOME}/.zsh"

MASTER_SUB_ZSHFILES = FileList["#{MASTER_ZSHDIR}/**/*"].
  select {|f| f if File.file? f }
HOME_SUB_ZSHFILES = MASTER_SUB_ZSHFILES.
  map {|f| f.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") }
zipped = HOME_SUB_ZSHFILES.zip(MASTER_SUB_ZSHFILES)
SUB_ZSHFILES_TABLE = Hash[*zipped.flatten]

MASTER_SUB_ZSHDIRS = FileList["#{MASTER_ZSHDIR}/**/*"].
  select {|f| f unless File.file? f }
HOME_SUB_ZSHDIRS = MASTER_SUB_ZSHDIRS.
  map {|d| d.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") }

# Tasks #{{{1
TASKS = [:update_dot_files, :update_vimrc, :update_vim_files, 
  :update_zshfiles, :update_zshsubfiles] +
  HOME_DOT_FILES + HOME_VIMRC + HOME_ALL_VIM_FILES +
  HOME_ZSHFILES  + HOME_SUB_ZSHFILES

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

task "update_zshfiles" do #{{{2
  ZSHFILES_TABLE.each {|home, master|
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
    # to check target a directory, exists or not
    target = home.gsub(/\/#{File.basename(home)}/, '')
    file home => [master, target] do |t|
      cp master, target
    end
  }
end

# if need to update zsh files, on the fly make target directories.
HOME_SUB_ZSHDIRS.each {|dir|
  directory dir
}
task "update_zshsubfiles" do #{{{2
  SUB_ZSHFILES_TABLE.each {|home, master|
    target = home.gsub(/\/#{File.basename(home)}/, '')
    file home => [master, target] do
      cp master, target
    end
  }
end


# __END__ #{{{1
# vim: foldmethod=marker
