using StackExchange.Redis;
using System;
using System.Text;
using System.Net.Security;
using System.Security.Cryptography;

namespace SGB.API.Database
{
    public static class RedisService
    {
        private static IDatabase Database;
        private static ConnectionMultiplexer ConnectionMultiplexer;

        public static void Configure(string connectionString, int dbIndex)
        {
            ConnectionMultiplexer = ConnectionMultiplexer.Connect(connectionString);
            Database = ConnectionMultiplexer.GetDatabase(dbIndex);

            ValidateLogin("Test", "Test");
        }

        public static bool ValidateLogin(string guid, string password)
        {
            var guidLow = guid.ToLower();

            if (!Database.HashExists("logins", guidLow))
                return false;

            var hash = Database.HashGet("logins", guidLow);
            return hash == GetHashedPassword(password);
        }

        public static void FetchCharacterList()
        {
        }

        public static void LoadCharacter()
        {
        }

        public static void DeleteCharacter(int accountId, int characterId)
        {
        }

        private static void Verify(string username, string password)
        {
        }

        private static string GetHashedPassword(string password)
        {
            var salt = password[..(password.Length / 2)];

            var sb = new StringBuilder();

            using var md5 = MD5.Create();

            var computedBuffer = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
            var buffer = md5.ComputeHash(Encoding.UTF8.GetBytes(salt));

            for (var i = 0; i < buffer.Length; i++)
                _ = sb.Append(buffer[i].ToString("X2"));
            for (var i = 0; i < computedBuffer.Length; i++)
                _ = sb.Append(computedBuffer[i].ToString("X2"));
            for (var i = buffer.Length - 1; i >= 0; i--)
                if (i % 2 == 0)
                    _ = sb.Append(buffer[i].ToString("X2"));
            return sb.ToString();
        }
    }
}
