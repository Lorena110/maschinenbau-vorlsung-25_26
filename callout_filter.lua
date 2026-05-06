function BlockQuote(el)
    -- Check if the blockquote starts with [!NOTE], [!TIP], or [!WARNING]
    if #el.content > 0 and el.content[1].t == "Para" then
        local first_para = el.content[1]
        if #first_para.content > 0 and first_para.content[1].t == "Str" then
            local text = first_para.content[1].text
            if text:match("^%[!NOTE%]") then
                -- Remove the [!NOTE] from the first paragraph
                first_para.content[1].text = text:gsub("^%[!NOTE%]", "")
                -- Wrap the entire blockquote in a notebox
                return pandoc.RawBlock("latex", "\\begin{notebox}\n" .. pandoc.utils.stringify(el) .. "\n\\end{notebox}")
            elseif text:match("^%[!TIP%]") then
                first_para.content[1].text = text:gsub("^%[!TIP%]", "")
                return pandoc.RawBlock("latex", "\\begin{tipbox}\n" .. pandoc.utils.stringify(el) .. "\n\\end{tipbox}")
            elseif text:match("^%[!WARNING%]") then
                first_para.content[1].text = text:gsub("^%[!WARNING%]", "")
                return pandoc.RawBlock("latex", "\\begin{warningbox}\n" .. pandoc.utils.stringify(el) .. "\n\\end{warningbox}")
            end
        end
    end
    return el
end