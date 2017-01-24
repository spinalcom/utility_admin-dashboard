# Copyright 2016 SpinalCom  www.spinalcom.com
#
# This file is part of SpinalCore.
#
# SpinalCore is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Soda is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with Soda. If not, see <http://www.gnu.org/licenses/>.

class Menu_and_modals
  constructor:(@selected_data)->
    @customMenu = (node)=>
      items =
        shareItem:
          icon : 'fa fa-share text-success',
          separator_before : false
          separator_after : false
          label: "Share"
          action: ()=>
            this._shareItem this.getModel_by_model_id this.selected_data
        createItem:
          separator_before : false
          separator_after : false
          icon : 'fa fa-file text-warning',
          label: "Create"
          action: ()=>
            this._createItem this.getModel_by_model_id this.selected_data
        deleteItem:
          separator_before : true
          separator_after : false
          icon : 'fa fa-trash text-danger',
          label: "Delete"
          action: ()=>
            this._deleteItem this.getModel_by_model_id this.selected_data
      return items;

  _shareItem: (data)=>
    console.log "SHARE ITEM";
    console.log data;
    spinalCore.share_model(conn, data, data.name.get(), spinalCore.right_flag.RD, "a@a");

  _createItem: (data)=>
    console.log "CREATE ITEM";
    console.log data;

  _deleteItem: (data)=>
    console.log "DELETE ITEM";
    console.log data;

  getModel_by_model_id: ( @selectedID )->
    for k, m of FileSystem._objects
      if parseInt(m.model_id) == parseInt(@selectedID)
        return m

# function customMenu(node) {
#   // The default set of all items
#   var items = {
#     // renameItem: { // The "rename" menu item
#     //   label: "Rename",
#     //   action: function() {
#     //     console.log("HEHE rename");
#     //   }
#     // },
#     deleteItem: { // The "delete" menu item
#       label: "Delete",
#       action: function(obj) {
#         console.log("HEHE delete");
#         console.log(obj.reference);
#         // if ($(this.get_node(obj)).hasClass("folder"))
#         //   return; // cancel action
#
#       }
#     },
#     shareItem: { // The "delete" menu item
#       label: "Share",
#       action: function(obj) {
#         console.log("HEHE delete");
#         console.log(obj.reference);
#         // if ($(this.get_node(obj)).hasClass("folder"))
#         //   return; // cancel action
#
#       }
#     }
#
#   };
#
#   return items;
# }
#
