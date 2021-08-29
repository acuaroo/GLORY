--|| VARS ||--
local class = {}

--|| MAIN ||--
class.ClassData = {
    Health = 75,
    Speed = 14,
    Jump = 30,

    Attack1 = {
        Damage = 50,
        Stun = 0,
        Knockback = 0
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