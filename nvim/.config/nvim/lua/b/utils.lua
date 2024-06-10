local M = {}

function M.installed_via_bundler(gemname)
  local gemfile = vim.fn.getcwd() .. '/Gemfile.lock'

  if vim.fn.filereadable(gemfile) == 0 then
    return false
  end

  for line in io.lines(gemfile) do
    if string.find(line, gemname) then
      return true
    end
  end

  return false
end

function M.installed_gem_version(gemname)
  -- TODO: support version number for non-bundler gems, default bundler = true param

  local gemfile = M.gemfile()
  if not gemfile then
    return
  end

  local version = nil

  for line in io.lines(gemfile) do
    if string.find(line, '%s+' .. gemname .. ' %(') then
      -- version must be major.minor for number based version compare
      version = string.match(line, '%d+%.%d+')
      break
    end
  end

  return tonumber(version)
end

function M.gemfile()
  local gemfile = vim.fn.getcwd() .. '/Gemfile.lock'

  if vim.fn.filereadable(gemfile) == 0 then
    return
  end

  return gemfile
end

function M.rubocop_supports_lsp()
  local version = M.installed_gem_version 'rubocop'

  return version and version >= 1.53
end

function M.ruby_lsp_installed()
  local directory = vim.fn.getcwd() .. '/.ruby-lsp'

  return M.is_dir(directory)
end

function M.ruby_lsp_setup()
  local directory = vim.fn.getcwd() .. '/.ruby-lsp'

  return M.is_dir(directory)
end

function M.config_exists(filename)
  local file = vim.fn.getcwd() .. '/' .. filename

  return vim.fn.filereadable(file) == 1
end

function M.is_dir(filename)
  return M.exists(filename) == 'directory'
end

function M.exists(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type or false
end

return M
