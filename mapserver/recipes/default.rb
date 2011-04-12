package 'proj-nad'
package 'gdal'
package 'netcdf'

directory '/usr/local/share/java/srdv/' do
  action :create
  owner 'mapred'
  group 'hadoop'
  mode 0755
  recursive true
end

%w(libmapscript.so mapscript.jar).each do |f|
  cookbook_file "/usr/local/share/java/srdv/#{f}" do
    source "#{f}"
    owner 'mapred'
    group 'hadoop'
    mode 0775
  end
end
