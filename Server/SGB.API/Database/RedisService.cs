using SGB.API.Database.Models;
using SGB.Shared;
using SGB.Shared.Database;
using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace SGB.API.Database
{
    public static class RedisService
    {
        private static IDatabase Database;
        private static ConnectionMultiplexer ConnectionMultiplexer;

        private static readonly string EMAIL_REGEX = @"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$";

        public static void Configure(string connectionString, int dbIndex)
        {
            ConnectionMultiplexer = ConnectionMultiplexer.Connect(connectionString);
            Database = ConnectionMultiplexer.GetDatabase(dbIndex);
        }

        public static IDatabase GetDatabase() => Database;

        public static int IsValidLogin(string guid, string password)
        {
            using var t = new TimedProfiler("IsValidLogin");

            var guidLow = guid.ToLower();
            if (!Database.HashExists("logins", guidLow))
                return -1;
            var json = Database.HashGet("logins", guidLow);
            var login = JsonSerializer.Deserialize<LoginModel>(json);
            return login.Hash == Hashing.GetHashedPassword(password) ? login.AccountId : -1;
        }

        public static string Register(string guid, string password, string name)
        {
            using var t = new TimedProfiler("Register");

            if (string.IsNullOrEmpty(name) || name.Length > 10)
                return "Invalid Player Name";

            if(!Regex.Match(guid, EMAIL_REGEX).Success)
                return "WebRegister.invalid_email_address";

            if (password.Length < 5)
                return "WebRegister.password_too_short";

            // needs more checks?

            var accountId = GetNextAccountId();
            CreateLoginKey(accountId, guid, password);
            CreateAccountKey(accountId, name);
            return null;
        }

        private static void CreateLoginKey(int accountId, string guid, string password)
        {
            var login = new LoginModel()
            {
                AccountId = accountId,
                Hash = Hashing.GetHashedPassword(password),
                IsBanned = false
            };

            var hashSet = new HashEntry[1] 
            { 
                new HashEntry(guid.ToLower(), JsonSerializer.Serialize(login)) 
            };
            Database.HashSet("logins", hashSet);
        }

        private static void CreateAccountKey(int accountId, string name)
        {
            var accountKey = $"account.{accountId}";
            var hashSet = new HashEntry[10]
            {
                new HashEntry("nextCharId", 1),
                new HashEntry("maxCharacterSlots", 1),
                new HashEntry("name", name),
                new HashEntry("nameChosen", true),
                new HashEntry("converted", false),
                new HashEntry("admin", false),
                new HashEntry("mod", false),
                new HashEntry("mapEditor", false),
                new HashEntry("isAgeVerified", true),
                new HashEntry("verifiedEmail", true),
                // todo add more
            };
            Database.HashSet(accountKey, hashSet);
        }

        public static AccountModel LoadAccount(int accountId)
        {
            using var t = new TimedProfiler("LoadAccount");
            return new AccountModel(accountId, Database);
        }

        public static IEnumerable<int> GetAliveCharacters(int accountId)
        {
            foreach (var i in Database.SetMembers($"aliveCharacters.{accountId}"))
                yield return Convert.ToInt32(i, 0); // BitConverter.ToInt32(i, 0); might be important?
        }

        public static IEnumerable<CharacterModel> LoadCharacters(int accountId)
        {
            var aliveCharacters = GetAliveCharacters(accountId);
            foreach (var characterId in aliveCharacters)
                yield return new CharacterModel(accountId, characterId, Database);
        }

        private static int GetNextAccountId() => (int)Database.StringIncrement("nextAccountId");
    }
}
