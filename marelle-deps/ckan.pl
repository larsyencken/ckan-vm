%
%  ckan.pl
%  ckan-vm
%
%  Dependencies for setting up CKAN on Ubuntu 12.04.
%

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
