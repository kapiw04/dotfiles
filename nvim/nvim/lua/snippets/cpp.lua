local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Helper function to get filename for header guards
local function get_filename_part()
  local fname = vim.fn.expand("%:t") -- Get filename with extension
  fname = fname:gsub("%.", "_")   -- Replace dots with underscores
  fname = fname:upper()          -- Convert to uppercase
  return fname
end


ls.add_snippets("cpp", {
  -- Header Guard
  s("hguard", fmt(
    [[
#ifndef {guard}_H
#define {guard}_H

{body}

#endif // {guard}_H
]],
    {
      guard = f(get_filename_part, {}), -- Dynamically generate guard name
      body = i(0), -- Placeholder for cursor position
    }
  )),

  -- Basic main function
  s("main", fmt(
    [[
#include <iostream>

int main(int argc, char* argv[]) {{
  {cursor}
  return 0;
}}
]],
    { cursor = i(0) }
  )),

  -- Simple class
  s("class", fmt(
    [[
class {name} {{
public:
  {name}({args});
  ~{name}();

private:
  {private_members}
}};
]],
    {
      name = i(1, "MyClass"),
      args = i(2),
      private_members = i(0),
    }
  )),

  -- Namespace
  s("ns", fmt(
    [[
namespace {name} {{

{body}

}} // namespace {name}
]],
    { name = i(1, "MyNamespace"), body = i(0) }
  )),

  -- For loop
  s("fori", fmt(
    [[
for (int {var} = 0; {var} < {limit}; ++{var}) {{
  {body}
}}
]],
    { var = i(1, "i"), limit = i(2, "N"), body = i(0) }
  )),

  -- Range-based for loop
  s("forr", fmt(
    [[
for (const auto& {var} : {container}) {{
  {body}
}}
]],
    { var = i(1, "item"), container = i(2, "collection"), body = i(0) }
  )),

    -- Range-based for loop (mutable)
  s("forrm", fmt(
    [[
for (auto& {var} : {container}) {{
  {body}
}}
]],
    { var = i(1, "item"), container = i(2, "collection"), body = i(0) }
  )),

  -- std::cout
  s("cout", fmt([[std::cout << {content} << std::endl;]], { content = i(1, "\"Hello\"") })),

  -- std::vector include and usage
  s("vec", fmt(
    [[
#include <vector>

std::vector<{type}> {name};
{cursor}
]],
    { type = i(1, "int"), name = i(2, "myVector"), cursor = i(0) }
  )),

  -- Smart Pointers
  s("uptr", fmt([[std::unique_ptr<{type}> {name} = std::make_unique<{type}>({args});]],
    { type = i(1, "MyType"), name = i(2, "ptr"), args = i(0) }
  )),
  s("sptr", fmt([[std::shared_ptr<{type}> {name} = std::make_shared<{type}>({args});]],
    { type = i(1, "MyType"), name = i(2, "ptr"), args = i(0) }
  )),

  -- Doxygen comment block for functions
  s("docf", fmt(
  [[
/**
 * @brief {brief_description}
 *
 * {detailed_description}
 *
 * @param {param_name} {param_description}
 * @return {return_description}
 */
]],
    {
      brief_description = i(1, "Brief description"),
      detailed_description = i(2, "Detailed description"),
      param_name = i(3, "param"),
      param_description = i(4, "Parameter description"),
      return_description = i(5, "Return description"),
    }
  )),

})

-- Add similar snippets for C (maybe in a separate file or using filetype checks)
ls.add_snippets("c", {
  s("main", fmt(
    [[
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {{
  {cursor}
  return EXIT_SUCCESS;
}}
]],
    { cursor = i(0) }
  )),
  -- Add C specific snippets (e.g., for struct, printf, malloc/free)
})
