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
mnm = {};

class Menu_and_modals
  constructor:(@selected_data)->
    mnm = this;
    @flag = 0;
    $('#modal-share-read').on('change', ()->
      if $(this).prop('checked')
        mnm.flag |= spinalCore.right_flag.RD
      else
        mnm.flag &= ~spinalCore.right_flag.RD
      console.log (mnm.flag);
    )
    $('#modal-share-write').on('change', ()->
      if $(this).prop('checked')
        mnm.flag |= spinalCore.right_flag.WR
      else
        mnm.flag &= ~spinalCore.right_flag.WR
      console.log (mnm.flag);
    )
    $('#modal-share-share').on('change', ()->
      if $(this).prop('checked')
        mnm.flag |= spinalCore.right_flag.AD
      else
        mnm.flag &= ~spinalCore.right_flag.AD
      console.log (mnm.flag);
    )
    $('#modal-share').on('shown.bs.modal', ()-> $('#modal-share-target').focus() );

    @customMenu = (node)=>
      items =
        shareItem:
          icon : 'fa fa-share text-success',
          separator_before : false
          separator_after : false
          label: "Share"
          action: ()=>
            this._shareItem()
        # createItem:
        #   separator_before : false
        #   separator_after : false
        #   icon : 'fa fa-file text-warning',
        #   label: "Create"
        #   action: ()=>
        #     this._createItem()
        # deleteItem:
        #   separator_before : true
        #   separator_after : false
        #   icon : 'fa fa-trash text-danger',
        #   label: "Delete"
        #   action: ()=>
        #     this._deleteItem()
      return items;

  _shareItem: ()=>
    $('#modal-share-read').prop('checked', false);
    $('#modal-share-write').prop('checked', false);
    $('#modal-share-share').prop('checked', false);
    document.getElementById('modal-share-target').value = "";
    mnm.getModel_by_model_id mnm.selected_data
    document.getElementById('modal-share-file').value =
      mnm.getModel_by_model_id(mnm.selected_data).name;
    @flag = 0;

    $('#modal-share').modal();

  _createItem: ()=>
    console.log "CREATE ITEM";
    console.log data;

  _deleteItem: ()=>
    console.log "DELETE ITEM";
    console.log data;

  getModel_by_model_id: ( @selectedID )->
    for k, m of FileSystem._objects
      if parseInt(m.model_id) == parseInt(@selectedID)
        return m

  send_share:()=>
    user = document.getElementById('modal-share-target').value;
    file = document.getElementById('modal-share-file').value;
    flag = mnm.flag;
    data = mnm.getModel_by_model_id mnm.selected_data
    error = document.getElementById('modal-share-error');
    error.innerHTML = "";
    _error = "Error ";
    found_error = false;
    if user == ""
      if found_error == false
        found_error = true;
      _error += "invalid target username"
    if file == ""
      if found_error == false
        found_error = true;
      else
        _error += ", "
      _error += "invalid filename"
    if flag == 0
      if found_error == false
        found_error = true;
      else
        _error += ", "
      _error += "add Right Types to give"

    if found_error == true
      error.innerHTML = _error + '.';
      return;

    spinalCore.share_model(conn, data, file, flag, user);
    $('#modal-share').modal('hide');
