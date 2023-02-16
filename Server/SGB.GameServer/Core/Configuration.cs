using SGB.GameServer.Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;

namespace SGB.GameServer.Core
{
    public static class Configuration
    {
        public static ConfigurationData GetConfiguration()
        {
            lock (SwapLock)
            {
                return ConfigurationData;
            }
        }

        public static ConfigurationData Initialize(string path)
        {
            ConfigurationPath = path;
            return ConfigurationData = ParseConfiguration();
        }

        private static ConfigurationData ParseConfiguration()
        {
            if (!File.Exists(ConfigurationPath))
                return null;

            var fileJson = File.ReadAllText(ConfigurationPath);
            try
            {
                return JsonSerializer.Deserialize<ConfigurationData>(fileJson, new JsonSerializerOptions()
                {
                    PropertyNameCaseInsensitive = true,
                });
            }
            catch (Exception ex)
            {
                DebugUtils.WriteLine($"[Configuration::ParseData()] {ex}");
            }
            return null;
        }

        // is this needed????? probably not lets do anyway
        public static async void ReloadAsync()
        {
            await Task.Run(() =>
            {
                var newConfigurationData = ParseConfiguration();
                lock (SwapLock)
                {
                    ConfigurationData = newConfigurationData;
                }
            });
        }

        private static string ConfigurationPath;
        private static ConfigurationData ConfigurationData;
        private static readonly object SwapLock = new object();
    }

    public sealed class ConfigurationData
    {
        public IOConfigurationData IOConfiguration { get; set; }
        public SessionConfigurationData SessionConfiguration { get; set; }
        public LoggingConfiguration LoggingConfiguration { get; set; }
        public RealmConfiguration RealmConfiguration { get; set; }
        public TestingConfiguration TestingConfiguration { get; set; }
    }

    public sealed class IOConfigurationData
    {
        public int StartingSessionCacheCount { get; set; }
        public int Port { get; set; }
        public int Backlog { get; set; }
    }

    public sealed class SessionConfigurationData
    {
        public int MaxSessions { get; set; }
    }

    public sealed class LoggingConfiguration
    {
        public bool EnableLogging { get; set; }
    }

    public sealed class RealmConfiguration
    {
        public int MaxPlayers { get; set; }
        public int MaxRealms { get; set; }
        public int StartingRealms { get; set; }
    }

    public class TestingConfiguration
    {
        public int StartingLevel { get; set; }
        public int StartingHealthPotions { get; set; }
        public int StartingMagicPotions { get; set; }
        public int PermanentFameAmount { get; set; }
        public int PermanentCreditAmount { get; set; }
        public List<StartingItem> StartingItems { get; set; }
    }

    public class StartingItem
    {
        public string IdName { get; set; }
        public string Weapon { get; set; }
        public string Ability { get; set; }
        public string Armor { get; set; }
        public string Ring { get; set; }
    }
}
