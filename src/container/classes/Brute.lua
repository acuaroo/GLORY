--|| VARS ||--
local class = {}

--|| MAIN ||--
class.ClassData = {
    Health = 100,
    Speed = 10,
    Jump = 50,

    Attack1 = {
        Damage = 40,
        Stun = 0,
        Knockback = 1,
        Cooldown = 0.1,
        Part = "Right Arm",
        AnimWait = 0.1
    },
    Attack2 = {
        Damage = 60,
        Stun = 0,
        Knockback = 0,
        Cooldown = 0.1,
        Part = "Left Arm",
        AnimWait = 0.1
    },
    Attack3 = {
        Damage = 5,
        Stun = 3,
        Knockback = 0,
        Cooldown = 2,
        AnimWait = 0.1
    },

    Animations = {
        Walking = "",
        Idle = "rbxassetid://7328094035",
        Ready = "",
        Attack1 = "rbxassetid://7328126624",
        Attack2 = "rbxassetid://7351659023",
        Attack3 = ""
    },

    Character = "BruteCharacter"
}

--|| EXPORTING ||--
return class