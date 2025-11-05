-- Add readyCheck function to trigger ready check

local function readyCheckCommand()
	DoReadyCheck()
end

SLASH_READY_CHECK1 = "/rc"
SlashCmdList["READY_CHECK"] = readyCheckCommand

local function roleCheckCommand()
	InitiateRolePoll()
end

SLASH_ROLE_CHECK1 = "/rc+"
SlashCmdList["ROLE_CHECK"] = roleCheckCommand

local function quitPartyCommand()
	if IsInGroup() then
		LeaveParty()
	end
end

SLASH_QUIT_PARTY1 = "/q"
SlashCmdList["QUIT_PARTY"] = quitPartyCommand

local function markPartyMembersCommand()
	if not IsInGroup() then
		print("You are not in a group.")
		return
	end

	for partyIndex = 1, GetNumGroupMembers() do
		local unitId = "party" .. partyIndex
		if UnitExists(unitId) then
			local assignedRole = UnitGroupRolesAssigned(unitId)
			if assignedRole == "TANK" then
				SetRaidTarget(unitId, 6)
			elseif assignedRole == "HEALER" then
				SetRaidTarget(unitId, 1)
			end
		end
	end
end

SLASH_MARK_PARTY1 = "/mp"
SlashCmdList["MARK_PARTY"] = markPartyMembersCommand
