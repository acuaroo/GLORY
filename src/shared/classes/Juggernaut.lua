--|| VARS ||--
local class = {}

--|| MAIN ||--
class.ClassData = {
    Health = 100,
    Speed = 16,
    Jump = 50,

    Attack1 = {
        Damage = 50,
        Stun = 0,
        Knockback = 0,
        CastLocation = "Left Arm",
        CastLocation2 = "Right Arm"
    },
    Attack2 = {
        Damage = 50,
        Stun = 0,
        Knockback = 0
    },
    Attack3 = {
        Damage = 50,
        Stun = 0,
        Knockback = 0
    },

    Animations = {
        Walking = "",
        Idle = "",
        Ready = "",
        Attack1 = "",
        Attack2 = "",
        Attack3 = ""
    },

    Character = "JuggernautCharacter"
}

--|| EXPORTING ||--
return class