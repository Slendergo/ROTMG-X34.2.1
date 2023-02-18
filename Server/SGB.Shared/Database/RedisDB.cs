using SGB.Shared.Database.Models;
using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Text.Json;

namespace SGB.Shared.Database
{
    public static class RedisDB
    {
        public static ConnectionMultiplexer ConnectionMultiplexer { get; private set; }
        public static IDatabase Database { get; private set; }

        public static bool Configure(string connectionString, int databaseIndex)
        {
            try
            {
                ConnectionMultiplexer = ConnectionMultiplexer.Connect(connectionString, options =>
                {
                    // incase options are needed
                    //options.Password = "password";
                });

                Database = ConnectionMultiplexer.GetDatabase(databaseIndex);
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }

        public static int IsValidLogin(string guid, string password)
        {
            var guidLow = guid.ToLower();
            if (!Database.HashExists("logins", guidLow))
                return LoginModel.LOGIN_MODEL_FAILURE;
            var json = Database.HashGet("logins", guidLow);
            var login = JsonSerializer.Deserialize<LoginModel>(json);
            return login.Hash == Hashing.GetHashedPassword(password) ? login.AccountId : LoginModel.LOGIN_MODEL_FAILURE;
        }

        public static AccountModel GetAccountModel(int accountId)
        {
            if (Database.KeyExists($"account.{accountId}"))
                return new AccountModel(accountId, Database);
            return null;
        }

        public static IEnumerable<int> GetAliveCharacters(int accountId)
        {
            foreach (var i in Database.SetMembers($"account.{accountId}.alive_characters"))
                yield return Convert.ToInt32(i);
        }

        public static CharacterModel LoadCharacter(int accountId, int characterId)
        {
            if (Database.KeyExists($"account.{accountId}.character.{characterId}"))
                return new CharacterModel(accountId, characterId, Database);
            return null;
        }

        public static IEnumerable<CharacterModel> LoadCharacters(int accountId)
        {
            var aliveCharacters = GetAliveCharacters(accountId);
            foreach (var characterId in aliveCharacters)
                yield return new CharacterModel(accountId, characterId, Database);
        }

        public static CharacterModel CreateNewCharacter(AccountModel accountModel)
        {
            var aliveKey = $"account.{accountModel.AccountId}.alive_characters";

            var nextCharacterId = (int)Database.HashIncrement(accountModel.Key, "nextCharacterId");
            if (Database.SetLength(aliveKey) >= accountModel.MaxCharacterSlots)
                return null;

            var characterModel = new CharacterModel(accountModel.AccountId, nextCharacterId, Database);

            var classType = 0x030e;
            var classXMLObject = new ClassXMLObject();

            characterModel.ObjectType = classType;
            characterModel.MaxHitPoints = classXMLObject.MaxHitPoints;
            characterModel.HitPoints = classXMLObject.HitPoints;
            characterModel.MaxMagicPoints = classXMLObject.MaxMagicPoints;
            characterModel.MagicPoints = classXMLObject.MagicPoints;
            characterModel.Attack = classXMLObject.Attack;
            characterModel.Defense = classXMLObject.Defense;
            characterModel.Speed = classXMLObject.Speed;
            characterModel.Dexterity = classXMLObject.Dexterity;
            characterModel.HpRegen = classXMLObject.Vitality;
            characterModel.MpRegen = classXMLObject.Wisdom;
            characterModel.Experience = 0;
            characterModel.Level = 1;
            characterModel.Texture = 0;
            characterModel.Tex1 = 0;
            characterModel.Tex2 = 0;
            characterModel.Equipment = ArrayUtils.FromCommaSepString32(classXMLObject.Equipment);
            characterModel.HasBackpack = false;
            characterModel.PetId = 0;
            characterModel.HealthPotionStack = 0;
            characterModel.MagicPotionStack = 0;
            characterModel.PetId = -1;

            _ = characterModel.UpdateAsync();

            _ = Database.SetAdd(aliveKey, nextCharacterId);

            return characterModel;
        }
    }
    class ClassXMLObject
    {
        public int MaxHitPoints;
        public int HitPoints;
        public int MaxMagicPoints;
        public int MagicPoints;
        public int Attack;
        public int Defense;
        public int Speed;
        public int Wisdom;
        public int Dexterity;
        public int Vitality;
        public string Equipment;
        public int HealthPotionStack;
        public int MagicPotionStack;
    }
}
