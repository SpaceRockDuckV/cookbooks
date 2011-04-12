package 'proj-nad'
package 'gdal'
package 'netcdf'

directory '/usr/local/share/java/srdv/' do
  action :create
  owner 'mapred'
  group 'hadoop'
  mode 0755
  recursive true
  creates '/usr/local/share/java/srdv/'
end

cookbook_file '/usr/local/share/java/srdv/' do
  source 'libmapscript.so'
  owner 'mapred'
  group 'hadoop'
  mode 0775
end

cookbook_file '/usr/local/share/java/srdv/' do
  source 'mapscript.jar'
  owner 'mapred'
  group 'hadoop'
  mode 0775
end
