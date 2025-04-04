function SmartPrint()
	local word = vim.fn.expand("<cword>")
	local ft = vim.bo.filetype
	local output = ""

	if ft == "cpp" or ft == "c++" then
		output = "std::cout << " .. word .. " << std::endl;"
	elseif ft == "c" then
		output = 'printf("%s\\n", ' .. word .. ');'
	elseif ft == "python" then
		output = "print(" .. word .. ")"
	elseif ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
		output = "console.log(" .. word .. ");"
	elseif ft == "java" then
		output = "System.out.println(" .. word .. ");"
	elseif ft == "lua" then
		output = "print(" .. word .. ")"
	elseif ft == "php" then
		output = "echo " .. word .. ";"
	elseif ft == "go" then
		output = 'fmt.Println(' .. word .. ')'
	elseif ft == "rust" then
		output = 'println!("{:?}", ' .. word .. ');'
	else
		output = "print(" .. word .. ")"   -- Default fallback
	end

	vim.api.nvim_put({ output }, "l", true, true)
end

-- Smart print statement insertion based on file type
vim.keymap.set("n", "<leader>oo", SmartPrint)

