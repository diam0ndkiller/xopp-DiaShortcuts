function initUi()
  app.registerUi({["menu"] = "Set pen", ["callback"] = "pen", ["accelerator"] = "<Control>F13"});
  app.registerUi({["menu"] = "Set black pen", ["callback"] = "pen_black", ["accelerator"] = "<Control>F14"});
  app.registerUi({["menu"] = "Set blue pen", ["callback"] = "pen_blue", ["accelerator"] = "<Control>F15"});
  app.registerUi({["menu"] = "Set red pen", ["callback"] = "pen_red", ["accelerator"] = "<Control>F16"});
  app.registerUi({["menu"] = "Set highlighter", ["callback"] = "highlighter", ["accelerator"] = "<Control>F17"});
  app.registerUi({["menu"] = "Set yellow highlighter", ["callback"] = "hl_yellow", ["accelerator"] = "<Control>F18"});
  app.registerUi({["menu"] = "Set magenta highlighter", ["callback"] = "hl_pink", ["accelerator"] = "<Control>F19"});
  app.registerUi({["menu"] = "Set cyan highlighter", ["callback"] = "hl_cyan", ["accelerator"] = "<Control>F20"});
  app.registerUi({["menu"] = "Set draw line", ["callback"] = "line", ["accelerator"] = "<Control>F21"});
  app.registerUi({["menu"] = "Set eraser", ["callback"] = "eraser", ["accelerator"] = "<Control>F22"});
end

local colorList = {
  {"black", 0x000000},
  {"green", 0x008000},
  {"lightblue", 0x00c0ff},
  {"lightgreen", 0x00ff00},
  {"blue", 0x3333cc},
  {"gray", 0x808080},
  {"red", 0xff0000},
  {"magenta", 0xff00ff},
  {"orange", 0xff8000},
  {"yellow", 0xffff00},
  {"white", 0xffffff}
}

function pen_black()
  pen()
  color(0x000000)
end

function pen_blue()
  pen()
  color(0x3333cc)
end

function pen_red()
  pen()
  color(0xff0000)
end

function hl_yellow()
  highlighter()
  if (hl) then color(0xffff00) end
end

function hl_cyan()
  highlighter()
  if (hl) then color(0x00c0ff) end
end

function hl_pink()
  highlighter()
  if (hl) then color(0xff00ff) end
end


function color(c)
  app.changeToolColor({["color"] = c, ["selection"] = true})
end

function action(a)
  app.uiAction({["action"] = "ACTION_" .. a})
end

function disable_action(a)
  app.uiAction({["action"] = "ACTION_" .. a, ["enabled"] = false})
end

function tool(t)
  action("TOOL_" .. t)
end

function disable_tool(t)
  disable_action("TOOL_" .. t)
end

function eraser()
  tool("ERASER_DELETE_STROKE")
end

local hl = false

function highlighter()
  hl = not hl
  if (hl) then
    tool("HIGHLIGHTER")
  else
    pen()
  end
end

function pen()
  tool("PEN")
end

local ruler = false

function line()
  ruler = not ruler
  if (ruler) then
    action("RULER")
  else
    disable_action("RULER")
  end
end
