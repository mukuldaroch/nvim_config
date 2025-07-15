for getting the treesitter parser name of the code block on cursor
```lua
echo synIDattr(synID(line('.'), col('.'), 1), 'name')
```

