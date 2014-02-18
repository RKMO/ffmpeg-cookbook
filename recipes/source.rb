include_recipe "ark"
include_recipe "yasm"

node[:ffmpeg][:packages].each do |pkg|
  package pkg
end

directory "#{node[:ffmpeg][:source_prefix]}/ffmpeg-#{node[:ffmpeg][:version]}" do
    recursive true
    action :delete
end

template "/etc/apt/sources.list.d/faac.list" do
    source "libfaac-dev.list.erb"
    notifies :run, resources(:execute => "apt-get update"), :immediately
end

package "faac"


directory "/opt/ffmpeg_sources"

bash "install yasm" do
  cwd "/opt/ffmpeg_sources"
  code <<-EOH
      git clone git://github.com/yasm/yasm.git
      cd yasm
      sh autogen.sh
      make
      sudo checkinstall --pkgname=yasm --pkgversion="1.1.0" --backup=no --deldoc=yes --default
  EOH
end

bash "install lame" do
  user "root"
  cwd "/opt/ffmpeg_sources"
  code <<-EOH
        wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.tar.gz
        tar xzvf lame-3.99.tar.gz
        cd lame-3.99
        ./configure
        make
        sudo checkinstall --pkgname=lame-ffmpeg --pkgversion="3.99" --backup=no --default --deldoc=yes
  EOH
end

bash "install opencore-amr" do
  user "root"
  cwd "/opt/ffmpeg_sources"
  code <<-EOH
        wget http://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.1.tar.gz
        tar zxvf vo-amrwbenc-0.1.1.tar.gz
        cd vo-amrwbenc-0.1.1
        ./configure
        make
        sudo checkinstall --pkgname="libopencore-amr" --pkgversion="0.1.1" --backup=no --fstrans=no --install=yes --default
  EOH
end

bash "install libtheora" do
  user "root"
  cwd "/opt/ffmpeg_sources"
  code <<-EOH
        wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
        tar jxvf libtheora-1.1.1.tar.bz2
        cd libtheora-1.1.1
        ./configure
        make
        sudo checkinstall --pkgname=libtheora --pkgversion "1.1.1" --backup=no --fstrans=no --install=yes --default
  EOH
end

ark "ffmpeg" do
  url node[:ffmpeg][:source_url]
  prefix_root node[:ffmpeg][:source_prefix]
  version node[:ffmpeg][:version]
  action [:configure, :install_with_make ]
  autoconf_opts node[:ffmpeg][:autoconf_opts] if node[:ffmpeg][:autoconf_opts]
end
