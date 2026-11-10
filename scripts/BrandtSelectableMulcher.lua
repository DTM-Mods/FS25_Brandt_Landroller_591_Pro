-- PropaineX: passive rolling mulcher selected by the native roller configuration.
BrandtSelectableMulcher = {}

local function isMulcher(self)
    return self.configurations.roller == 3
end

function BrandtSelectableMulcher.prerequisitesPresent(specializations)
    return SpecializationUtil.hasSpecialization(Roller, specializations)
       and SpecializationUtil.hasSpecialization(WorkArea, specializations)
end

-- Native color configurations supply the palette and save/multiplayer handling.
-- Paint only original frame materialId3 (zero-based slot1); retain its finish/maps.
function BrandtSelectableMulcher.registerEventListeners(vehicleType)
    SpecializationUtil.registerEventListener(vehicleType, "onPostLoad", BrandtSelectableMulcher)
end

function BrandtSelectableMulcher:onPostLoad(savegame)
    local material = VehicleConfigurationItemColor.getMaterialByColorConfiguration(self, "baseColor")
    local mapping = self.i3dMappings.landRoller591A_vis
    local node = type(mapping) == "table" and mapping.nodeId or mapping
    if material ~= nil and node ~= nil then
        material:applyToMaterial(node, 1, true)
    end
end

function BrandtSelectableMulcher.registerFunctions(vehicleType)
    SpecializationUtil.registerFunction(vehicleType, "processBrandtMulcherArea", BrandtSelectableMulcher.processBrandtMulcherArea)
end

function BrandtSelectableMulcher.registerOverwrittenFunctions(vehicleType)
    SpecializationUtil.registerOverwrittenFunction(vehicleType, "loadWorkAreaFromXML", BrandtSelectableMulcher.loadWorkAreaFromXML)
    SpecializationUtil.registerOverwrittenFunction(vehicleType, "updateRollerAIRequirements", BrandtSelectableMulcher.updateRollerAIRequirements)
    SpecializationUtil.registerOverwrittenFunction(vehicleType, "getIsWorkAreaActive", BrandtSelectableMulcher.getIsWorkAreaActive)
end

function BrandtSelectableMulcher:loadWorkAreaFromXML(superFunc, workArea, xmlFile, key)
    local loaded = superFunc(self, workArea, xmlFile, key)
    if loaded and isMulcher(self) and workArea.type == WorkAreaType.ROLLER then
        workArea.type = WorkAreaType.MULCHER
        workArea.functionName = "processBrandtMulcherArea"
        workArea.processingFunction = self.processBrandtMulcherArea
    end
    return loaded
end

function BrandtSelectableMulcher:getIsWorkAreaActive(superFunc, workArea)
    if isMulcher(self) and workArea.type == WorkAreaType.MULCHER then
        local spec = self.spec_roller
        if spec.startActivationTime > g_currentMission.time then
            return false
        end
    end
    -- Native ground contact, lowered and folding checks remain in the chain.
    return superFunc(self, workArea)
end

function BrandtSelectableMulcher:processBrandtMulcherArea(workArea, dt)
    local xs, _, zs = getWorldTranslation(workArea.start)
    local xw, _, zw = getWorldTranslation(workArea.width)
    local xh, _, zh = getWorldTranslation(workArea.height)
    FSDensityMapUtil.eraseTireTrack(xs, zs, xw, zw, xh, zh)
    if not self.isServer and self.currentUpdateDistance > Mulcher.CLIENT_DM_UPDATE_RADIUS then
        return 0, 0
    end
    -- Same density-map operation used by the native passive mulcherRoll type.
    local workedArea, totalArea = FSDensityMapUtil.updateMulcherArea(xs, zs, xw, zw, xh, zh)
    self.spec_roller.isWorking = self:getLastSpeed() > 0.5
    return workedArea, totalArea
end

function BrandtSelectableMulcher:updateRollerAIRequirements(superFunc)
    if not isMulcher(self) then
        return superFunc(self)
    end
    if self.clearAITerrainDetailRequiredRange == nil then
        return
    end
    self:clearAIFruitRequirements()
    self:clearAIFruitProhibitions()
    self:clearAITerrainDetailRequiredRange()
    self:addAIGroundTypeRequirements(Mulcher.AI_REQUIRED_GROUND_TYPES)
    for _, fruitType in ipairs(g_fruitTypeManager:getFruitTypes()) do
        if fruitType.isCultivationAllowed then
            local maxState = 15
            if fruitType.mulchedState > fruitType.cutState then
                maxState = fruitType.mulchedState - 1
            end
            self:addAIFruitRequirement(fruitType.index, 2, maxState)
        end
    end
    local weedSystem = g_currentMission.weedSystem
    if weedSystem ~= nil then
        local replacementData = weedSystem:getMulcherReplacements()
        for _, data in ipairs(replacementData.custom or {}) do
            if data.fruitType.terrainDataPlaneId ~= nil then
                for state, _ in pairs(data.replacements) do
                    self:addAIFruitRequirement(data.fruitType.index, state, state)
                end
            end
        end
    end
end
