#
# Read notes on what needs to be done for pyspark here:
# http://blog.cloudera.com/blog/2015/09/how-to-prepare-your-apache-hadoop-cluster-for-pyspark-jobs/
#

node.override["conda"]["accept_license"] = "yes"

#
# We would like to install anaconda as user 'glassfish' and then have kagent call it using a sudo script
#

if node.attribute?(:hops) and node["hops"].attribute?(:yarn) and node["hops"]["yarn"].attribute?(:user)
  node.override["conda"]["user"] = node["hops"]["yarn"]["user"]
end                             

if node.attribute?(:hops) and node["hops"].attribute?(:group)
  node.override["conda"]["group"] = node["hops"]["group"]
end                             

if node.attribute?(:install) and node["install"].attribute?(:dir) and node["install"]["dir"].empty? == false
  node.override["conda"]["dir"] = node["install"]["dir"]
end  

if node.attribute?(:install) and node["install"].attribute?(:user) and node["install"]["user"].empty? == false
  node.override["conda"]["user"] = node["install"]["user"]
  node.override["conda"]["group"] = node["install"]["user"]
end

include_recipe "conda::install"
include_recipe "conda::default"

kagent_conda "packages" do
  action :config
end


#
# Download python wheels for tensorflow to be installed by kagent/conda for each project
#
url1 = node["tensorflow"]["py36"]["url"] 
url2 = node["tensorflow"]["py27"]["url"] 
for url in ["#{url1}","#{url2}"]
  bin=File.basename(url)
  remote_file "#{node['conda']['base_dir']}/pkgs/#{bin}" do
    #  checksum installer_checksum  
    source url
    mode 0755
    action :create
  end
end

