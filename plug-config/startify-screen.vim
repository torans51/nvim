command SessionLoad SLoad
command SessionSave SSave
command SessionDelete SDelete
command SessionClose SClose

let g:startify_session_dir = '$HOME/.config/nvim/session'

let g:startify_custom_header = [
      \'',
      \'      ______                               ______   ___',
      \'     /_  __/___  _________ _____  _____   / ____/  <  /',
      \'      / / / __ \/ ___/ __ `/ __ \/ ___/  /___ \    / / ',
      \'     / / / /_/ / /  / /_/ / / / (__  )  ____/ /   / /  ',
      \'    /_/  \____/_/   \__,_/_/ /_/____/  /_____/   /_/   ',
      \'',
      \]

let g:startify_lists = [
      \ { 'type': 'files', 'header': ['Files'] },
      \ { 'type': 'dir', 'header': ['Folders'] },
      \ { 'type': 'sessions', 'header': ['Sessions'] },
      \]
