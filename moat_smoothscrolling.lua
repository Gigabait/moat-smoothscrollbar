local sbar = DScrollPanel:GetVBar() -- replace DScrollPanel with your DScrollPanel name
sbar.LerpTarget = 0

function sbar:AddScroll(dlta)
    local OldScroll = self.LerpTarget or self:GetScroll()
    dlta = dlta * 75 -- initial scroll when wheeled
    self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())

    return OldScroll ~= self:GetScroll()
end

sbar.Think = function(s)
    local frac = FrameTime() * 5 -- speed with initial scroll

    if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize / 10)) then
        frac = FrameTime() * 2 -- speed when close to scroll point
    end

    local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
    s:SetScroll(math.Clamp(newpos, 0, s.CanvasSize))

    -- make sure the scroll doesn't go off the canvas
    if (s.LerpTarget < 0 and s:GetScroll() <= 0) then
        s.LerpTarget = 0
    elseif (s.LerpTarget > s.CanvasSize and s:GetScroll() >= s.CanvasSize) then
        s.LerpTarget = s.CanvasSize
    end
end