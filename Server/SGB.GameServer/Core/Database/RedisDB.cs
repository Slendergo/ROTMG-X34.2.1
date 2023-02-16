using SGB.Shared;
using StackExchange.Redis;
using System.Text.Json;

namespace SGB.GameServer.Core.Database
{
    public struct LoginModel
    {
        public int AccountId { get; set; }
        public string Hash { get; set; }
    }

    public sealed class RedisDB
    {
        private readonly ConnectionMultiplexer ConnectionMultiplexer;
        private readonly IDatabase Database;

        public RedisDB(string connectionString)
        {
            ConnectionMultiplexer = ConnectionMultiplexer.Connect(connectionString);
            Database = ConnectionMultiplexer.GetDatabase();
        }

        public int IsValidLogin(string guid, string password)
        {
            var guidLow = guid.ToLower();
            if (!Database.HashExists("logins", guidLow))
                return -1;

            var json = Database.HashGet("logins", guidLow);
            var login = JsonSerializer.Deserialize<LoginModel>(json);
            if (login.Hash != Hashing.GetHashedPassword(password))
                return -1;
            return login.AccountId;
        }
    }
}
