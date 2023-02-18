using SGB.Shared.Database;
using StackExchange.Redis;
using System;

namespace SGB.API.Database.Models
{
    public sealed class CharacterModel : RedisObject
    {
        private const string CHARACTER_OBJECT_TYPE = "objectType";
        private const string CHARACTER_LEVEL = "level";
        private const string CHARACTER_EXPERIENCE = "experience";
        private const string CHARACTER_EQUIPMENT = "equipment";
        private const string CHARACTER_MAX_HITPOINTS = "maxHitpoints";
        private const string CHARACTER_HITPOINTS = "hitpoints";
        private const string CHARACTER_MAX_MAGICPOINTS = "maxMagicPoints";
        private const string CHARACTER_MAGIC_POINTS = "magicpoints";
        private const string CHARACTER_ATTACK = "attack";
        private const string CHARACTER_DEFENSE = "defense";
        private const string CHARACTER_SPEED = "speed";
        private const string CHARACTER_DEXTERITY = "dexterity";
        private const string CHARACTER_VITALITY = "vitality";
        private const string CHARACTER_WISDOM = "wisdom";
        private const string CHARACTER_TEXTURE = "texture";
        private const string CHARACTER_TEXTURE1 = "texture1";
        private const string CHARACTER_TEXTURE2 = "texture2";
        private const string CHARACTER_CURRENT_FAME = "fame";
        private const string CHARACTER_HAS_BACKPACK = "hasBackPack";
        private const string CHARACTER_CREATION_DATE = "creationDate";
        private const string CHARACTER_PET_ID = "petId";

        public int CharacterId { get; }
        public int ObjectType 
        {
            get => GetValue<int>(CHARACTER_OBJECT_TYPE);
            set => SetValue(CHARACTER_OBJECT_TYPE, value);
        }
        public int Level
        {
            get => GetValue<int>(CHARACTER_LEVEL);
            set => SetValue(CHARACTER_LEVEL, value);
        }
        public int Experience
        {
            get => GetValue<int>(CHARACTER_EXPERIENCE);
            set => SetValue(CHARACTER_EXPERIENCE, value);
        }
        public int[] Equipment
        {
            get => GetValue<int[]>(CHARACTER_EQUIPMENT);
            set => SetValue(CHARACTER_EQUIPMENT, value);
        }
        public int MaxHitPoints 
        {
            get => GetValue<int>(CHARACTER_MAX_HITPOINTS);
            set => SetValue(CHARACTER_MAX_HITPOINTS, value);
        }
        public int HitPoints
        {
            get => GetValue<int>(CHARACTER_HITPOINTS);
            set => SetValue(CHARACTER_HITPOINTS, value);
        }
        public int MaxMagicPoints
        {
            get => GetValue<int>(CHARACTER_MAX_MAGICPOINTS);
            set => SetValue(CHARACTER_MAX_MAGICPOINTS, value);
        }
        public int MagicPoints
        {
            get => GetValue<int>(CHARACTER_MAGIC_POINTS);
            set => SetValue(CHARACTER_MAGIC_POINTS, value);
        }
        public int Attack 
        {
            get => GetValue<int>(CHARACTER_ATTACK);
            set => SetValue(CHARACTER_ATTACK, value);
        }
        public int Defense 
        {
            get => GetValue<int>(CHARACTER_DEFENSE);
            set => SetValue(CHARACTER_DEFENSE, value);
        }
        public int Speed 
        {
            get => GetValue<int>(CHARACTER_SPEED);
            set => SetValue(CHARACTER_SPEED, value);
        }
        public int Dexterity 
        {
            get => GetValue<int>(CHARACTER_DEXTERITY);
            set => SetValue(CHARACTER_DEXTERITY, value);
        }
        public int HpRegen 
        {
            get => GetValue<int>(CHARACTER_VITALITY);
            set => SetValue(CHARACTER_VITALITY, value);
        }
        public int MpRegen 
        {
            get => GetValue<int>(CHARACTER_WISDOM);
            set => SetValue(CHARACTER_WISDOM, value);
        }
        public int Texture 
        {
            get => GetValue<int>(CHARACTER_TEXTURE);
            set => SetValue(CHARACTER_TEXTURE, value);
        }
        public int Tex1 
        {
            get => GetValue<int>(CHARACTER_TEXTURE1);
            set => SetValue(CHARACTER_TEXTURE1, value);
        }
        public int Tex2 
        {
            get => GetValue<int>(CHARACTER_TEXTURE2);
            set => SetValue(CHARACTER_TEXTURE2, value);
        }
        public int CurrentFame 
        {
            get => GetValue<int>(CHARACTER_CURRENT_FAME);
            set => SetValue(CHARACTER_CURRENT_FAME, value);
        }
        public bool HasBackpack 
        {
            get => GetValue<bool>(CHARACTER_HAS_BACKPACK);
            set => SetValue(CHARACTER_HAS_BACKPACK, value);
        }
        public DateTime CreationDate 
        {
            get => GetValue<DateTime>(CHARACTER_CREATION_DATE);
            set => SetValue(CHARACTER_CREATION_DATE, value);
        }
        public int PetId
        {
            get => GetValue<int>(CHARACTER_PET_ID);
            set => SetValue(CHARACTER_PET_ID, value);
        }

        public CharacterModel(int accountId, int characterId, IDatabase database)
            : base($"account.{accountId}.character.{characterId}", database)
        {
            CharacterId = characterId;
        }
    }
}