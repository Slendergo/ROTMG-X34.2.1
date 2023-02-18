namespace SGB.GameServer.Core.Game
{
    public sealed class ConditionEffect
    {
        public static byte NOTHING = 0;
        public static byte DEAD = 1;
        public static byte QUIET = 2;
        public static byte WEAK = 3;
        public static byte SLOWED = 4;
        public static byte SICK = 5;
        public static byte DAZED = 6;
        public static byte STUNNED = 7;
        public static byte BLIND = 8;
        public static byte HALLUCINATING = 9;
        public static byte DRUNK = 10;
        public static byte CONFUSED = 11;
        public static byte STUN_IMMUNE = 12;
        public static byte INVISIBLE = 13;
        public static byte PARALYZED = 14;
        public static byte SPEEDY = 15;
        public static byte BLEEDING = 16;
        public static byte ARMORBROKENIMMUNE = 17;
        public static byte HEALING = 18;
        public static byte DAMAGING = 19;
        public static byte BERSERK = 20;
        public static byte PAUSED = 21;
        public static byte STASIS = 22;
        public static byte STASIS_IMMUNE = 23;
        public static byte INVINCIBLE = 24;
        public static byte INVULNERABLE = 25;
        public static byte ARMORED = 26;
        public static byte ARMORBROKEN = 27;
        public static byte HEXED = 28;
        public static byte NINJA_SPEEDY = 29;
        public static byte UNSTABLE = 30;
        public static byte DARKNESS = 31;
        public static byte SLOWED_IMMUNE = 32;
        public static byte DAZED_IMMUNE = 33;
        public static byte PARALYZED_IMMUNE = 34;
        public static byte PETRIFIED = 35;
        public static byte PETRIFIED_IMMUNE = 36;
        public static byte PET_EFFECT_ICON = 37;
        public static byte CURSE = 38;
        public static byte CURSE_IMMUNE = 39;
        public static byte HP_BOOST = 40;
        public static byte MP_BOOST = 41;
        public static byte ATT_BOOST = 42;
        public static byte DEF_BOOST = 43;
        public static byte SPD_BOOST = 44;
        public static byte VIT_BOOST = 45;
        public static byte WIS_BOOST = 46;
        public static byte DEX_BOOST = 47;
        public static byte SILENCED = 48;
        public static byte EXPOSED = 49;
        public static byte ENERGIZED = 50;
        public static byte HP_DEBUFF = 51;
        public static byte MP_DEBUFF = 52;
        public static byte ATT_DEBUFF = 53;
        public static byte DEF_DEBUFF = 54;
        public static byte SPD_DEBUFF = 55;
        public static byte VIT_DEBUFF = 56;
        public static byte WIS_DEBUFF = 57;
        public static byte DEX_DEBUFF = 58;
        public static byte INSPIRED = 59;
        public static byte GROUND_DAMAGE = 99;

        public static byte CE_FIRST_BATCH = 0;
        public static byte CE_SECOND_BATCH = 1;

        public static byte NUMBER_CE_BATCHES = 2;
        public static byte NEW_CON_THREASHOLD = 32;

        public static byte GetCondEffectFromName(string name)
        {
            switch (name)
            {
                case "":
                    break;
            }
            System.Console.WriteLine($"Unknown ConditionEffect: {name}");
            return NOTHING;
        }
    }
}
