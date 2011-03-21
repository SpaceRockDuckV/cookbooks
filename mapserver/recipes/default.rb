package 'proj-nad'
package 'gdal'
package 'netcdf'

directory '/usr/local/srdv' do
  owner 'hadoop'
  group 'hadoop'
  mode 0755
end

cookbook_file '/usr/local/srdv/' do
  source 'libmapscript.so'
  owner 'hadoop'
  group 'hadoop'
  mode 0775
end

cookbook_file '/usr/local/srdv/' do
  source 'mapscript.jar'
  owner 'hadoop'
  group 'hadoop'
  mode 0775
end
