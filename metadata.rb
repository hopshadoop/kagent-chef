
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
name             "kagent"
license          "GPL 2.0"
description      "Installs/Configures the Karamel agent used by Hops"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"
source_url       "https://github.com/karamelchef/kagent-chef"


%w{ ubuntu debian centos }.each do |os|
  supports os
end

depends 'openssl'
depends 'sudo'
depends 'hostsfile'
depends 'ntp'
depends 'conda'
depends 'magic_shell'


recipe "kagent::install", "Installs the Karamel agent and python dependencies"
recipe "kagent::default", "Installs and configures the Karamel agent, including anaconda"
recipe "kagent::purge", "Deletes the Karamel agent files"
recipe "kagent::dev", "Development helper library"

attribute "kagent/user",
          :description => "Username to run kagent as",
          :type => 'string'

attribute "kagent/group",
          :description => "group to run kagent as",
          :type => 'string'

attribute "kagent/dir",
          :description => "Installation directory for kagent",
          :type => 'string'

attribute "kagent/enabled",
          :description => "Kagent enabled: default 'true'. Set to 'false' to disable it.",
          :type => 'string'

attribute "kagent/dns",
          :description => "Default 'false'. Set to 'true' to use fully qualified domain names for kagent hosts in Hopsworks.",
          :type => 'string'

attribute "kagent/hostid",
          :description => " One-time password used when registering the host",
          :type => 'string'

attribute "kagent/name",
          :description => "Cookbook name",
          :type => 'string'

attribute "kagent/password",
          :description => "Agent's password - needed to call REST APIs on the kagent",
          :type => 'string'

attribute "kagent/rest_api/user",
          :description => "kagent REST API username",
          :type => "string"

attribute "kagent/rest_api/password",
          :description => "kagent REST API  password",
          :type => "string"

attribute "kagent/dashboard/user",
          :description => "kagent username to register with server",
          :type => "string"

attribute "kagent/dashboard/password",
          :description => "kagent password to register with server",
          :type => "string"

attribute "systemd",
          :description => "Use systemd startup scripts, default 'true'",
          :type => "string"

attribute "kagent/conda_gc_interval",
          :description => "Define interval for kagent to run Anaconda garbage collection, suffix: ms, s, m, h, d. Default: 1h",
          :type => "string"

attribute "ntp/install",
          :description => "Install Network Time Protocol (default: false)",
          :type => "string"

attribute "services/enabled",
          :description => "Default 'false'. Set to 'true' to enable daemon services, so that they are started on a host restart.",
          :type => "string"

attribute "hops/yarn/user",
          :description => "Yarn user for conda",
          :type => "string"

attribute "hops/group",
          :description => "Haodop group for conda",
          :type => "string"

attribute "certs/dir",
          :description => "Installation directory for ssl/tls certs",
          :type => 'string'

attribute "hops/dir",
          :description => "Installation directory for Hops",
          :type => 'string'

attribute "jupyter/python",
          :description => "'true' (default) to enable the python interpreter, 'false' to disable it (more secure). ",
          :type => 'string'

attribute "kagent/python_conda_versions",
          :description => "CSV of python versions to be used as base environments for Anaconda",
          :type => "string"

attribute "zfs/days_between_key_rotations",
          :description => "Number of days between changes to zfs dataset encryption keys",
          :type => "string"

attribute "zfs/pool",
          :description => "ZFS pool name. ZFS datasets will be created in this pool using the hopsfs data.dirs to store encrypted hopsfs data",
          :type => "string"
