include_recipe "ark"

sources_dir = "#{node[:ffmpeg][:source_prefix]}/ffmpeg_sources"

directory sources_dir do
  recursive true
  action :create
end

template "/etc/apt/sources.list.d/faac.list" do
  source "libfaac-dev.list.erb"
  notifies :run, resources(:execute => "apt-get update"), :immediately
end

node[:ffmpeg][:packages].each do |pkg|
  package pkg
end

directory "#{node[:ffmpeg][:source_prefix]}/ffmpeg-#{node[:ffmpeg][:version]}" do
  recursive true
  action :delete
end

package "faac"

yasm_tar = "#{Chef::Config[:file_cache_path]}/yasm-1.2.0.tar.gz"
remote_file yasm_tar do
  source "https://github.com/yasm/yasm/archive/v1.2.0.tar.gz"
  action :create_if_missing
end

bash "install yasm" do
  cwd sources_dir
  code <<-EOH
    tar xzvf #{yasm_tar}
    cd yasm-1.2.0
    sh autogen.sh &&
      make &&
      checkinstall --pkgname=yasm --pkgversion="1.2.0" --backup=no --deldoc=yes --default &&
      touch #{sources_dir}/yasm-1.2.0_installed
  EOH
  creates "#{sources_dir}/yasm-1.2.0_installed"
end

x264_tar = "#{Chef::Config[:file_cache_path]}/last_x264.tar.bz2"
remote_file x264_tar do
  source "http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2"
  action :create_if_missing
end

bash "install x264" do
  user "root"
  cwd sources_dir
  code <<-EOH
    tar xjvf #{x264_tar}
    cd x264-snapshot*
    ./configure --enable-shared &&
      make &&
      checkinstall --pkgname=x264 --pkgversion="0.142" --backup=no --install=yes --default --deldoc=yes &&
      touch #{sources_dir}/x264-0.142_installed
  EOH
  creates "#{sources_dir}/x264-0.142_installed"
end

lame_tar = "#{Chef::Config[:file_cache_path]}/lame-3.99.tar.gz"
remote_file lame_tar do
  source "http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.tar.gz"
  action :create_if_missing
end

bash "install x264" do
  user "root"
  cwd "/opt/ffmpeg_sources"
  code <<-EOH
    wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
    tar xjvf last_x264.tar.bz2
    cd x264-snapshot*
    ./configure --enable-shared
    make
    sudo checkinstall --pkgname=x264 --pkgversion="0.142" --backup=no --install=yes --default --deldoc=yes
  EOH
end


bash "install lame" do
  user "root"
  cwd sources_dir
  code <<-EOH
    tar xzvf #{lame_tar}
    cd lame-3.99
    ./configure &&
      make &&
      checkinstall --pkgname=lame-ffmpeg --pkgversion="3.99" --backup=no --default --deldoc=yes &&
      touch #{sources_dir}/lame-3.99_installed
  EOH
  creates "#{sources_dir}/lame-3.99_installed"
end

opencore_tar = "#{Chef::Config[:file_cache_path]}/vo-amrwbenc-0.1.1.tar.gz"
remote_file opencore_tar do
  source "http://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.1.tar.gz"
  action :create_if_missing
end

bash "install opencore-amr" do
  user "root"
  cwd sources_dir
  code <<-EOH
    tar xzvf #{opencore_tar}
    cd vo-amrwbenc-0.1.1
    ./configure &&
      make &&
      checkinstall --pkgname="libopencore-amr" --pkgversion="0.1.1" --backup=no --fstrans=no --install=yes --default &&
      touch #{sources_dir}/opencore-0.1.1_installed
  EOH
  creates "#{sources_dir}/opencore-0.1.1_installed"
end

libtheora_tar = "#{Chef::Config[:file_cache_path]}/libtheora-1.1.1.tar.bz2"
remote_file libtheora_tar do
  source "http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2"
  action :create_if_missing
end

bash "install libtheora" do
  user "root"
  cwd sources_dir
  code <<-EOH
    tar xjvf #{libtheora_tar}
    cd libtheora-1.1.1
    ./configure &&
      make &&
      checkinstall --pkgname=libtheora --pkgversion "1.1.1" --backup=no --fstrans=no --install=yes --default &&
      touch #{sources_dir}/libtheora-1.1.1_installed
  EOH
  creates "#{sources_dir}/libtheora-1.1.1_installed"
end

ark "ffmpeg" do
  url node[:ffmpeg][:source_url]
  prefix_root node[:ffmpeg][:source_prefix]
  version node[:ffmpeg][:version]
  action [:configure, :install_with_make ]
  autoconf_opts node[:ffmpeg][:autoconf_opts] if node[:ffmpeg][:autoconf_opts]
end
