%
%  ckan.pl
%  ckan-vm
%
%  Dependencies for setting up CKAN on Ubuntu 12.04.
%
%  Follows instructions from:
%  http://docs.ckan.org/en/latest/install-from-package.html
%

meta_pkg('ckan-server-standalone', [
    'postgresql',
    'openjdk-6-jdk',
    'solr configured'
]).

pkg(ckan).
met(ckan, linux(_)) :- check_dpkg('python-ckan').
meet(ckan, linux(_)) :-
    bash('rm -f /tmp/python-ckan_2.0_amd64.deb'),
    bash('cd /tmp && wget http://packaging.ckan.org/python-ckan_2.0_amd64.deb'),
    bash('sudo dpkg -i /tmp/python-ckan_2.0_amd64.deb').
depends(ckan, linux(_), [
    nginx,
    apache2,
    'libapache2-mod-wsgi',
    libpq5
]).

managed_pkg(nginx).
managed_pkg(apache2).
managed_pkg('libapache2-mod-wsgi').
managed_pkg(libpq5).
managed_pkg(postgresql).
managed_pkg('solr-jetty').
managed_pkg('openjdk-6-jdk').

pkg('solr configured').
met('solr configured', linux(_)) :-
    bash('diff -q /vagrant/config/jetty /etc/default/jetty').
meet('solr configured', linux(_)) :-
    bash('sudo cp -f /vagrant/config/jetty /etc/default/jetty'),
    bash('sudo rm -f /etc/solr/conf/schema.xml'),
    bash('sudo ln -s /usr/lib/ckan/default/src/ckan/ckan/config/solr/schema-2.0.xml /etc/solr/conf/schema.xml'),
    bash('sudo service jetty restart').
depends('solr configured', linux(_), ['solr-jetty']).
