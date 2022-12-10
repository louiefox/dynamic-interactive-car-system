DICS.WHEEL = {
    FL = 0, -- Front Left
    FR = 1, -- Front Right
    RL = 2, -- Rear Left
    RR = 3 -- Rear Right
}

local WHEEL = DICS.WHEEL

DICS.VEHICLECFG = {
    ["17raptor_cop_sgm"] = {
        Wheel = {
            Bones = {
                [WHEEL.FL] = "fl_wheel",
                [WHEEL.FR] = "fr_wheel",
                [WHEEL.RL] = "bl_wheel",
                [WHEEL.RR] = "br_wheel"
            }
        }
    },
    ["Jeep"] = {
        Wheel = {
            Bones = {
                [WHEEL.FL] = "Rig_Buggy.Wheel_FL_Rotate",
                [WHEEL.FR] = "Rig_Buggy.Wheel_FR_Rotate",
                [WHEEL.RL] = "Rig_Buggy.Wheel_RL",
                [WHEEL.RR] = "Rig_Buggy.Wheel_RR"
            }
        }
    }
}