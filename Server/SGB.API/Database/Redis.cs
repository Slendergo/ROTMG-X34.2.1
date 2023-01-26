using StackExchange.Redis;

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

        public static void ValidateLogin(string guid, string password)
        {
            // todo
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
    }
}
