--|| VARS ||--
local class = {}

--|| MAIN ||--
class.ClassData = {
    Health = 100,
    Speed = 16,
    Jump = 50,

    Attack1 = {
        Damage = 40,
        Stun = 0,
        Knockback = 1,
        Cooldown = 0.1
    },
    Attack2 = {
        Damage = 60,
        Stun = 0,
        Knockback = 0,
        Cooldown = 0.1
    },
    Attack3 = {
        Damage = 5,
        Stun = 3,
        Knockback = 0,
        Cooldown = 5
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