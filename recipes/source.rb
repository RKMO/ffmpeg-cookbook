include_recipe "ark"

template '/etc/apt/sources.list.d/libfaac-dev.list' do
  notifies :run, 'execute[apt-get update]', :immediately
end

node[:ffmpeg][:packages].each do |pkg|
  package pkg
end

ark "ffmpeg" do
  url node[:ffmpeg][:source_url]
  prefix_root node[:ffmpeg][:source_prefix]
  version node[:ffmpeg][:version]
  action [ :configure, :install_with_make ]
  autoconf_opts node[:ffmpeg][:autoconf_opts] if node[:ffmpeg][:autoconf_opts]
end
