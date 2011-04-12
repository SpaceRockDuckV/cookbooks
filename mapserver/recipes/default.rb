package 'proj-nad'
package 'gdal'
package 'netcdf'

directory '/usr/local/share/java/srdv/' do
  action :create
  owner 'hadoop'
  group 'hadoop'
  mode 0755
  recursive true
end

cookbook_file '/usr/local/share/java/srdv/' do
  source 'libmapscript.so'
  owner 'hadoop'
  group 'hadoop'
  mode 0775
end

cookbook_file '/usr/local/share/java/srdv/' do
  source 'mapscript.jar'
  owner 'hadoop'
  group 'hadoop'
  mode 0775
end
