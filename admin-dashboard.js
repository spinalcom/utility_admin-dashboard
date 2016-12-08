// var conn, spinalCore, fs, vm;
//
// fs = require("fs");
// vm = require("vm");
//
// spinalCore = require('spinalcore');
//
// /*vm.runInThisContext(fs.readFileSync('./models-manager/SpinalAdmin/spinalAdmin.models.js'));
// vm.runInThisContext(fs.readFileSync('./models-manager/SpinalAdmin/spinalAdmin.views.js'));  */
//
// require('./models-manager/SpinalAdmin/spinalAdmin.models');
// require('./models-manager/SpinalAdmin/spinalAdmin.views');

// var handleJstreeAjax = function(_data) {
//     $('#jstree-ajax').jstree({
//         "core": {
//             "themes": { "responsive": false },
//             "check_callback": true,
//             'data': _data
//         },
//         "types": {
//             "default": { "icon": "fa fa-folder text-warning fa-lg" },
//             "directory": { "icon": "fa fa-folder text-warning fa-lg" },
//             "file": { "icon": "fa fa-file text-warning fa-lg" }
//         },
//         "plugins": [ "dnd", "state", "types" ]
//     });
// };

var handleJstreeAjax = function() {
    $('#jstree-ajax').jstree({
        "core": {
            "themes": { "responsive": false },
            "check_callback": true,
            'data': {
                'url': function (node) {
                    return node.id === '#' ? 'assets/plugins/jstree/demo/data_root.json': 'assets/plugins/jstree/demo/' + node.original.file;
                },
                'data': function (node) {
                    return { 'id': node.id };
                },
                "dataType": "json"
            }
        },
        "types": {
            "default": { "icon": "fa fa-folder text-warning fa-lg" },
            "file": { "icon": "fa fa-file text-warning fa-lg" }
        },
        "plugins": [ "dnd", "state", "types" ]
    });
};


var TreeView = function () {
        "use strict";
    return {
        //main function
        init: function () {
            handleJstreeAjax();
//             handleJstreeAjax2();
        }
    };
}();


var admin_dashboard = {

  save_user_local: function(user, password) {
    var u = {user:user,password:password}
    localStorage.setItem('spinal_connect', JSON.stringify(u));
  },

  get_user_local: function() {
    var user_str = localStorage.getItem('spinal_connect');
    if (user_str) {
      var user = JSON.parse(user_str);
      config.user = user.user;
      config.password = user.password;
    }
  },

  launch_organ: function() {
    admin_dashboard.get_user_local();
    if (!config.user || !config.password) {
      window.location = "login-admin-dashboard.html";
    } else {
      SpinalUserManager.get_user_id("http://" + config.host + ":" + config.port + "/",
        config.user, config.password, function(response) {
          config.user_id = parseInt(response);
          conn = spinalCore.connect("http://" + config.user_id + ":" + config.password
          + "@" + config.host + ":" + config.port + "/")
          launch_spinal_admin();
        }, function(err) {
          admin_dashboard.disconnect();
        });
    }
  },

  disconnect: function(error) {
    if (config.user)
      delete config.user;
    if (config.password)
      delete config.password;
    localStorage.removeItem('spinal_connect');
    if (error)
      window.location = "login-admin-dashboard.html#error";
    else
      window.location = "login-admin-dashboard.html";
  },

  try_connect: function() {
    var user = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    if (user == "" || password == "")
      return false;
    SpinalUserManager.get_user_id("http://" + config.host + ":" + config.port + "/",
      user, password, function(response) {
        admin_dashboard.save_user_local(user, password);
        window.location = "admin-dashboard.html";
      }, function(err) {
        console.log("Error connect")
        admin_dashboard.error_connect();
        admin_dashboard.disconnect(true);
      });
  },
  error_connect: function() {
    $.gritter.add({
      title: 'Incorrect user ID or password',
      text: 'Type the correct user ID and password, and try again.'
    })
  }
}
