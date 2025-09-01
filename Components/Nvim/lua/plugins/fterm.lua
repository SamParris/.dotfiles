return {
  {
    'numToStr/FTerm.nvim',
    config = function()
      local fterm = require('FTerm')
      vim.keymap.set('n', '<leader>tt', function() fterm:toggle() end, {desc = '[T]oggle [T]terminal'})
      vim.keymap.set('t', '<leader>tt', function() fterm:toggle() end, {desc = '[T]oggle [T]erminal'})
    end,
  },
  {
    'numToStr/FTerm.nvim',
    name = 'FTerm.LazyGit.nvim',
    config = function()
      local fterm = require('FTerm')
      local lazygit = fterm:new({
        cmd = 'lazygit',
      })

      vim.keymap.set('n', '<leader>lg', function() lazygit:toggle() end, {desc = 'Toggle [L]azy[G]it'})
      vim.keymap.set('t', '<leader>lg', function() lazygit:toggle() end, {desc = 'Toggle [L]azy[G]it'})
    end,
  },
  {
    'numToStr/FTerm.nvim',
    name = 'FTerm.k9s.nvim',
    config = function()
      local fterm = require('FTerm')
      local k9s = fterm:new({
        cmd = 'k9s',
      })

      vim.keymap.set('n', '<leader>tk', function() k9s:toggle() end, {desc = '[T]oggle [K]9s'})
      vim.keymap.set('t', '<leader>tk', function() k9s:toggle() end, {desc = '[T]oggle [K]9s'})
    end,
  }
}