#!/bin/bash
# =============================================================================
# Informations
# =============================================================================
# Created By : Luca Gasperini <dev@xsoftware.it>
# Created At : 2019/07/23
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
: 'SVG to XML script'
# =============================================================================

SVG_DIR="${1}"

for svg in ${SVG_DIR}/*.svg
do
        read -r line < ${svg}
        if [[ $line == "<?xml "* ]]; then
                echo "${svg} is a xml file!"
        else
                output=$(basename -- "${svg}")
                output="${output%.*}"
                output="${1}${output}.xml.svg"
                echo '<?xml version="1.0" encoding="utf-8"?>' > "${output}"
                cat "${svg}" >> "${output}"
                echo "${svg} => ${output}"
        fi
done