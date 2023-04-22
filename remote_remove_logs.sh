#!/usr/bin/bash
# =============================================================================
# Informations
# =============================================================================
# Created By : Luca Gasperini <dev@xsoftware.it>
# Created At : 2023/04/22
# Project    : Simple Script
# Repository :
# Coding     : UTF-8
# =============================================================================
# License
# =============================================================================
: '
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
 
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
  
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
'
# =============================================================================
# Description
# =============================================================================
: 'Remove logs from server by ssh and download backup as tar bz2'
# =============================================================================

SSH_CONNECT="${1}"
REMOTE_LOG_DIR="/var/log"
current_date="$(date +"%Y-%M-%d")"
backup_file="/tmp/systemlogs_$current_date.tar.bz2"
echo -n SUDO Password:
read -s $sudo_password

ssh $SSH_CONNECT "echo "$sudo_password" | sudo -S -- find $REMOTE_LOG_DIR -name '*.gz' -print0 | tar -cvjf $backup_file  --null --files-from -"
scp $SSH_CONNECT:$backup_file .
ssh $SSH_CONNECT "echo "$sudo_password" | sudo -S -- find $REMOTE_LOG_DIR -name '*.gz' -exec rm '{}' \; && rm $backup_file"


