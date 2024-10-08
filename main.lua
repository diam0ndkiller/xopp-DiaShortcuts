function initUi()
  app.registerUi({["menu"] = "Set pen", ["callback"] = "pen", ["accelerator"] = "<Control>F13"});
  app.registerUi({["menu"] = "Set black pen", ["callback"] = "pen_black", ["accelerator"] = "<Control>F14"});
  app.registerUi({["menu"] = "Set blue pen", ["callback"] = "pen_blue", ["accelerator"] = "<Control>F15"});
  app.registerUi({["menu"] = "Set red pen", ["callback"] = "pen_red", ["accelerator"] = "<Control>F16"});
  app.registerUi({["menu"] = "Toggle highlighter", ["callback"] = "hl_toggle", ["accelerator"] = "<Control>F17"});
  app.registerUi({["menu"] = "Toggle yellow highlighter", ["callback"] = "hl_yellow", ["accelerator"] = "<Control>F18"});
  app.registerUi({["menu"] = "Toggle magenta highlighter", ["callback"] = "hl_magenta", ["accelerator"] = "<Control>F19"});
  app.registerUi({["menu"] = "Toggle light blue highlighter", ["callback"] = "hl_lightblue", ["accelerator"] = "<Control>F20"});
  app.registerUi({["menu"] = "Toggle ruler (draw line)", ["callback"] = "ruler", ["accelerator"] = "<Control>F21"});
  app.registerUi({["menu"] = "Toggle eraser", ["callback"] = "er_toggle", ["accelerator"] = "<Control>F22"});
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

hl = false
er = false
current_color = 0x000000

function pen_black()
  pen()
  color(0x000000)
  er = false
  hl = false
end

function pen_blue()
  pen()
  color(0x3333cc)
  er = false
  hl = false
end

function pen_red()
  pen()
  color(0xff0000)
  er = false
  hl = false
end

function hl_toggle()
  if (hl) then
    pen()
    hl = false
  else
    highlighter()
    hl = true
    er = false
  end
end

function hl_yellow()
  if (current_color == 0xffff00 and hl) then
    pen()
    hl = false
  else
    highlighter()
    color(0xffff00)
    current_color = 0xffff00
    hl = true
    er = false
  end
end

function hl_lightblue()
  if (current_color == 0x00c0ff and hl) then
    pen()
    hl = false
  else
    highlighter()
    color(0x00c0ff)
    current_color = 0x00c0ff
    hl = true
    er = false
  end
end

function hl_magenta()
  if (current_color == 0xff00ff and hl) then
    pen()
    hl = false
  else
    highlighter()
    color(0xff00ff)
    current_color = 0xff00ff
    hl = true
    er = false
  end
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
  tool("ERASER")
end

function er_toggle()
  if (er) then
    pen()
    er = false
  else
    eraser()
    er = true
    hl = false
  end
end

function highlighter()
  tool("HIGHLIGHTER")
end


function pen()
  tool("PEN")
end

local ruler_enabled = false

function ruler()
  ruler_enabled = not ruler_enabled
  if (ruler_enabled) then
    action("RULER")
  else
    disable_action("RULER")
  end
end
