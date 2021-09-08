--|| VARS ||--
local class = {}

--|| MAIN ||--
class.ClassData = {
    Health = 75,
    Speed = 9,
    Jump = 0,
    Guard = 0,

    Attacks = {
        ["Attack1"] = {
            Damage = 15,
            Cooldown = 1,
            RaycastPart = "Right Arm",
            Properties = {Stun = 0, Knockback = 0.1}
        },
        ["Attack2"] = {
            Damage = 15,
            Cooldown = 1,
            RaycastPart = "Left Arm",
            Properties = {Stun = 0, Knockback = 0.1}
        },
        ["Attack3"] = {
            Damage = 5,
            Cooldown = 5,
            Properties = {Stun = 3, Knockback = 0}
        },
    },

    Animations = {
        Walking = "rbxassetid://7421276176",
        Idle = "rbxassetid://",
        Attack1 = "rbxassetid://7421200589",
        Attack2 = "rbxassetid://7421278831",
        Attack3 = "rbxassetid://"
    },

    Character = "BruteCharacter"
}

--|| EXPORTING ||--
return class