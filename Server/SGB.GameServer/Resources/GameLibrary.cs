using SGB.GameServer.Resources.Properties;
using SGB.GameServer.Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace SGB.GameServer.Resources
{
    public static class GameLibrary
    {
        private static readonly Dictionary<int, XMLGround> XMLGrounds = new Dictionary<int, XMLGround>();
        private static readonly Dictionary<string, int> IdToGroundType = new Dictionary<string, int>(StringComparer.InvariantCultureIgnoreCase);
        private static readonly Dictionary<int, string> GroundTypeToId = new Dictionary<int, string>();
                        
        private static readonly Dictionary<int, XMLObject> XMLObjects = new Dictionary<int, XMLObject>();
        private static readonly Dictionary<string, int> IdToObjectType = new Dictionary<string, int>(StringComparer.InvariantCultureIgnoreCase);
        private static readonly Dictionary<int, string> ObjectTypeToId = new Dictionary<int, string>();
        private static readonly Dictionary<string, List<int>> Groups = new Dictionary<string, List<int>>();

        private static readonly Dictionary<string, XMLDungeon> XMLDungeons = new Dictionary<string, XMLDungeon>();

        public static bool LoadFromFile(string path)
        {
            if (!Directory.Exists(path))
                return false;

            try
            {
                var files = Directory.EnumerateFiles(path, "*.xml", SearchOption.AllDirectories);
                foreach (var file in files)
                {
                    var rootElem = XElement.Load(file);

                    foreach (var elem in rootElem.Elements("Ground"))
                    {
                        var xmlGround = new XMLGround(elem);
                        XMLGrounds[xmlGround.Type] = xmlGround;
                        IdToGroundType[xmlGround.IdName] = xmlGround.Type;
                        GroundTypeToId[xmlGround.Type] = xmlGround.IdName;
                    }

                    foreach (var elem in rootElem.Elements("Object"))
                    {
                        var xmlObject = new XMLObject(elem);
                        XMLObjects[xmlObject.Type] = xmlObject;
                        IdToObjectType[xmlObject.IdName] = xmlObject.Type;
                        ObjectTypeToId[xmlObject.Type] = xmlObject.IdName;

                        if (xmlObject.Group != string.Empty)
                        {
                            if (!Groups.ContainsKey(xmlObject.Group))
                                Groups[xmlObject.Group] = new List<int>();
                            Groups[xmlObject.Group].Add(xmlObject.Type);
                        }
                    }

                    foreach (var elem in rootElem.Elements("Dungeon"))
                    {
                        var xmlDungeon = new XMLDungeon(elem);
                        XMLDungeons[xmlDungeon.IdName] = xmlDungeon;
                    }

                    // todo regions
                    // todo stringlists
                    // todo languages
                    // other stuff
                }
            }
            catch (Exception ex)
            {
                Logger.LogDebug($"GameLibrary::LoadFromFile(): {ex}");
                return false;
            }
            return true;
        }

        public static List<string> GetNextAvailableObjectHexes(int amount = 1)
        {
            var lastAddedValue = 0;

            var list = new Dictionary<int, string>();
            for (var i = 0; i < amount; i++)
                for (var j = lastAddedValue + 1; j < int.MaxValue; j++)
                {
                    var hex = $"0x{j:X}";
                    if (XMLObjects.ContainsKey(j))
                        continue;
                    list.Add(j, hex);
                    lastAddedValue = j;
                    break;
                }
            return list.Values.ToList();
        }

        public static List<string> GetNextAvailableGroundHexes(int amount = 1)
        {
            var lastAddedValue = 0;

            var list = new Dictionary<int, string>();
            for (var i = 0; i < amount; i++)
                for (var j = lastAddedValue + 1; j < int.MaxValue; j++)
                {
                    var hex = $"0x{j:X}";
                    if (XMLGrounds.ContainsKey(j))
                        continue;
                    list.Add(j, hex);
                    lastAddedValue = j;
                    break;
                }
            return list.Values.ToList();
        }

        public static XMLDungeon XMLDungeonFromId(string id) => XMLDungeons.TryGetValue(id, out var ret) ? ret : null;

        public static XMLObject XMLObjectFromType(int type) => XMLObjects.TryGetValue(type, out var ret) ? ret : null;
        public static XMLObject XMLObjectFromId(string id) => XMLObjects.TryGetValue(ObjectTypeFromId(id), out var ret) ? ret : null;

        public static XMLGround XMLGroundFromType(int type) => XMLGrounds.TryGetValue(type, out var ret) ? ret : null;
        public static XMLGround XMLGroundFromId(string id) => XMLGrounds.TryGetValue(GroundTypeFromId(id), out var ret) ? ret : null;

        public static int ObjectTypeFromId(string id) => IdToObjectType.TryGetValue(id, out var ret) ? ret : -1;
        public static string IdFromObjectType(int type) => ObjectTypeToId.TryGetValue(type, out var ret) ? ret : string.Empty;

        public static int GroundTypeFromId(string id) => IdToGroundType.TryGetValue(id, out var ret) ? ret : -1;
        public static string IdFromGroundType(int type) => GroundTypeToId.TryGetValue(type, out var ret) ? ret : string.Empty;

        public static List<int> EnemyTypesFromGroup(string groupId) => Groups.TryGetValue(groupId, out var ret) ? ret : new List<int>();
    }
}
