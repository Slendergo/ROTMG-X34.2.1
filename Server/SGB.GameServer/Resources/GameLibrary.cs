using SGB.Shared;
using System;
using System.Collections.Generic;
using System.IO;
using System.Xml.Linq;

namespace SGB.GameServer.Resources
{
    public static class GameLibrary
    {

        public static bool LoadFromFile(string path)
        {
            if (!Directory.Exists(path))
                return false;

            var files = Directory.EnumerateFiles(path, "*.xml", SearchOption.AllDirectories);
            foreach (var file in files)
            {
                var rootElem = XElement.Load(file);

                foreach (var elem in rootElem.Elements("Ground"))
                {
                    var tileProperties = new TileProperties(elem);
                    TileProperties[tileProperties.Type] = tileProperties;
                    TileIdTypeToType[tileProperties.IdName] = tileProperties.Type;
                    TypeToTileIdType[tileProperties.Type] = tileProperties.IdName;
                }

                foreach (var elem in rootElem.Elements("Object"))
                {
                    var objectProperties = new ObjectProperties(elem);
                    ObjectProperties[objectProperties.Type] = objectProperties;
                    ObjectIdTypeToType[objectProperties.IdName] = objectProperties.Type;
                    TypeToObjectIdType[objectProperties.Type] = objectProperties.IdName;
                }

                // todo dungeons
                // todo regions
                // todo stringlists
                // todo languages
            }
            return true;
        }

        private static Dictionary<int, TileProperties> TileProperties = new Dictionary<int, TileProperties>();
        private static Dictionary<string, int> TileIdTypeToType = new Dictionary<string, int>(StringComparer.InvariantCultureIgnoreCase);
        private static Dictionary<int, string> TypeToTileIdType = new Dictionary<int, string>();

        private static Dictionary<int, ObjectProperties> ObjectProperties = new Dictionary<int, ObjectProperties>();
        private static Dictionary<string, int> ObjectIdTypeToType = new Dictionary<string, int>(StringComparer.InvariantCultureIgnoreCase);
        private static Dictionary<int, string> TypeToObjectIdType = new Dictionary<int, string>();
    }

    public class TileProperties
    {
        public int Type;
        public string IdName;
        public bool NoWalk;

        public TileProperties(XElement elem)
        {
            Type = elem.IntAttribute("type");
            IdName = elem.StringAttribute("id");
            NoWalk = elem.BoolElement("NoWalk");
        }
    }

    public class ObjectProperties
    {
        public int Type;
        public string IdName;

        public ObjectProperties(XElement elem)
        {
            Type = elem.IntAttribute("type");
            IdName = elem.StringAttribute("id");
        }
    }
}
