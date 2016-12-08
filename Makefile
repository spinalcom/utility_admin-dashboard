
all:
	test -e ../admin-dashboard.html || ( cd .. && ln -s utility_admin-dashboard/admin-dashboard.html)
	test -e ../login-admin-dashboard.html || ( cd .. && ln -s utility_admin-dashboard/login-admin-dashboard.html)
	(cd SpinalAdmin && $(MAKE))

clean:
	@! test -e ../admin-dashboard.html || rm ../admin-dashboard.html
	@! test -e ../login-admin-dashboard.html || rm ../login-admin-dashboard.html
	@(cd SpinalAdmin && $(MAKE) clean)
