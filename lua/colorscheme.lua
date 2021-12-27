local notify = vim.notify

local status_ok, p = pcall(require, 'nightfox')
if not status_ok then
  notify('Package nightfox not found!')
  return
end

p.load('nordfox')

