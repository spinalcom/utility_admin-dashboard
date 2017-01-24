
all:
	@echo "compiling utility_admin-dashboard..."
	@test -e ../admin-dashboard.html || ( cd .. && ln -s utility_admin-dashboard/admin-dashboard.html)
	@test -e ../login-admin-dashboard.html || ( cd .. && ln -s utility_admin-dashboard/login-admin-dashboard.html)
	@test -e ../dashboard.html || ( cd .. && ln -s utility_admin-dashboard/dashboard.html)
	@test -e ../login-dashboard.html || ( cd .. && ln -s utility_admin-dashboard/login-dashboard.html)
	@(cd SpinalAdmin && $(MAKE) --no-print-directory)

clean:
	@! test -e ../admin-dashboard.html || rm ../admin-dashboard.html
	@! test -e ../login-admin-dashboard.html || rm ../login-admin-dashboard.html
	@! test -e ../dashboard.html || rm ../dashboard.html
	@! test -e ../login-dashboard.html || rm ../login-dashboard.html
	@(cd SpinalAdmin && $(MAKE) --no-print-directory clean)
