## 
# Update some configuration files(.zshrc, .irbrc, .gitrc, and .vimrc, so on).
# NOTE: rake(Ruby Make) is required.
#

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

MASTER_VIM_FILES = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| File.file? f } # Vim package allfiles
HOME_VIM_FILES = MASTER_VIM_FILES.
  map {|file| file.gsub(/#{MASTER_VIMDIR}/, HOME_VIMDIR) }
zipped = MASTER_VIM_FILES.zip HOME_VIM_FILES
VIM_FILES_TABLE = Hash[*zipped.flatten]

MASTER_VIM_DIRS = FileList["#{MASTER_VIMDIR}/**/*"].
  select {|f| File.directory? f }
HOME_VIM_DIRS = MASTER_VIM_DIRS.
  map {|d| d.gsub(/#{MASTER_VIMDIR}/, HOME_VIMDIR) }
VIM_FILES_RULE = lambda {|x| x.gsub(%r|(#{CONFIG}/)?vim/dot|, "#{HOME}/")}


# for zsh files #{{{2
ZSHRC = %w[.zshrc .zshenv]
MASTER_ZSHHOME = "#{CONFIG}/zsh"
MASTER_ZSHRC = ZSHRC.map {|f| "#{MASTER_ZSHHOME}/dot" + f }
HOME_ZSHRC = ZSHRC.map {|f| "#{HOME}/" + f }
zipped = MASTER_ZSHRC.zip HOME_ZSHRC
ZSHRC_TABLE = Hash[*zipped.flatten]

MASTER_ZSHDIR = "#{MASTER_ZSHHOME}/dot.zsh"
HOME_ZSHDIR = "#{HOME}/.zsh"

MASTER_ZSH_FILES = FileList["#{MASTER_ZSHDIR}/**/*"].
  select {|f| File.file? f }
HOME_ZSH_FILES = MASTER_ZSH_FILES.
  map {|f| f.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") }
zipped = MASTER_ZSH_FILES.zip HOME_ZSH_FILES
ZSH_FILES_TABLE = Hash[*zipped.flatten]

MASTER_ZSH_DIRS = FileList["#{MASTER_ZSHDIR}/**/*"].
  select {|f| File.directory? f }
HOME_ZSH_DIRS = MASTER_ZSH_DIRS.
  map {|d| d.gsub(/#{MASTER_ZSHDIR}/, "#{HOME_ZSHDIR}") }
ZSH_FILES_RULE = lambda {|x| x.gsub(%r|(#{CONFIG}/)?zsh/dot|, "#{HOME}/") }

ALL_RULES = %w[DOT VIM ZSH].map {|type| eval("#{type}_FILES_RULE") }
ALL_DIRS = HOME_VIM_DIRS + HOME_ZSH_DIRS

# Tasks #{{{1
TASKS = [:update_dot_files, :update_vimrc, :update_vim_files, 
  :update_zshrc, :update_zsh_files, :update_manifest] +
  HOME_DOT_FILES + 
  HOME_VIMRC + HOME_VIM_FILES +
  HOME_ZSHRC + HOME_ZSH_FILES

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

desc "Update vimrc" #{{{2
task "update_vimrc" do 
  VIMRC_TABLE.each {|master, home|
    file home => master do
      cp master, home
    end
  }
end

desc "Update zshrc" #{{{2
task "update_zshrc" do 
  ZSHRC_TABLE.each {|master, home|
    file home => master do
      cp master, home
    end
  }
end

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

desc "Update zsh files" #{{{2
task "update_zsh_files" do
  ZSH_FILES_TABLE.each {|master, home|
    target = home.gsub(/\/#{File.basename(home)}/, '')
    file home => [master, target] do
      cp master, target
    end
  }
end


desc "Update manifest" #{{{2
task "update_manifest" do
  currents = Dir.glob("#{CONFIG}/**/*").
    map {|f| f.gsub(%r|#{CONFIG}/|, "") }.sort
  manifest = File.readlines(MANIFEST).map {|l| l.chomp }
  diff = currents - manifest

  if diff.size > 0
    puts "update Manifest"
    File.open(MANIFEST, 'w') {|io| io.puts currents }
  end
end

# Make target directory tasks. #{{{2
# if need to update Vim files, on the fly make target directories. 
ALL_DIRS.each {|dir|
  directory dir
}

desc "Cleanup" #{{{2
task "clean" do
  manifest = File.readlines(MANIFEST).map {|f| f.chomp }
  # diff
  # to head files before directories
  diff = manifest.select {|f| !File.exists? f }.sort {|a, b| b <=> a }
  
  # clean and update manifest
  if diff.size > 0
    diff.each {|d|
      ALL_RULES.each {|rule|
        target = rule.call(d)
        if File.exists? target
          if File.file? target then rm target
          elsif File.directory? then rmdir target
          else next
          end 
        end
      }
    }

    new = manifest - diff
    File.open(MANIFEST, 'w') {|io| io.puts new }
  end
end

# __END__ #{{{1
# vim: foldmethod=marker
