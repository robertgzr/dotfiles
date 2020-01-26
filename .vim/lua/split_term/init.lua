local spt = {}

function spt:create()
    self = {
        height = 80,
        buf_nr = nil,
        win_id = nil,
        visible = false,
    }
end

function spt:show()
    vim.eval('botright new')
    if self.buf_nr then
        vim.eval('buffer ' .. self.buf_nr)
    else
        vim.termopen(self.exec, { detach=0 })
        self.buf_nr = vim.bufnr('%')
    end
end

function spt:open()
end

function spt:hide()
end

function spt:close()
    local force = true
    vim.api.nvim_win_close(self.win_id, force)
    self.buf_nr = nil
    self.win_id = nil
end

function spt_toggle()
    if spt.win_id then
        if spt.visible then
            spt:hide()
        else
            spt:show()
        end
    else
        spt:create()
        spt:show()
    end
end
