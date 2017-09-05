var dashboard = {

  save_user_local: function(user, password, port) {
    var u = {
      user: user,
      password: password
    }
    if (parseInt(port) == parseInt(config.admin_port)) {
      localStorage.setItem('spinal_user_connect', JSON.stringify(u));
    } else {
      localStorage.setItem('spinal_connect', JSON.stringify(u));
    }
  },

  get_user_local: function() {
    var user_str;
    if (parseInt(window.location.port) == parseInt(config.admin_port)) {
      user_str = localStorage.getItem('spinal_user_connect');
    } else {
      user_str = localStorage.getItem('spinal_connect');
    }
    if (user_str) {
      var user = JSON.parse(user_str);
      config.user = user.user;
      config.password = user.password;
    }
  },

  launch_organ: function() {
    dashboard.get_user_local();
    if (!config.user || !config.password) {
      window.location = "login-dashboard.html";
    } else {
      SpinalUserManager.get_admin_id("http://" + config.host + ":" + config.admin_port +
		"/", config.user, config.password, function(response) {
        config.user_id = parseInt(response);
        conn = spinalCore.connect("http://" + config.user_id + ":" + config.password + 
		"@" + config.host + ":" + config.admin_port + "/")
        document.getElementById("span-username").innerHTML = "Dashboard - " + config.user;
        launch_spinal_admin();
      }, function(err) {
        SpinalUserManager.get_user_id("http://" + config.host + ":" + config.user_port +
		"/", config.user, config.password, function(response) {
          config.user_id = parseInt(response);
          conn = spinalCore.connect("http://" + config.user_id + ":" + config.password +
		"@" + config.host + ":" + config.user_port + "/")
          document.getElementById("span-username").innerHTML = "Dashboard - " + config.user;
          launch_spinal_dasboard();
        }, function(err) {
          dashboard.disconnect();
        });
      });
    }
  },

  disconnect: function(error) {
    if (config.user)
      delete config.user;
    if (config.password)
      delete config.password;
    localStorage.removeItem('spinal_user_connect');
    if (error)
      window.location = "login-dashboard.html#error";
    else {
      window.location = "login-dashboard.html";
    }
  },

  try_connect: function() {
    var user = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    if (user == "" || password == "")
      return false;
    SpinalUserManager.get_admin_id("http://" + config.host + ":" + config.admin_port + "/", user, password, function(response) {
      dashboard.save_user_local(user, password, config.admin_port);
      if (parseInt(window.location.port) != parseInt(config.admin_port)) {
        window.location.port = config.admin_port;
        return;
      }
      window.location = window.location.protocol + '/' + '/' + window.location.hostname + ":"+config.admin_port+"/html/admin-dashboard.html";
    }, function(err) {
      SpinalUserManager.get_user_id("http://" + config.host + ":" + config.user_port + "/", user, password, function(response) {
        dashboard.save_user_local(user, password, config.user_port);
        if (parseInt(window.location.port) != parseInt(config.user_port)) {
          window.location.port = config.user_port;
          return;
        }
        window.location = window.location.protocol + '/' + '/' + window.location.hostname + ":"+config.user_port+"/html/dashboard.html";
      }, function(err) {
        console.log("Error connect")
        dashboard.error_connect();
        dashboard.disconnect(true);
      });
    });

  },
  error_connect: function() {
    $.gritter.add({
      title: 'Incorrect user ID or password',
      text: 'Type the correct user ID and password, and try again.'
    })
  }
}
