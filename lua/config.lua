local vim = require('vim')
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local g = vim.g

--- colors/highlight
o.termguicolors = true
o.syntax = 'on'

--- automatic indentation
bo.autoindent = true
bo.smartindent = true

--- tab settings
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

--- line number
wo.number = true
wo.relativenumber = false

--- search settings
o.ignorecase = true
o.smartcase = true

-- input
g.mapleader = ' '
