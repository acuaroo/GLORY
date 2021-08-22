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

    Character = "BruteCharacter"
}

--|| EXPORTING ||--
return class